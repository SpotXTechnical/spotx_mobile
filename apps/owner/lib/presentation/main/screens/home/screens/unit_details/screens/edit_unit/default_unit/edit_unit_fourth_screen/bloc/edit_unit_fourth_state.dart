import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/feature_entity.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

class EditUnitFourthState extends Equatable {
  const EditUnitFourthState({this.features, this.isLoading = false, this.unit, this.unitHasBeenUpdated = false});
  final List<Feature>? features;
  final bool isLoading;
  final Unit? unit;
  final bool unitHasBeenUpdated;

  @override
  List<Object?> get props => [features, isLoading, unit, unitHasBeenUpdated];
  EditUnitFourthState copyWith({List<Feature>? features, bool? isLoading, Unit? unit, bool? unitHasBeenUpdated}) {
    return EditUnitFourthState(
        features: features ?? this.features,
        isLoading: isLoading ?? this.isLoading,
        unit: unit ?? this.unit,
        unitHasBeenUpdated: unitHasBeenUpdated ?? this.unitHasBeenUpdated);
  }
}
