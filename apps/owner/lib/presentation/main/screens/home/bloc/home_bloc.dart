import 'dart:async';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/auth/i_auth_repository.dart';
import 'package:owner/data/remote/region/i_region_repository.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/bloc/choose_unit_type_state.dart';
import 'package:owner/presentation/main/screens/home/bloc/home_event.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/observation_managers/home_observable_single_tone.dart';
import 'package:owner/utils/style/theme.dart';

import '../../../../../data/remote/auth/models/login_response_entity.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> implements HomeObservable {
  HomeBloc(this.unitRepository, this.regionRepository, this.authRepository) : super(const HomeState()) {
    HomeObservableSingleTone().set(this);
    on<GetHomeCampsEvent>(_getHomeCamps);
    on<GetRegionsEvent>(_getRegions);
    on<GetRegionUnitsEvent>(_getRegionUnits);
    on<SelectAllRegions>(_selectAllRegions);
    on<GetUnitById>(_getUnitById);
    on<DeleteUnit>(_deleteUnit);
    on<GetUserEvent>(_getUser);
  }

  final IUnitRepository unitRepository;
  final IRegionRepository regionRepository;
  final IAuthRepository authRepository;

  int page = 1;

  FutureOr<void> _getHomeCamps(GetHomeCampsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isCampsLoading: true));
    ApiResponse apiResponse = await unitRepository.getUnits(FilterQueries(type: UnitType.camp.name));
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            if (units.isEmpty) {
              emit(state.copyWith(isCampsEmpty: true));
            } else if (units.length == 1) {
              add(GetUnitById(units[0].id!));
            } else {
              emit(state.copyWith(camps: units, isCampsLoading: false));
            }
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _getUnitById(GetUnitById event, Emitter<HomeState> emit) async {
    ApiResponse apiResponse = await unitRepository.getUnitById(event.id);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Unit camp = apiResponse.data.data;
            emit(state.copyWith(
                camp: camp, isOnlyOneCamp: true, isCampLoading: false, isCampsLoading: false, isCampsEmpty: true));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _getUser(GetUserEvent event, Emitter<HomeState> emit) async {
    ApiResponse apiResponse = await authRepository.getUser();
    handleResponse(
      result: apiResponse,
      onSuccess: () {
        if (apiResponse.data != null) {
          User user = apiResponse.data.data;
          emit(state.copyWith(user: user));
        }
      },
      onFailed: () {
        if (apiResponse.error != null) {
          showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
        }
      }
    );
  }

  FutureOr<void> _deleteUnit(DeleteUnit event, Emitter<HomeState> emit) async {
    ApiResponse apiResponse = await unitRepository.deleteUnit(event.id);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            add(GetRegionUnitsEvent(state.selectedRegionId!));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            Fluttertoast.showToast(
                msg: LocaleKeys.deleteErrorMessage.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: pacificBlue,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        });
  }

  FutureOr<void> _getRegions(GetRegionsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isRegionsLoading: true));
    ApiResponse apiResponse = await regionRepository.getOwnerRegions();
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> regions = apiResponse.data.data;
            if (regions.isEmpty) {
              emit(state.copyWith(isRegionsEmpty: true));
            } else {
              emit(state.copyWith(regions: regions, isRegionsLoading: false));
            }
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _getRegionUnits(GetRegionUnitsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isRegionUnitsLoading: true, selectedRegionId: event.regionId, isAllRegionsSelected: false));
    ApiResponse apiResponse =
        await unitRepository.getUnits(FilterQueries(regions: event.regionId, escapePagination: 1, type: chalet));
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            emit(state.copyWith(regionUnits: units, isRegionUnitsLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _selectAllRegions(SelectAllRegions event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isRegionUnitsLoading: true, isAllRegionsSelected: true, selectedRegionId: []));
    ApiResponse apiResponse =
        await unitRepository.getUnits(FilterQueries(regions: createRegionIdList(), escapePagination: 1, type: chalet));
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            emit(state.copyWith(regionUnits: units, isRegionUnitsLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  List<int> createRegionIdList() {
    List<int> idsList = List.empty(growable: true);
    state.regions?.forEach((element) {
      idsList.add(element.id!);
    });
    return idsList;
  }

  @override
  void updateSelectedRegionsUnit() {
    add(const GetHomeCampsEvent());
    add(const GetRegionsEvent());
    add(const SelectAllRegions());
  }

  @override
  Future<void> close() {
    HomeObservableSingleTone().remove(this);
    return super.close();
  }
}
