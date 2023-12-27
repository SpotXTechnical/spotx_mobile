import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends BaseBloc<MainEvent, MainState> {
  int? previousPage = 0;
  MainBloc(pageIndex) : super(InitialMainState(pageIndex)) {
    on<UpdateIndex>(_updateIndex);
    on<MainNavigateToPreviousEvent>(_navigateToPreviousIndex);
    on<UpdateIndexAndLanguage>(_updateIndexAndLang);
  }

  FutureOr<void> _updateIndex(UpdateIndex event, Emitter<MainState> emit) {
    previousPage = event.previousIndex;
    emit(state.copyWith(selectedIndex:  event.selectedIndex));
  }

  FutureOr<void> _navigateToPreviousIndex(MainNavigateToPreviousEvent event, Emitter<MainState> emit) {
    if (previousPage != null) {
      emit(InitialMainState(previousPage!));
    }
  }

  FutureOr<void> _updateIndexAndLang(
      UpdateIndexAndLanguage event,
      Emitter<MainState> emit
  ) {
    emit(state.copyWith(
        selectedIndex: event.selectedIndex, isArabic: event.isArabic
    ));
  }
}