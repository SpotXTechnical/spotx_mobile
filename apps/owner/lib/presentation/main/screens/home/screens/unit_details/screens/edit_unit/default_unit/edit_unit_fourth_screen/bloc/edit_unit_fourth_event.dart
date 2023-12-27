import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/feature_entity.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

abstract class EditUnitFourthEvent extends Equatable {
  const EditUnitFourthEvent();
}

class GetFeaturesEvent extends EditUnitFourthEvent {
  const GetFeaturesEvent();
  @override
  List<Object?> get props => [];
}

class ChangeFeatureStateEvent extends EditUnitFourthEvent {
  final Feature feature;
  const ChangeFeatureStateEvent(this.feature);
  @override
  List<Object?> get props => [feature];
}

class FourthScreenUpdateUnit extends EditUnitFourthEvent {
  const FourthScreenUpdateUnit();
  @override
  List<Object?> get props => [];
}

class InitFeaturesScreen extends EditUnitFourthEvent {
  final Unit unit;
  const InitFeaturesScreen(this.unit);
  @override
  List<Object?> get props => [unit];
}
