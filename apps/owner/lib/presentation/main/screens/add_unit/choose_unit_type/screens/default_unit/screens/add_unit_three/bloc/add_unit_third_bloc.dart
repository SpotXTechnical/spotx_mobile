import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/region/i_region_repository.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_four/add_unit_fourth_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/utils.dart';

import 'add_unit_third_event.dart';
import 'add_unit_third_state.dart';

class AddUnitThirdBloc extends BaseBloc<AddUnitThirdEvent, AddUnitThirdState> {
  AddUnitThirdBloc(this.regionsRepository) : super(AddUnitThirdEmptyState()) {
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
    on<GetRegionById>(_getRegionById);
    checkOutTimeController.text = state.checkOut?.format(navigationKey.currentContext!)??'';
    checkInTimeController.text = state.checkIn?.format(navigationKey.currentContext!)??'';
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

  _addCheckInTime(AddCheckInTime event, Emitter<AddUnitThirdState> emit) {
    emit(state.copyWith(checkIn: event.checkInTime));
    checkInTimeController.text = event.checkInString;
  }

  _addCheckOutTime(AddCheckOutTime event, Emitter<AddUnitThirdState> emit) {
    emit(state.copyWith(checkOut: event.checkOutTime));
    checkOutTimeController.text = event.checkOutString;
  }

  _setRegion(SetRegion event, Emitter<AddUnitThirdState> emit) {
    //List<Region>? subRegions = state.regions?.firstWhere((element) => element.id == event.region.id).subRegions;
    List<Region>? subRegions = event.region.subRegions;
    regionController.text = event.region.name ?? "";
    subRegionController.text = "";
    emit(state.copyWith(
      selectedRegion: event.region,
      subRegions: subRegions,
    )..selectedSubRegion = null);
  }

  _setSubRegion(SetSelectedSubRegion event, Emitter<AddUnitThirdState> emit) {
    subRegionController.text = event.subRegion.name ?? "";
    emit(state.copyWith(selectedSubRegion: event.subRegion));
  }

  _incrementRoomNumber(IncrementRoomNumberEvent event, Emitter<AddUnitThirdState> emit) {
    var roomNumber = state.roomNumber;
    roomNumber++;
    emit(state.copyWith(roomNumber: roomNumber));
  }

  _decrementRoomNumber(DecrementRoomNumberEvent event, Emitter<AddUnitThirdState> emit) {
    var roomNumber = state.roomNumber;
    roomNumber--;
    emit(state.copyWith(roomNumber: roomNumber));
  }

  _incrementBedNumber(IncrementBedNumberEvent event, Emitter<AddUnitThirdState> emit) {
    var bedNumber = state.bedNumber;
    bedNumber++;
    emit(state.copyWith(bedNumber: bedNumber));
  }

  _decrementBedNumber(DecrementBedNumberEvent event, Emitter<AddUnitThirdState> emit) {
    var bedNumber = state.bedNumber;
    bedNumber--;
    emit(state.copyWith(bedNumber: bedNumber));
  }

  _incrementBathNumber(IncrementBathNumberEvent event, Emitter<AddUnitThirdState> emit) {
    var bathNumbers = state.bathNumber;
    bathNumbers++;
    emit(state.copyWith(bathNumber: bathNumbers));
  }

  _decrementBathNumber(DecrementBathNumberEvent event, Emitter<AddUnitThirdState> emit) {
    var bathNumbers = state.bathNumber;
    bathNumbers--;
    emit(state.copyWith(bathNumber: bathNumbers));
  }

  FutureOr<void> _getRegions(GetRegionsWithSubRegion event, Emitter<AddUnitThirdState> emit) async {
    emit(state.copyWith(isSubRegionsLoading: true));
    ApiResponse apiResponse = await regionsRepository.getRegions(withoutSubRegion);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> regions = apiResponse.data.data;
            emit(state.copyWith(regions: regions, isSubRegionsLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isGetRegionsAndSubRegionsApiError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _getRegionById(GetRegionById event, Emitter<AddUnitThirdState> emit) async {
    emit(state.copyWith(isSubRegionsLoading: true));
    ApiResponse apiResponse = await regionsRepository.getRegionById(int.parse(event.regionId));

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Region subregion = apiResponse.data.data;
            subRegionController.text = subregion.name ?? "";
            emit(state.copyWith(isSubRegionsLoading: false, selectedSubRegion: subregion));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isGetRegionsAndSubRegionsApiError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
          }
        });
  }

  _moveToFourthScreen(MoveToFourthScreenEvent event, Emitter<AddUnitThirdState> emit) {
    event.unit.bedRooms = state.roomNumber.toString();
    event.unit.bathRooms = state.bathNumber.toString();
    event.unit.beds = state.bedNumber.toString();
    event.unit.maxNumberOfGuests = state.guestsNumber.toString();
    event.unit.checkIn = timeToString(state.checkIn!);
    event.unit.checkOut = timeToString(state.checkOut!);
    event.unit.regionId = (state.selectedSubRegion != null)
        ? state.selectedSubRegion?.id.toString()
        : state.selectedRegion?.id.toString();

    navigationKey.currentState?.pushNamed(AddUnitFourthScreen.tag, arguments: event.unit);
  }

  FutureOr<void> _incrementGuestNumber(IncrementGuestsNumberEvent event, Emitter<AddUnitThirdState> emit) {
    var guestsNumber = state.guestsNumber;
    guestsNumber++;
    emit(state.copyWith(guestsNumber: guestsNumber));
  }

  FutureOr<void> _decrementGuestNumber(DecrementGuestsNumberEvent event, Emitter<AddUnitThirdState> emit) {
    var guestsNumber = state.guestsNumber;
    guestsNumber--;
    emit(state.copyWith(guestsNumber: guestsNumber));
  }
}
