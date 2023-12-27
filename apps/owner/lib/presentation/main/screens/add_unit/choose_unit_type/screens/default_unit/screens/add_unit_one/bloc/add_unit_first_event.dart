import 'package:equatable/equatable.dart';

abstract class AddUnitFirstEvent extends Equatable {
  const AddUnitFirstEvent();
}

class HideError extends AddUnitFirstEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class MoveToSecondScreen extends AddUnitFirstEvent {
  const MoveToSecondScreen();
  @override
  List<Object?> get props => [];
}

class InitUnit extends AddUnitFirstEvent {
  const InitUnit();
  @override
  List<Object?> get props => [];
}
