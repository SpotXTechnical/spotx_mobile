import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/i_region_repository.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_fourth_screen/edit_unit_fourth_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';

import 'edit_unit_third_event.dart';
import 'edit_unit_third_state.dart';

class EditUnitThirdBloc extends BaseBloc<EditUnitThirdEvent, EditUnitThirdState> {
  EditUnitThirdBloc(this.regionsRepository, this.unitRepository) : super(EditUnitThirdEmptyState()) {
    on<AddCheckInTime>(_addCheckInTime);
    on<AddCheckOutTime>(_addCheckOutTime);
    on<GetRegionsWithSubRegion>(_getRegions);
    on<SetRegion>(_setRegion);
    on<SetSelectedSubRegion>(_setSubRegion);
    on<IncrementRoomNumberEvent>(_incrementRoomNumber);
    on<DecrementRoomNumberEvent>(_decrementRoomNumber);
    on<IncrementBedNumberEvent>(_incrementBedNumber);
    on<DecrementBedNumberEvent>(_decrementBedNumber);
    on<MoveToFourthScreenEvent>(_moveToFourthScreen);
    on<IncrementBathNumberEvent>(_incrementBathNumber);
    on<DecrementBathNumberEvent>(_decrementBathNumber);
    on<IncrementGuestsNumberEvent>(_incrementGuestNumber);
    on<DecrementGuestsNumberEvent>(_decrementGuestNumber);
    on<InitEditUnitThirdScreen>(_initScreen);
    on<GetSubRegions>(_getSubRegions);
    on<LoadMoreSubRegions>(_loadMoreSubRegions);
    on<GetSubRegionById>(_getSubRegionById);
    on<GetRegionBySubRegionId>(_getRegionBySubRegionId);
    on<ThirdScreenUpdateUnit>(_updateUnit);
  }

  int page = 1;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  final IRegionRepository regionsRepository;

  static final formKey = GlobalKey<FormState>();
  static final subRegionFormKey = GlobalKey<FormState>();

  final FocusNode checkInTimeFocus = FocusNode();
  final FocusNode checkOutTimeFocus = FocusNode();

  final TextEditingController checkInTimeController = TextEditingController();
  final TextEditingController checkOutTimeController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController subRegionController = TextEditingController();

  final IUnitRepository unitRepository;

  _addCheckInTime(AddCheckInTime event, Emitter<EditUnitThirdState> emit) {
    emit(state.copyWith(checkIn: event.checkInTime));
    checkInTimeController.text = event.checkInString;
  }

  _initScreen(InitEditUnitThirdScreen event, Emitter<EditUnitThirdState> emit) async {
    checkOutTimeController.text = event.checkOutString;
    checkInTimeController.text = event.checkInString;

    emit(state.copyWith(
      checkIn: event.checkIn,
      checkOut: event.checkOut,
      unit: event.unit,
      roomNumber: int.parse(event.unit.bedRooms!),
      bedNumber: int.parse(event.unit.beds!),
      bathNumber: int.parse(event.unit.bathRooms!),
      guestsNumber: int.parse(event.unit.maxNumberOfGuests??'5')
    ));
  }

  _addCheckOutTime(AddCheckOutTime event, Emitter<EditUnitThirdState> emit) {
    emit(state.copyWith(checkOut: event.checkOutTime));
    checkOutTimeController.text = event.checkOutString;
  }

  _setRegion(SetRegion event, Emitter<EditUnitThirdState> emit) {
    //List<Region>? subRegions = state.regions?.firstWhere((element) => element.id == event.region.id).subRegions;
    List<Region>? subRegions = event.region.subRegions;
    regionController.text = event.region.name ?? "";
    subRegionController.text = "";
    add(GetSubRegions(regionId: event.region.id.toString()));
    emit(state.copyWith(
      selectedRegion: event.region,
      subRegions: subRegions,
      isSubRegionsLoading: true,
    )..selectedSubRegion = null);
  }

  _getSubRegions(GetSubRegions event, Emitter<EditUnitThirdState> emit) async {
    page = 1;
    emit(state.copyWith(isSubRegionsLoading: true));
    ApiResponse apiResponse = await regionsRepository.getSubRegions(regionsIds: [event.regionId], page: page);

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> subRegions = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > subRegions.length;
            emit(state.copyWith(
                subRegions: subRegions,
                hasMoreSubRegions: hasMore,
                isSubRegionsLoading: false,
                hideSubRegionsSection: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isGetRegionsAndSubRegionsApiError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
          }
        });
  }

  _loadMoreSubRegions(LoadMoreSubRegions event, Emitter<EditUnitThirdState> emit) async {
    page++;
    ApiResponse apiResponse = await regionsRepository.getSubRegions(regionsIds: [event.regionId], page: page);

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            if (apiResponse.data != null) {
              List<Region> subRegions = apiResponse.data.data;
              List<Region> allSubRegions = [...?state.subRegions, ...subRegions];
              bool? hasMore;
              if (apiResponse.data.meta?.total != null) {
                hasMore = apiResponse.data.meta?.total > subRegions.length;
              }
              emit(state.copyWith(subRegions: allSubRegions, hasMoreSubRegions: hasMore, isSubRegionsLoading: false));
            }
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isGetRegionsAndSubRegionsApiError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
          }
        });
  }

  _setSubRegion(SetSelectedSubRegion event, Emitter<EditUnitThirdState> emit) {
    subRegionController.text = event.subRegion.name ?? "";
    emit(state.copyWith(selectedSubRegion: event.subRegion));
  }

  _incrementRoomNumber(IncrementRoomNumberEvent event, Emitter<EditUnitThirdState> emit) {
    var roomNumber = state.roomNumber;
    roomNumber++;
    emit(state.copyWith(roomNumber: roomNumber));
  }

  _decrementRoomNumber(DecrementRoomNumberEvent event, Emitter<EditUnitThirdState> emit) {
    var roomNumber = state.roomNumber;
    roomNumber--;
    emit(state.copyWith(roomNumber: roomNumber));
  }

  _incrementBedNumber(IncrementBedNumberEvent event, Emitter<EditUnitThirdState> emit) {
    var bedNumber = state.bedNumber;
    bedNumber++;
    emit(state.copyWith(bedNumber: bedNumber));
  }

  _decrementBedNumber(DecrementBedNumberEvent event, Emitter<EditUnitThirdState> emit) {
    var bedNumber = state.bedNumber;
    bedNumber--;
    emit(state.copyWith(bedNumber: bedNumber));
  }

  _incrementBathNumber(IncrementBathNumberEvent event, Emitter<EditUnitThirdState> emit) {
    var bathNumbers = state.bathNumber;
    bathNumbers++;
    emit(state.copyWith(bathNumber: bathNumbers));
  }

  _decrementBathNumber(DecrementBathNumberEvent event, Emitter<EditUnitThirdState> emit) {
    var bathNumbers = state.bathNumber;
    bathNumbers--;
    emit(state.copyWith(bathNumber: bathNumbers));
  }

  FutureOr<void> _getRegions(GetRegionsWithSubRegion event, Emitter<EditUnitThirdState> emit) async {
    emit(state.copyWith(isSubRegionsLoading: true, isRegionsLoading: true));
    ApiResponse apiResponse = await regionsRepository.getRegions(withoutSubRegion);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Region? selectedRegion;
            Region? selectedSubRegion;
            List<Region>? subRegions;
            List<Region> regions = apiResponse.data.data;
            if (state.unit?.regionId != null) {
              for (var region in regions) {
                if (region.id.toString() == state.unit!.regionId) {
                  selectedRegion = region;
                  selectedSubRegion = null;
                }
              }
              if (selectedRegion == null) {
                add(GetSubRegionById(subRegionId: state.unit!.regionId!));
                add(GetRegionBySubRegionId(subRegionId: state.unit!.regionId!));
              }
            }
            if (selectedRegion != null) {
              regionController.text = selectedRegion.name ?? "";
            }
            if (selectedSubRegion != null) {
              subRegionController.text = selectedSubRegion.name ?? "";
            }
            emit(state.copyWith(
                selectedSubRegion: selectedSubRegion,
                selectedRegion: selectedRegion,
                regions: regions,
                subRegions: subRegions,
                isSubRegionsLoading: false,
                isRegionsLoading: selectedRegion == null));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isGetRegionsAndSubRegionsApiError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _getRegionBySubRegionId(GetRegionBySubRegionId event, Emitter<EditUnitThirdState> emit) async {
    emit(state.copyWith(isSubRegionsLoading: true));
    ApiResponse apiResponse = await regionsRepository.getRegionBySubRegionId(int.parse(event.subRegionId));

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Region region = apiResponse.data.data;
            regionController.text = region.name ?? "";
            emit(state.copyWith(selectedRegion: region, isRegionsLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isGetRegionsAndSubRegionsApiError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
          }
        });
  }

  _getSubRegionById(GetSubRegionById event, Emitter<EditUnitThirdState> emit) async {
    emit(state.copyWith(isSubRegionsLoading: true));
    ApiResponse apiResponse = await regionsRepository.getRegionById(int.parse(event.subRegionId));

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Region region = apiResponse.data.data;
            subRegionController.text = region.name ?? "";
            emit(state.copyWith(isSubRegionsLoading: false, selectedSubRegion: region));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isGetRegionsAndSubRegionsApiError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
          }
        });
  }

  _moveToFourthScreen(MoveToFourthScreenEvent event, Emitter<EditUnitThirdState> emit) async {
    var result = await navigationKey.currentState?.pushNamed(EditUnitFourthScreen.tag, arguments: state.unit) as Unit;
    emit(state.copyWith(unit: result));
  }

  _updateUnit(ThirdScreenUpdateUnit event, Emitter<EditUnitThirdState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await unitRepository.updateUnit(getUnitWithChangedData());
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          emit(state.copyWith(isLoading: false));
          updateUnitReference(state.unit);
          Fluttertoast.showToast(
              msg: LocaleKeys.unitUpdatedSuccessfully.tr(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: pacificBlue,
              textColor: kWhite);
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isLoading: false));
            showErrorMsg(apiResponse.error?.errorMsg ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _incrementGuestNumber(IncrementGuestsNumberEvent event, Emitter<EditUnitThirdState> emit) {
    var guestsNumber = state.guestsNumber;
    guestsNumber++;
    emit(state.copyWith(guestsNumber: guestsNumber));
  }

  FutureOr<void> _decrementGuestNumber(DecrementGuestsNumberEvent event, Emitter<EditUnitThirdState> emit) {
    var guestsNumber = state.guestsNumber;
    guestsNumber--;
    emit(state.copyWith(guestsNumber: guestsNumber));
  }

  void updateUnitReference(Unit? referenceUnit) {
    referenceUnit?.bedRooms = state.roomNumber.toString();
    referenceUnit?.bathRooms = state.bathNumber.toString();
    referenceUnit?.beds = state.bedNumber.toString();
    referenceUnit?.maxNumberOfGuests = state.guestsNumber.toString();
    referenceUnit?.checkIn = timeToString(state.checkIn!);
    referenceUnit?.checkOut = timeToString(state.checkOut!);
    referenceUnit?.regionId = (state.selectedSubRegion != null)
        ? state.selectedSubRegion?.id.toString()
        : state.selectedRegion?.id.toString();
  }

  Unit getUnitWithChangedData() {
    Unit unit = Unit(id: state.unit!.id);
    TimeOfDay checkIn = parseTime(state.unit?.checkIn);
    TimeOfDay checkOut = parseTime(state.unit?.checkOut);
    bool isRegionIdChanged = state.selectedRegion?.id.toString() != state.unit?.regionId;
    if (state.selectedSubRegion != null) {
      isRegionIdChanged = state.selectedSubRegion?.id.toString() != state.unit?.regionId;
    }
    if (checkInTimeController.text.trim() != checkIn.format(navigationKey.currentContext!)) {
      unit.checkIn = timeToString(state.checkIn!);
    }
    if (checkOutTimeController.text.trim() != checkOut.format(navigationKey.currentContext!)) {
      unit.checkOut = timeToString(state.checkOut!);
    }
    if (isRegionIdChanged) {
      unit.regionId = (state.selectedSubRegion != null)
          ? state.selectedSubRegion?.id.toString()
          : state.selectedRegion?.id.toString();
    }
    if (state.roomNumber.toString() != state.unit?.bedRooms) {
      unit.bedRooms = state.roomNumber.toString();
    }
    if (state.guestsNumber.toString() != state.unit?.maxNumberOfGuests) {
      unit.maxNumberOfGuests = state.guestsNumber.toString();
    }
    if (state.bedNumber.toString() != state.unit?.beds) {
      unit.beds = state.bedNumber.toString();
    }

    if (state.bathNumber.toString() != state.unit?.bathRooms) {
      unit.bathRooms = state.bathNumber.toString();
    }
    return unit;
  }
}