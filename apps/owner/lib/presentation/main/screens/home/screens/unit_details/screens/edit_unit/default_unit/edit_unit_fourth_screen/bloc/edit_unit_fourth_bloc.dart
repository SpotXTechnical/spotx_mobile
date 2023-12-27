import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/feature_entity.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/main_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/observation_managers/home_observable_single_tone.dart';
import 'package:owner/utils/style/theme.dart';
import 'edit_unit_fourth_event.dart';
import 'edit_unit_fourth_state.dart';

class EditUnitFourthBloc extends BaseBloc<EditUnitFourthEvent, EditUnitFourthState> {
  EditUnitFourthBloc(this.addUnitRepository) : super(const EditUnitFourthState()) {
    on<ChangeFeatureStateEvent>(_changeFeatureState);
    on<GetFeaturesEvent>(_getFeatures);
    on<FourthScreenUpdateUnit>(_updateUnit);
    on<InitFeaturesScreen>(_initScreen);
  }

  final IUnitRepository addUnitRepository;

  _changeFeatureState(ChangeFeatureStateEvent event, Emitter<EditUnitFourthState> emit) {
    List<Feature>? features = state.features;
    List<Feature> newList = Feature.createFeature(features!);
    newList.firstWhere((element) => element.id == event.feature.id).isSelected = !event.feature.isSelected;
    emit(state.copyWith(features: newList));
  }

  bool areFeaturesUpdated(List<Feature>? selectedFeatures) {
    bool isUpdated = false;
    if (selectedFeatures != null) {
      state.unit?.features?.forEach((element) {
        if (!selectedFeatures.map((e) => e.id).contains(element.id)) {
          isUpdated = true;
        }
      });
    }
    return state.unit?.features?.length != selectedFeatures?.length || isUpdated;
  }

  _initScreen(InitFeaturesScreen event, Emitter<EditUnitFourthState> emit) {
    //update unit feature to be initialized as selected
    event.unit.features?.forEach((element) {
      element.isSelected = true;
    });
    event.unit.features?.forEach((element) {
      element.isSelected = true;
    });

    emit(state.copyWith(unit: event.unit, unitHasBeenUpdated: event.unit != event.unit));
  }

  _getFeatures(GetFeaturesEvent event, Emitter<EditUnitFourthState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await addUnitRepository.getFeatures();
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Feature> features = apiResponse.data.data;
            for (var feature in features) {
              state.unit!.features?.forEach((selected) {
                if (feature.id == selected.id) {
                  feature.isSelected = true;
                }
              });
            }
            emit(state.copyWith(features: features, isLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _updateUnit(FourthScreenUpdateUnit event, Emitter<EditUnitFourthState> emit) async {
    Unit unit = Unit(id: state.unit!.id, features: state.features?.where((element) => element.isSelected).toList());
    emit(state.copyWith(isLoading: true));
    if (state.unit != null) {
      ApiResponse apiResponse = await addUnitRepository.updateUnit(unit);
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
            navigationKey.currentState?.pushNamedAndRemoveUntil(
                UnitDetailsScreen.tag, ModalRoute.withName(MainScreen.tag),
                arguments: state.unit?.id);
            HomeObservableSingleTone().notify(UpdateSelectedRegionsUnit());
          },
          onFailed: () {
            if (apiResponse.error != null) {
              emit(state.copyWith(isLoading: false));
              showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
            }
          });
    }
  }

  void updateUnitReference(Unit? referenceUnit) {
    referenceUnit?.features = state.features?.where((e) => e.isSelected).toList();
  }
}