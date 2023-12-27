import 'package:spotx/utils/network/api_response.dart';

abstract class IReservationRepository {
  Future<ApiResponse> postReservation(String from, String to, int unitId, String unitType);
  Future<ApiResponse> getSummaryReservation(String from, String to, int unitId, String unitType);
  Future<ApiResponse> getReservations(int upcoming, int past, int page);
  Future<ApiResponse> getReservationById(String id);
  Future<ApiResponse> cancelReservation(String id);
}