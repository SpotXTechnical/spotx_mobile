import 'package:equatable/equatable.dart';

class ChooseUnitTypeState extends Equatable {
  const ChooseUnitTypeState({this.unitType = chalet});
  final String unitType;
  @override
  List<Object?> get props => [unitType];
}

class SetUnitTypeState extends ChooseUnitTypeState {
  const SetUnitTypeState(String unitType) : super(unitType: unitType);
}

const chalet = "chalet";
const camp = "camp";
