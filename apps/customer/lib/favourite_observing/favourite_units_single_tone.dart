import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/favourite_observing/favourite_list_observer.dart';

class FavouriteUnitsSingleTone {
  static final FavouriteUnitsSingleTone _favouriteUnitsSingleTone = FavouriteUnitsSingleTone._internal();
  final Set<int> favouriteUnitsIdList = {};
  final Set<int> unFavouriteUnitsIdList = {};
  final List<FavouriteListObserver> favouriteListObserverList = List.empty(growable: true);

  factory FavouriteUnitsSingleTone() {
    return _favouriteUnitsSingleTone;
  }

  FavouriteUnitsSingleTone._internal();

  void addToList(int id) {
    favouriteUnitsIdList.add(id);
    unFavouriteUnitsIdList.remove(id);
    notify();
  }

  void removeFromList(int id) {
    favouriteUnitsIdList.remove(id);
    unFavouriteUnitsIdList.add(id);
    notify();
  }

  void subscribe(FavouriteListObserver observer) {
    favouriteListObserverList.add(observer);
  }

  void unSubscribe(FavouriteListObserver observer) {
    favouriteListObserverList.remove(observer);
  }

  void notify() {
    for (var element in favouriteListObserverList) {
      element.update();
    }
  }

  void updateUnitsList(List<Unit> units) {
    for (var favouriteId in favouriteUnitsIdList) {
      for (var unit in units) {
        if (unit.id == favouriteId) {
          unit.isFavourite = true;
          unit.uiIsFavourite = true;
        }
      }
    }
    for (var favouriteId in unFavouriteUnitsIdList) {
      for (var unit in units) {
        if (unit.id == favouriteId) {
          unit.isFavourite = false;
          unit.uiIsFavourite = false;
        }
      }
    }
  }

  void updateUnit(Unit unit) {
    for (var favouriteId in favouriteUnitsIdList) {
      if (unit.id == favouriteId) {
        unit.isFavourite = true;
        unit.uiIsFavourite = true;
      }
    }
    for (var favouriteId in unFavouriteUnitsIdList) {
      if (unit.id == favouriteId) {
        unit.isFavourite = false;
        unit.uiIsFavourite = false;
      }
    }
  }
}
