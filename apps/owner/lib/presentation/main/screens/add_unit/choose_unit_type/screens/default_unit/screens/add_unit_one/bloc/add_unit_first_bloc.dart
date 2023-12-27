import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/add_unit_second_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'add_unit_first_event.dart';
import 'add_unit_first_state.dart';

class AddUnitFirstBloc extends BaseBloc<AddUnitFirstEvent, AddUnitFirstState> {
  AddUnitFirstBloc(this.unitRepository) : super(const AddUnitFirstEmptyState()) {
    on<MoveToSecondScreen>(_moveToSecondScreen);
    on<InitUnit>(_initUnit);
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

  _moveToSecondScreen(MoveToSecondScreen event, Emitter<AddUnitFirstState> emit) {
    Unit unit = Unit();
    unit.titleAr = titleArController.text;
    unit.titleEn = titleEnController.text;
    unit.descriptionAr = descriptionArController.text;
    unit.descriptionEn = descriptionEnController.text;
    unit.type = UnitType.chalet.name;
    navigationKey.currentState?.pushNamed(AddUnitSecondScreen.tag, arguments: unit);
  }

  _initUnit(InitUnit event, Emitter<AddUnitFirstState> emit) async {
    emit(state.copyWith(unit: Unit()));
  }
}

enum ActionType { edit, add }
