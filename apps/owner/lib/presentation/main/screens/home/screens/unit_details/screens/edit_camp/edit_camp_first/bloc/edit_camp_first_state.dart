import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit_and_action.dart';

class EditCampFirstState extends Equatable {
  const EditCampFirstState({this.unitAndAction, this.isLoading = false});
  final UnitWithReference? unitAndAction;
  final bool isLoading;
  @override
  List<Object?> get props => [unitAndAction, isLoading];

  EditCampFirstState copyWith({UnitWithReference? unitAndAction, bool? isLoading}) {
    return EditCampFirstState(
        unitAndAction: unitAndAction ?? this.unitAndAction, isLoading: isLoading ?? this.isLoading);
  }
}

class EditCampEmptyState extends EditCampFirstState {
  const EditCampEmptyState() : super();
}
