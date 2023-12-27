import 'package:equatable/equatable.dart';

import '../../../../../../../../data/remote/add_unit/model/unit.dart';

class SelectUnitState extends Equatable {
  const SelectUnitState({this.units, this.isLoading = false});
  final List<Unit>? units;
  final bool isLoading;

  @override
  List<Object?> get props => [units, isLoading];
  SelectUnitState copyWith({List<Unit>? units, bool? isLoading}) {
    return SelectUnitState(units: units ?? this.units, isLoading: isLoading ?? this.isLoading);
  }
}
