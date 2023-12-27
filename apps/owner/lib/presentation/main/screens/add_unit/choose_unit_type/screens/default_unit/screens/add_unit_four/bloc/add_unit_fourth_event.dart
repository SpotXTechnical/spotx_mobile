import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/feature_entity.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

abstract class AddUnitFourthEvent extends Equatable {
  const AddUnitFourthEvent();
}

class GetFeaturesEvent extends AddUnitFourthEvent {
  const GetFeaturesEvent();
  @override
  List<Object?> get props => [];
}

class ChangeFeatureStateEvent extends AddUnitFourthEvent {
  final Feature feature;
  const ChangeFeatureStateEvent(this.feature);
  @override
  List<Object?> get props => [feature];
}

class CreateUnitEvent extends AddUnitFourthEvent {
  final Unit unit;
  const CreateUnitEvent(this.unit);
  @override
  List<Object?> get props => [unit];
}
