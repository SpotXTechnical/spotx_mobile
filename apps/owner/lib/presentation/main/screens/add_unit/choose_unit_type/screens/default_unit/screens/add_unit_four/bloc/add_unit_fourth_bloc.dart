import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/feature_entity.dart';
import 'package:owner/presentation/main/main_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'add_unit_fourth_event.dart';
import 'add_unit_fourth_state.dart';

class AddUnitFourthBloc extends BaseBloc<AddUnitFourthEvent, AddUnitFourthState> {
  AddUnitFourthBloc(this.addUnitRepository) : super(const AddUnitFourthState()) {
    on<ChangeFeatureStateEvent>(_changeFeatureState);
    on<GetFeaturesEvent>(_getFeatures);
    on<CreateUnitEvent>(_createUnit);
  }

  final IUnitRepository addUnitRepository;

  _changeFeatureState(ChangeFeatureStateEvent event, Emitter<AddUnitFourthState> emit) {
    List<Feature>? features = state.features;
    List<Feature> newList = Feature.createFeature(features!);
    newList.firstWhere((element) => element.id == event.feature.id).isSelected = !event.feature.isSelected;
    emit(state.copyWith(features: newList));
  }

  _getFeatures(GetFeaturesEvent event, Emitter<AddUnitFourthState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await addUnitRepository.getFeatures();
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Feature> features = apiResponse.data.data;
            emit(state.copyWith(features: features, isLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _createUnit(CreateUnitEvent event, Emitter<AddUnitFourthState> emit) async {
    event.unit.features = state.features?.where((element) => element.isSelected).toList();
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await addUnitRepository.postUnit(event.unit);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          navigationKey.currentState?.pushNamedAndRemoveUntil(MainScreen.tag, (_) => false);
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }
}
