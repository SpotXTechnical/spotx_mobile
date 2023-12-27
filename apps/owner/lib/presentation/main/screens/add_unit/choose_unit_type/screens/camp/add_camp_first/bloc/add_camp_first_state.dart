import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit_and_action.dart';

class AddCampFirstState extends Equatable {
  const AddCampFirstState({this.isLoading = false});
  final bool isLoading;
  @override
  List<Object?> get props => [isLoading];

  AddCampFirstState copyWith({UnitWithReference? unitAndAction, bool? isLoading}) {
    return AddCampFirstState(isLoading: isLoading ?? this.isLoading);
  }
}

class AddCampEmptyState extends AddCampFirstState {
  const AddCampEmptyState() : super();
}
