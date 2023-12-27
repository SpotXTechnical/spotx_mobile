import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/unit/services/add_to_favourite_service.dart';
import 'package:spotx/data/remote/unit/services/get_favourites_service.dart';
import 'package:spotx/data/remote/unit/services/get_offer_by_id_service.dart';
import 'package:spotx/data/remote/unit/services/get_offers_service.dart';
import 'package:spotx/data/remote/unit/services/get_owner_service.dart';
import 'package:spotx/data/remote/unit/services/get_room_details_service.dart';
import 'package:spotx/data/remote/unit/services/get_unit_by_id_service.dart';
import 'package:spotx/data/remote/unit/services/get_units_filter_config_service.dart';
import 'package:spotx/data/remote/unit/services/get_units_service.dart';
import 'package:spotx/data/remote/unit/services/post_rating_service.dart';
import 'package:spotx/data/remote/unit/services/remove_from_favourite_service.dart';
import 'package:spotx/utils/network/api_response.dart';

class UnitRepository implements IUnitRepository {
  final GetUnitsFilterConfigService _getUnitsFilterConfig = GetUnitsFilterConfigService();
  final GetUnitsService _getUnitsService = GetUnitsService();
  final GetUnitByIdService _getUnitByIdService = GetUnitByIdService();
  final GetFavouritesService _getFavouritesService = GetFavouritesService();
  final AddToFavouriteService _addToFavouriteService = AddToFavouriteService();
  final RemoveFromFavouriteService _removeFromFavouriteService = RemoveFromFavouriteService();
  final GetRoomDetailsService _getRoomDetailsService = GetRoomDetailsService();
  final GetOffersService _getOffersService = GetOffersService();
  final GetOfferByIdService _getOfferByIdService = GetOfferByIdService();
  final PostRatingService _postRatingService = PostRatingService();
  final GetOwnerService _getOwnerService = GetOwnerService();
  @override
  Future<List<ApiResponse>> getFilterData() {
    return _getUnitsFilterConfig.getFilterData();
  }

  @override
  Future<ApiResponse> getUnits(FilterQueries filterQueries) {
    return _getUnitsService.getUnits(filterQueries);
  }

  @override
  Future<ApiResponse> getUnitById(String id) {
    return _getUnitByIdService.getUnitById(id);
  }

  @override
  Future<ApiResponse> getFavourite(int page) {
    return _getFavouritesService.getFavourites(page);
  }

  @override
  Future<ApiResponse> addToFavourite(int id) {
    return _addToFavouriteService.addToFavourite(id);
  }

  @override
  Future<ApiResponse> removeFromFavourite(int id) {
    return _removeFromFavouriteService.removeFromFavourite(id);
  }

  @override
  Future<ApiResponse> getRoomDetails(int id) {
    return _getRoomDetailsService.getRoomDetails(id);
  }

  @override
  Future<ApiResponse> getOffers(int page) {
    return _getOffersService.getOffers(page);
  }

  @override
  Future<ApiResponse> postRating(String reservationId, String ownerRate, String unitRate, String message) {
    return _postRatingService.postRating(reservationId, ownerRate, unitRate, message);
  }

  @override
  Future<ApiResponse> getOwner(String id) {
    return _getOwnerService.getOwner(id);
  }

  @override
  Future<ApiResponse> getOfferById(String id) {
    return _getOfferByIdService.getOfferById(id);
  }
}
