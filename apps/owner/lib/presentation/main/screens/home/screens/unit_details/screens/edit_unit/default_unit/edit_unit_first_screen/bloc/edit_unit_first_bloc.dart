import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_second_screen/edit_unit_second_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';
import 'edit_unit_first_event.dart';
import 'edit_unit_first_state.dart';

class EditUnitFirstBloc extends BaseBloc<EditUnitFirstEvent, EditUnitFirstState> {
  EditUnitFirstBloc(this.unitRepository) : super(const EditUnitFirstEmptyState()) {
    on<MoveToSecondScreen>(_moveToSecondScreen);
    on<GetUnitById>(_getUnit);
    on<FirstScreenUpdateUnit>(_updateUnit);
  }

  final IUnitRepository unitRepository;
  static final formKey = GlobalKey<FormState>();

  final FocusNode titleArFocus = FocusNode();
  final FocusNode titleEnFocus = FocusNode();
  final FocusNode descriptionArFocus = FocusNode();
  final FocusNode descriptionEnFocus = FocusNode();
  final TextEditingController titleArController = TextEditingController();
  final TextEditingController titleEnController = TextEditingController();
  final TextEditingController descriptionArController = TextEditingController();
  final TextEditingController descriptionEnController = TextEditingController();

  _moveToSecondScreen(MoveToSecondScreen event, Emitter<EditUnitFirstState> emit) async {
    var result = await navigationKey.currentState?.pushNamed(EditUnitSecondScreen.tag, arguments: state.unit!) as Unit;
    //update this screen unit
    emit(state.copyWith(unit: result));
  }

  _getUnit(GetUnitById event, Emitter<EditUnitFirstState> emit) async {
    emit(state.copyWith(isLoading: true, unit: event.unit));
    ApiResponse apiResponse = await unitRepository.getUnitById(event.unit.id!);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          Unit unit = apiResponse.data.data;
          unit.imagesIds = unit.images?.map((e) => e.id!).toList();
          unit.referenceRanges = PriceRange.createNewListOfPriceRange(unit.ranges);
          unit.referenceImages = unit.images?.map((e) => e.id!).toList();
          titleEnController.text = unit.titleEn ?? "";
          titleArController.text = unit.titleAr ?? "";
          descriptionEnController.text = unit.descriptionEn ?? "";
          descriptionArController.text = unit.descriptionAr ?? "";

          //move the cursor to the end of edit text manually
          titleEnController.selection = TextSelection.fromPosition(TextPosition(offset: titleEnController.text.length));

          emit(state.copyWith(unit: unit.clone(), isLoading: false));
        },
        onFailed: () {});
  }

  _updateUnit(FirstScreenUpdateUnit event, Emitter<EditUnitFirstState> emit) async {
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

  void updateUnitReference(Unit? referenceUnit) {
    referenceUnit?.titleAr = titleArController.text.trim();
    referenceUnit?.titleEn = titleEnController.text.trim();
    referenceUnit?.descriptionAr = descriptionArController.text.trim();
    referenceUnit?.descriptionEn = descriptionEnController.text.trim();
    referenceUnit?.title = isArabic ? titleArController.text.trim() : titleEnController.text.trim();
    referenceUnit?.description = isArabic ? descriptionArController.text.trim() : descriptionEnController.text.trim();
  }

  Unit getUnitWithChangedData() {
    Unit unit = Unit(id: state.unit!.id);
    if (titleArController.text.trim() != state.unit?.titleAr?.trim()) {
      unit.titleAr = titleArController.text.trim();
    }
    if (titleEnController.text.trim() != state.unit?.titleEn?.trim()) {
      unit.titleEn = titleEnController.text.trim();
    }
    if (descriptionArController.text.trim() != state.unit?.descriptionAr?.trim()) {
      unit.descriptionAr = descriptionArController.text.trim();
    }
    if (descriptionEnController.text.trim() != state.unit?.descriptionEn?.trim()) {
      unit.descriptionEn = descriptionEnController.text.trim();
    }
    return unit;
  }
}