import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_second/add_camp_second_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import '../../../../../../../../../../data/remote/add_unit/model/unit_and_action.dart';
import 'edit_camp_first_event.dart';
import 'edit_camp_first_state.dart';

class EditCampFirstBloc extends BaseBloc<EditCampFirstEvent, EditCampFirstState> {
  EditCampFirstBloc(this.unitRepository) : super(const EditCampEmptyState()) {
    on<EditFirstMoveToSecondScreen>(_moveToSecondScreen);
    on<EditFirstGetUnitById>(_getUnit);
  }

  final IUnitRepository unitRepository;
  static final formKey = GlobalKey<FormState>();

  final FocusNode titleArFocus = FocusNode();
  final FocusNode titleEnFocus = FocusNode();
  final FocusNode descriptionArFocus = FocusNode();
  final FocusNode descriptionEnFocus = FocusNode();
  final FocusNode addressArFocus = FocusNode();
  final FocusNode addressEnFocus = FocusNode();
  final TextEditingController titleArController = TextEditingController();
  final TextEditingController titleEnController = TextEditingController();
  final TextEditingController descriptionArController = TextEditingController();
  final TextEditingController descriptionEnController = TextEditingController();
  final TextEditingController addressArController = TextEditingController();
  final TextEditingController addressEnController = TextEditingController();

  _moveToSecondScreen(EditFirstMoveToSecondScreen event, Emitter<EditCampFirstState> emit) {
    state.unitAndAction!.updatedUnit.titleAr = titleArController.text;
    state.unitAndAction!.updatedUnit.titleEn = titleEnController.text;
    state.unitAndAction!.updatedUnit.descriptionAr = descriptionArController.text;
    state.unitAndAction!.updatedUnit.descriptionEn = descriptionEnController.text;
    state.unitAndAction!.updatedUnit.addressAr = addressArController.text;
    state.unitAndAction!.updatedUnit.addressEn = addressEnController.text;

    navigationKey.currentState?.pushNamed(AddCampSecondScreen.tag, arguments: state.unitAndAction);
  }

  _getUnit(EditFirstGetUnitById event, Emitter<EditCampFirstState> emit) async {
    emit(state.copyWith(isLoading: true, unitAndAction: event.unitAndAction));
    ApiResponse apiResponse = await unitRepository.getUnitById(event.unitAndAction.updatedUnit.id!);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          Unit unit = apiResponse.data.data;
          titleEnController.text = unit.titleEn ?? "BackEnd Empty Data";
          titleArController.text = unit.titleAr ?? "BackEnd Empty Data";
          descriptionEnController.text = unit.descriptionEn ?? "BackEnd Empty Data";
          descriptionArController.text = unit.descriptionAr ?? "BackEnd Empty Data";
          addressArController.text = unit.addressAr ?? "BackEnd Empty Data";
          addressEnController.text = unit.addressEn ?? "BackEnd Empty Data";
          emit(state.copyWith(unitAndAction: UnitWithReference(updatedUnit: unit), isLoading: false));
        },
        onFailed: () {});
  }
}
