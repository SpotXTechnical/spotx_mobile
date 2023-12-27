import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

class AddUnitFirstState extends Equatable {
  const AddUnitFirstState({this.isLoading = false});
  final bool isLoading;
  @override
  List<Object?> get props => [isLoading];

  AddUnitFirstState copyWith({Unit? unit, bool? isLoading}) {
    return AddUnitFirstState(isLoading: isLoading ?? this.isLoading);
  }
}

class AddUnitFirstEmptyState extends AddUnitFirstState {
  const AddUnitFirstEmptyState() : super();
}
