import 'package:equatable/equatable.dart';

abstract class HomeObservable {
  void updateSelectedRegionsUnit();
}

class HomeObservableSingleTone {
  static final HomeObservableSingleTone _favouriteUnitsSingleTone = HomeObservableSingleTone._internal();

  HomeObservable? homeObservable;

  factory HomeObservableSingleTone() {
    return _favouriteUnitsSingleTone;
  }

  HomeObservableSingleTone._internal();

  void set(HomeObservable observable) {
    homeObservable = observable;
  }

  void remove(HomeObservable observer) {
    homeObservable = null;
  }

  void notify(HomeObservableEvent event) {
    switch (event.runtimeType) {
      case UpdateSelectedRegionsUnit:
        {
          homeObservable?.updateSelectedRegionsUnit();
        }
        break;
    }
  }
}

abstract class HomeObservableEvent extends Equatable {
  const HomeObservableEvent();

  @override
  List<Object?> get props => [];
}

class UpdateSelectedRegionsUnit extends HomeObservableEvent {}
