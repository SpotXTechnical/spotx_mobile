import 'package:equatable/equatable.dart';

abstract class AddCampFirstEvent extends Equatable {
  const AddCampFirstEvent();
}

class HideError extends AddCampFirstEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class MoveToSecondScreen extends AddCampFirstEvent {
  const MoveToSecondScreen();
  @override
  List<Object?> get props => [];
}
