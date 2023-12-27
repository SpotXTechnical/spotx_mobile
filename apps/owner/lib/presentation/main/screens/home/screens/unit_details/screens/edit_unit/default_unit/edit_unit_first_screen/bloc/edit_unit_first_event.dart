import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

abstract class EditUnitFirstEvent extends Equatable {
  const EditUnitFirstEvent();
}

class HideError extends EditUnitFirstEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class MoveToSecondScreen extends EditUnitFirstEvent {
  const MoveToSecondScreen();
  @override
  List<Object?> get props => [];
}

class GetUnitById extends EditUnitFirstEvent {
  final Unit unit;
  const GetUnitById(this.unit);
  @override
  List<Object?> get props => [unit];
}

class FirstScreenUpdateUnit extends EditUnitFirstEvent {
  const FirstScreenUpdateUnit();
  @override
  List<Object?> get props => [];
}
