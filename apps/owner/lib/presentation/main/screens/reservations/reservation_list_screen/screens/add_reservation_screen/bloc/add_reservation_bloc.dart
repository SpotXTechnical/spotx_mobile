import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/local/shared_prefs_manager.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/data/remote/region/i_region_repository.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/data/remote/reservation/i_reservation_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/add_reservation_screen/models/add_reservation_config.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';

import 'add_reservation_event.dart';
import 'add_reservation_state.dart';

class AddReservationBloc extends BaseBloc<AddReservationEvent, AddReservationState> {
  AddReservationBloc(this.regionRepository, this.unitRepository, this.reservationRepository)
      : super(const AddReservationState()) {
    on<GetRegions>(_getRegions);
    on<SetRegionEvent>(_setRegion);
    on<GetUnits>(_getUnits);
    on<SetUnitEvent>(_setUnit);
    on<PostReservationEvent>(_postReservation);
    on<HideError>(_hideError);
    on<AddStartDateEvent>(_addStartDate);
    on<AddEndDateEvent>(_addEndDate);
  }
  static final formKey = GlobalKey<FormState>();
  static final datesFormKey = GlobalKey<FormState>();

  final FocusNode phoneFocus = FocusNode();
  final FocusNode unitFocus = FocusNode();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final IRegionRepository regionRepository;
  final IUnitRepository unitRepository;
  final IReservationRepository reservationRepository;

  final FocusNode guestNameFocus = FocusNode();

  final FocusNode startDateFocus = FocusNode();
  final TextEditingController startDateController = TextEditingController();

  final FocusNode endDateFocus = FocusNode();
  final TextEditingController endDateController = TextEditingController();

  final FocusNode priceFocus = FocusNode();

  _getRegions(GetRegions event, Emitter<AddReservationState> emit) async {
    if (event.config != null) {
      emit(state.copyWith(addReservationConfig: event.config));
    } else {
      emit(state.copyWith(isUnitsLoading: true, isRegionLoading: true));
      ApiResponse apiResponse = await regionRepository.getOwnerRegions();
      await handleResponse(
          result: apiResponse,
          onSuccess: () {
            if (apiResponse.data != null) {
              List<Region> regions = apiResponse.data.data;
              Region? selectedRegion = regions[0];
              regionController.text = selectedRegion.name ?? "";
              emit(state.copyWith(regions: regions, selectedRegion: selectedRegion, isRegionLoading: false));
              add(const GetUnits());
            }
          },
          onFailed: () {
            if (apiResponse.error != null) {
              showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
            }
          });
    }
  }

  _addStartDate(AddStartDateEvent event, Emitter<AddReservationState> emit) async {
    emit(state.copyWith(startDate: event.startDate));
    startDateController.text = event.startDateString;
    await Future.delayed(const Duration(milliseconds: 100));
    if (state.endDate != null) {
      datesFormKey.currentState?.validate();
    }
  }

  _addEndDate(AddEndDateEvent event, Emitter<AddReservationState> emit) async {
    emit(state.copyWith(endDate: event.endDate));
    endDateController.text = event.endDateString;
    await Future.delayed(const Duration(milliseconds: 100));
    if (state.startDate != null) {
      datesFormKey.currentState?.validate();
    }
  }

  _setRegion(SetRegionEvent event, Emitter<AddReservationState> emit) async {
    regionController.text = event.selectedRegion.name ?? "";
    emit(state.copyWith(selectedRegion: event.selectedRegion));
    add(const GetUnits());
  }

  _setUnit(SetUnitEvent event, Emitter<AddReservationState> emit) async {
    AddReservationConfig config = AddReservationConfig(event.selectedUnit.id!, UnitType.chalet.name);
    emit(state.copyWith(addReservationConfig: config));
  }

  _hideError(HideError event, Emitter<AddReservationState> emit) {
    emit(AddReservationState(
        units: state.units,
        regions: state.regions,
        addReservationConfig: state.addReservationConfig,
        selectedRegion: state.selectedRegion,
        startDate: state.startDate,
        endDate: state.endDate));
  }

  FutureOr<void> _getUnits(GetUnits event, Emitter<AddReservationState> emit) async {
    emit(state.copyWith(isUnitsLoading: true));
    ApiResponse apiResponse = await unitRepository.getUnits(FilterQueries(regions: [state.selectedRegion!.id!]));
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            if (units.isEmpty) {
              emit(state.copyWith(hasUnit: false));
            } else {
              emit(state.copyWith(
                  units: units,
                  isUnitsLoading: false,
                  addReservationConfig: AddReservationConfig(units.first.id!, UnitType.chalet.name)));
              unitController.text = units.first.title!;
            }
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _postReservation(PostReservationEvent event, Emitter<AddReservationState> emit) async {
    emit(state.copyWith(isLoading: true));
    String? startDate;
    String? endDate;
    if (isArabic) {
      final start = DateFormat.yMd("ar").parseLoose(startDateController.text);
      final end = DateFormat.yMd("ar").parseLoose(endDateController.text);
      startDate = DateFormat.yMd("en").format(start);
      endDate = DateFormat.yMd("en").format(end);
    }
    final credentials =  Injector().get<SharedPrefsManager>().credentials;
    ApiResponse apiResponse = await reservationRepository.postReservation(
        startDate ?? startDateController.text,
        endDate ?? endDateController.text,
        "",
        state.addReservationConfig!.id,
        state.addReservationConfig!.type,
        User(name:  credentials?.user?.name ?? " ", phone: credentials?.user?.phone ?? " " ));
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            emit(state.copyWith(isLoading: false));
            Fluttertoast.showToast(
                msg: LocaleKeys.postReservationMessage.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            navigationKey.currentState?.pop();
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isLoading: false));
            if (apiResponse.error?.extra != null) {
              Fluttertoast.showToast(
                  msg: LocaleKeys.addNewReservationErrorMessage.tr(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
            }
          }
        });
  }
}