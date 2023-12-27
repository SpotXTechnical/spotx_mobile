import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/auth/i_auth_repository.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/favourite_observing/favourite_list_observer.dart';
import 'package:spotx/favourite_observing/favourite_units_single_tone.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_event.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_state.dart';
import 'package:spotx/utils/network/api_response.dart';

class HomeMostPopularBloc extends BaseBloc<HomeEvent, HomeState> implements FavouriteListObserver {
  HomeMostPopularBloc(this.authRepository, {required this.unitRepository}) : super(const HomeState()) {
    FavouriteUnitsSingleTone().subscribe(this);
    on<GetMostPopularUnits>(_getMostPopularUnits);
    // on<AddToFavourite>(_addToFavourite);
    // on<RemoveFromFavourite>(_removeFromFavourite);
    on<UpdateMostPopularUnitsEvent>(_updateMostPopularState);
  }

  final IUnitRepository unitRepository;
  final IAuthRepository authRepository;

  _updateMostPopularState(UpdateMostPopularUnitsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(mostPopularUnits: event.units));
  }

  _getMostPopularUnits(GetMostPopularUnits event, Emitter<HomeState> emit) async {
    emit(state.copyWith(mostPopularSectionIsLoading: true));
    FilterQueries filterQueries = FilterQueries(mostPoplar: 1);
    ApiResponse apiResponse = await unitRepository.getUnits(filterQueries);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            emit(state.copyWith(mostPopularUnits: units, mostPopularSectionIsLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isError: true, mostPopularSectionIsLoading: false));
          }
        });
  }

  // _addToFavourite(AddToFavourite event, Emitter<HomeState> emit) async {
  //   List<Unit>? units = createNewList(state.mostPopularUnits!);
  //   Unit unitElement = Unit();
  //   for (var element in units) {
  //     if (element.id == event.id) {
  //       element.uiIsFavourite = true;
  //       unitElement = element;
  //     }
  //   }
  //   emit((HomeMostPopularUnits(units)));
  //   if (!unitElement.isFavouriteLoading) {
  //     List<Unit>? units = createNewList(state.mostPopularUnits!);
  //     for (var element in units) {
  //       if (element.id == event.id) {
  //         element.isFavouriteLoading = true;
  //       }
  //     }
  //     emit((HomeMostPopularUnits(units)));
  //     ApiResponse apiResponse = await unitRepository.addToFavourite(event.id);
  //     await handleResponse(
  //         result: apiResponse,
  //         onSuccess: () async {
  //           List<Unit>? units = createNewList(state.mostPopularUnits!);
  //           for (var element in units) {
  //             if (element.id == event.id) {
  //               element.isFavouriteLoading = false;
  //               emit((HomeMostPopularUnits(units)));
  //               if (!element.uiIsFavourite) {
  //                 add(RemoveFromFavourite(event.id));
  //               }
  //             }
  //           }
  //         },
  //         onFailed: () {
  //           List<Unit>? units = createNewList(state.mostPopularUnits!);
  //           for (var element in units) {
  //             if (element.id == event.id) {
  //               element.isFavouriteLoading = false;
  //             }
  //           }
  //           emit((HomeMostPopularUnits(units)));
  //         });
  //   }
  //   // addToFavourite(event.id);
  // }
  //
  // _removeFromFavourite(RemoveFromFavourite event, Emitter<HomeState> emit) async {
  //   List<Unit>? units = createNewList(state.mostPopularUnits!);
  //   Unit unitElement = Unit();
  //   for (var element in units) {
  //     if (element.id == event.id) {
  //       element.uiIsFavourite = false;
  //       unitElement = element;
  //     }
  //   }
  //   emit((HomeMostPopularUnits(units)));
  //   if (!unitElement.isFavouriteLoading) {
  //     List<Unit>? units = createNewList(state.mostPopularUnits!);
  //     for (var element in units) {
  //       if (element.id == event.id) {
  //         element.isFavouriteLoading = true;
  //       }
  //     }
  //     emit((HomeMostPopularUnits(units)));
  //     ApiResponse apiResponse = await unitRepository.removeFromFavourite(event.id);
  //     await handleResponse(
  //         result: apiResponse,
  //         onSuccess: () async {
  //           List<Unit>? units = createNewList(state.mostPopularUnits!);
  //           for (var element in units) {
  //             if (element.id == event.id) {
  //               element.isFavouriteLoading = false;
  //               emit((HomeMostPopularUnits(units)));
  //               if (element.uiIsFavourite) {
  //                 add(AddToFavourite(event.id));
  //               }
  //             }
  //           }
  //         },
  //         onFailed: () {
  //           List<Unit>? units = createNewList(state.mostPopularUnits!);
  //           for (var element in units) {
  //             if (element.id == event.id) {
  //               element.isFavouriteLoading = false;
  //             }
  //           }
  //           emit((HomeMostPopularUnits(units)));
  //         });
  //   }
  //   // addToFavourite(event.id);
  // }

  @override
  void update() {
    List<Unit> newUnitList = Unit.createNewUnitList(state.mostPopularUnits);
    FavouriteUnitsSingleTone().updateUnitsList(newUnitList);
    add(UpdateMostPopularUnitsEvent(newUnitList));
  }

  @override
  Future<void> close() {
    FavouriteUnitsSingleTone().unSubscribe(this);
    return super.close();
  }
}
