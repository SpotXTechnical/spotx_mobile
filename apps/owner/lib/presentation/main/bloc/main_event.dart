import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {}

class UpdateIndex extends MainEvent {
  final int selectedIndex;
  final int previousIndex;
  UpdateIndex(this.selectedIndex, this.previousIndex);

  @override
  List<Object?> get props => [selectedIndex, previousIndex];
}

class MainNavigateToPreviousEvent extends MainEvent {
  MainNavigateToPreviousEvent();
  @override
  List<Object?> get props => [];
}
