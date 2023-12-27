import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/utils/utils.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends BaseBloc<MainEvent, MainState> {
  int previousPage = 0;

  MainBloc() : super(InitialMainState(isArabic ? 3 : 0)) {
    on<UpdateIndex>(_updateIndex);
    on<MainNavigateToPreviousEvent>(_navigateToPreviousIndex);
  }

  FutureOr<void> _updateIndex(UpdateIndex event, Emitter<MainState> emit) {
    previousPage = event.previousIndex;
    emit(InitialMainState(event.selectedIndex));
  }

  FutureOr<void> _navigateToPreviousIndex(MainNavigateToPreviousEvent event, Emitter<MainState> emit) {
    emit(InitialMainState(previousPage));
  }
}