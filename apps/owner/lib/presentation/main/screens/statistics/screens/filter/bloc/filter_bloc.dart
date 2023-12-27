import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/i_region_repository.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/presentation/main/screens/statistics/screens/filter/bloc/filter_event.dart';
import 'package:owner/utils/network/api_response.dart';

import 'filter_state.dart';

class FilterBloc extends BaseBloc<FilterEvent, FilterState> {
  FilterBloc(this.regionRepository, this.unitRepository) : super(const FilterState()) {
    on<GetRegions>(_getRegions);
    on<SetRegionEvent>(_setRegion);
    on<GetUnits>(_getUnits);
    on<SetUnitEvent>(_setUnit);
    on<AddStartDateEvent>(_addStartDate);
    on<AddEndDateEvent>(_addEndDate);
    on<SetStatisticsFilter>(_setStatisticsFilter);
    on<ResetFilter>(_resetFilter);
  }
  static final formKey = GlobalKey<FormState>();
  static final datesFormKey = GlobalKey<FormState>();
  final FocusNode unitFocus = FocusNode();
  final FocusNode startDateFocus = FocusNode();
  final FocusNode endDateFocus = FocusNode();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final IRegionRepository regionRepository;
  final IUnitRepository unitRepository;

  _addStartDate(AddStartDateEvent event, Emitter<FilterState> emit) async {
    String startDate = DateFormat.yMd(event.localeCode).format(event.startDate);
    startDateController.text = startDate;
    emit(state.copyWith(startDate: event.startDate));
    await Future.delayed(const Duration(milliseconds: 100));
    datesFormKey.currentState?.validate();
  }

  _addEndDate(AddEndDateEvent event, Emitter<FilterState> emit) async {
    String endDate = DateFormat.yMd(event.localeCode).format(event.endDate);
    endDateController.text = endDate;
    emit(state.copyWith(endDate: event.endDate));
    await Future.delayed(const Duration(milliseconds: 100));
    datesFormKey.currentState?.validate();
  }

  _setStatisticsFilter(SetStatisticsFilter event, Emitter<FilterState> emit) async {
    if (event.statisticsFilter != null) {
      String startDate = DateFormat.yMd(event.localeCode).format(event.statisticsFilter!.startDate!);
      String endDate = DateFormat.yMd(event.localeCode).format(event.statisticsFilter!.endData!);
      startDateController.text = startDate;
      endDateController.text = endDate;
      emit(state.copyWith(
          selectedUnit: event.statisticsFilter!.unit!,
          isFromFilter: true,
          selectedRegion: event.statisticsFilter!.region,
          startDate: event.statisticsFilter!.startDate!,
          endDate: event.statisticsFilter!.endData!));
    }
  }

  _getRegions(GetRegions event, Emitter<FilterState> emit) async {
    emit(state.copyWith(isUnitsLoading: true, isRegionLoading: true));
    ApiResponse apiResponse = await regionRepository.getOwnerRegions();
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> regions = apiResponse.data.data;
            Region? selectedRegion = regions[0];
            regionController.text = selectedRegion.name ?? "";
            if (state.selectedRegion != null) {
              selectedRegion = state.selectedRegion;
            }
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

  _setRegion(SetRegionEvent event, Emitter<FilterState> emit) async {
    regionController.text = event.selectedRegion.name ?? "";
    emit(state.copyWith(selectedRegion: event.selectedRegion));
    add(const GetUnits());
  }

  _setUnit(SetUnitEvent event, Emitter<FilterState> emit) async {
    emit(state.copyWith(selectedUnit: event.selectedUnit));
    unitController.text = event.selectedUnit.title!;
  }

  _resetFilter(ResetFilter event, Emitter<FilterState> emit) async {
    unitController.text = state.units?.first.title ?? "";
    startDateController.text = "";
    endDateController.text = "";
    emit(FilterState(
        regions: state.regions,
        units: state.units,
        selectedRegion: state.regions?.first,
        selectedUnit: state.units?.first,
        startDate: null,
        endDate: null,
        isRegionLoading: false,
        isUnitsLoading: false,
        hasUnit: true));
    if (state.selectedRegion!.id != state.regions!.first.id) {
      add(GetUnits());
    }
  }

  FutureOr<void> _getUnits(GetUnits event, Emitter<FilterState> emit) async {
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
              Unit? selectedUnit = units.isNotEmpty ? units.first : null;
              if (state.selectedUnit != null && state.isFromFilter) {
                selectedUnit = state.selectedUnit;
              }
              emit(
                  state.copyWith(units: units, isUnitsLoading: false, selectedUnit: selectedUnit, isFromFilter: false));
              unitController.text = selectedUnit!.title!;
            }
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }
}
