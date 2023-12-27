import 'package:owner/base/base_bloc.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/select_unit/bloc/select_unit_event.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/select_unit/bloc/select_unit_state.dart';

class SelectUnitBloc extends BaseBloc<SelectUnitEvent, SelectUnitState> {
  SelectUnitBloc() : super(SelectUnitState()) {}
}
