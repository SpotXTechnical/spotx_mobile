import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

class EditUnitFirstState extends Equatable {
  const EditUnitFirstState({this.unit, this.isLoading = true});
  final Unit? unit;
  final bool isLoading;
  @override
  List<Object?> get props => [unit, isLoading];

  EditUnitFirstState copyWith({Unit? unit, bool? isLoading}) {
    return EditUnitFirstState(unit: unit ?? this.unit, isLoading: isLoading ?? this.isLoading);
  }
}

class EditUnitFirstEmptyState extends EditUnitFirstState {
  const EditUnitFirstEmptyState() : super();
}
