import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit_and_action.dart';

abstract class EditCampFirstEvent extends Equatable {
  const EditCampFirstEvent();
}

class HideError extends EditCampFirstEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class EditFirstMoveToSecondScreen extends EditCampFirstEvent {
  const EditFirstMoveToSecondScreen();
  @override
  List<Object?> get props => [];
}

class EditFirstGetUnitById extends EditCampFirstEvent {
  final UnitWithReference unitAndAction;
  const EditFirstGetUnitById(this.unitAndAction);
  @override
  List<Object?> get props => [unitAndAction];
}
