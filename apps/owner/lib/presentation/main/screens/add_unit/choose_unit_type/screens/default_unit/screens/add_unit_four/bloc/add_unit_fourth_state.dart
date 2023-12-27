import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/feature_entity.dart';

class AddUnitFourthState extends Equatable {
  const AddUnitFourthState({this.features, this.isLoading = false});
  final List<Feature>? features;
  final bool isLoading;

  @override
  List<Object?> get props => [
        features,
        isLoading,
      ];
  AddUnitFourthState copyWith({List<Feature>? features, bool? isLoading, bool? unitHasBeenUpdated}) {
    return AddUnitFourthState(features: features ?? this.features, isLoading: isLoading ?? this.isLoading);
  }
}
