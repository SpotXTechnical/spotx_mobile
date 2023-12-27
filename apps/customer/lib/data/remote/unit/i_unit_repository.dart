import 'package:spotx/utils/network/api_response.dart';
import 'model/filter_queryies.dart';

abstract class IUnitRepository {
  Future<List<ApiResponse>> getFilterData();
  Future<ApiResponse> getUnits(FilterQueries filterQueries);
  Future<ApiResponse> getUnitById(String id);
  Future<ApiResponse> getFavourite(int page);
  Future<ApiResponse> addToFavourite(int id);
  Future<ApiResponse> removeFromFavourite(int id);
  Future<ApiResponse> getRoomDetails(int id);
  Future<ApiResponse> getOffers(int page);
  Future<ApiResponse> postRating(String reservationId, String ownerRate, String unitRate, String message);
  Future<ApiResponse> getOwner(String id);
  Future<ApiResponse> getOfferById(String id);
}
