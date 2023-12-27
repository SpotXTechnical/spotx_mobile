import 'package:equatable/equatable.dart';

abstract class ChooseUnitTypeEvent extends Equatable {
  const ChooseUnitTypeEvent();
}

class HideError extends ChooseUnitTypeEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class SelectUnitTypeEvent extends ChooseUnitTypeEvent {
  final String unitType;
  const SelectUnitTypeEvent(this.unitType);
  @override
  List<Object?> get props => [unitType];
}
