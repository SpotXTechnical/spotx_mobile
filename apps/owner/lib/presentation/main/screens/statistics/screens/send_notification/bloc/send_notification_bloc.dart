import 'dart:async';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/i_region_repository.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/data/remote/statistics/i_statistics_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/send_notification/bloc/send_notification_event.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/style/theme.dart';

import 'send_notification_state.dart';

class SendNotificationBloc extends BaseBloc<SendNotificationEvent, SendNotificationState> {
  SendNotificationBloc(this.regionRepository, this.unitRepository, this.statisticsRepository)
      : super(const SendNotificationState()) {
    on<GetRegions>(_getRegions);
    on<SetRegionEvent>(_setRegion);
    on<GetUnits>(_getUnits);
    on<SetUnitEvent>(_setUnit);
    on<PostNotificationsEvent>(_postNotification);
    on<HideError>(_hideError);
    on<ToggleAllRegions>(_toggleAllRegions);
  }
  static final formKey = GlobalKey<FormState>();
  final FocusNode messageFocus = FocusNode();
  final FocusNode unitFocus = FocusNode();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final IRegionRepository regionRepository;
  final IUnitRepository unitRepository;
  final IStatisticsRepository statisticsRepository;

  _getRegions(GetRegions event, Emitter<SendNotificationState> emit) async {
    emit(state.copyWith(isUnitsLoading: true, isRegionLoading: true));
    ApiResponse apiResponse = await regionRepository.getOwnerRegions();
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> regions = apiResponse.data.data;
            emit(state.copyWith(regions: regions, isRegionLoading: false));
            add(const GetUnits());
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _setRegion(SetRegionEvent event, Emitter<SendNotificationState> emit) async {
    emit(state.copyWith(selectedRegionId: event.selectedRegionId, isAllRegionsSelected: false));
    add(const GetUnits());
  }

  _toggleAllRegions(ToggleAllRegions event, Emitter<SendNotificationState> emit) async {
    emit(state.copyWith(isAllRegionsSelected: true, selectedRegionId: 0));
    add(const GetUnits());
  }

  _setUnit(SetUnitEvent event, Emitter<SendNotificationState> emit) async {
    unitController.text = event.selectedUnit.title!;
    emit(state.copyWith(selectedUnit: event.selectedUnit));
  }

  _hideError(HideError event, Emitter<SendNotificationState> emit) {
    emit(SendNotificationState(
        units: state.units,
        regions: state.regions,
        selectedUnit: state.selectedUnit,
        selectedRegionId: state.selectedRegionId));
  }

  FutureOr<void> _getUnits(GetUnits event, Emitter<SendNotificationState> emit) async {
    emit(state.copyWith(isUnitsLoading: true));
    ApiResponse apiResponse = await unitRepository.getUnits(FilterQueries(
        regions: state.isAllRegionsSelected ? state.regions!.map((e) => e.id!).toList() : [state.selectedRegionId!]));
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            if (units.isEmpty) {
              emit(state.copyWith(hasUnit: false, isUnitsLoading: false));
            } else {
              emit(state.copyWith(units: units, isUnitsLoading: false, selectedUnit: units.first, hasUnit: true));
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

  _postNotification(PostNotificationsEvent event, Emitter<SendNotificationState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await statisticsRepository.postNotifications(
        messageController.text,
        state.selectedUnit!.id == "0" ? null : state.selectedUnit!.id!,
        state.isAllRegionsSelected
            ? state.regions!.map((e) => e.id.toString()).toList()
            : [state.selectedRegionId.toString()]);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            emit(state.copyWith(isLoading: false));
            Fluttertoast.showToast(
                msg: LocaleKeys.postNotificationsSuccessMessage.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            navigationKey.currentState?.pop();
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isLoading: false));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }
}