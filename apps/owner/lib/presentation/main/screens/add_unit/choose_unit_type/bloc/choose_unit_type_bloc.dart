import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'choose_unit_type_event.dart';
import 'choose_unit_type_state.dart';

class ChooseUnitTypeBloc extends BaseBloc<ChooseUnitTypeEvent, ChooseUnitTypeState> {
  ChooseUnitTypeBloc() : super(const ChooseUnitTypeState()) {
    on<SelectUnitTypeEvent>(_selectUnitType);
  }

  _selectUnitType(SelectUnitTypeEvent event, Emitter<ChooseUnitTypeState> emit) {
    emit(SetUnitTypeState(event.unitType));
  }
}
