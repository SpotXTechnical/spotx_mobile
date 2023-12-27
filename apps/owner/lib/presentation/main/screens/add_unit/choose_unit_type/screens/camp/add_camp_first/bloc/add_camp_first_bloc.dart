import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_second/add_camp_second_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'add_camp_first_event.dart';
import 'add_camp_first_state.dart';

class AddCampFirstBloc extends BaseBloc<AddCampFirstEvent, AddCampFirstState> {
  AddCampFirstBloc(this.unitRepository) : super(const AddCampEmptyState()) {
    on<MoveToSecondScreen>(_moveToSecondScreen);
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

  _moveToSecondScreen(MoveToSecondScreen event, Emitter<AddCampFirstState> emit) {
    Unit unit = Unit();
    unit.titleAr = titleArController.text;
    unit.titleEn = titleEnController.text;
    unit.descriptionAr = descriptionArController.text;
    unit.descriptionEn = descriptionEnController.text;
    unit.addressAr = addressArController.text;
    unit.addressEn = addressEnController.text;

    navigationKey.currentState?.pushNamed(AddCampSecondScreen.tag, arguments: unit);
  }
}
