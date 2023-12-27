import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final int selectedIndex;
  final bool isArabic;
  const MainState({required this.selectedIndex,this.isArabic = false});

  @override
  List<Object?> get props => [selectedIndex];

  MainState copyWith({int? selectedIndex, bool? isArabic}) {
    return MainState(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        isArabic: isArabic ?? this.isArabic
    );
  }
}

class InitialMainState extends MainState {
  const InitialMainState(int selectedIndex) : super(selectedIndex: selectedIndex);
}