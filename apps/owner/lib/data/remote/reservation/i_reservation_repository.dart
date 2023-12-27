import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/utils/network/api_response.dart';

abstract class IReservationRepository {
  Future<ApiResponse> getReservations(
      {required int page, int? upcoming, int? past, int? month, String? type, String? unitId});
  Future<ApiResponse> approveReservation(String reservationId);
  Future<ApiResponse> rejectReservation(String reservationId);
  Future<ApiResponse> cancelReservation(String reservationId);
  Future<ApiResponse> postReservation(
      String from, String to, String totalPrice, String unitId, String unitType, User user);
  Future<ApiResponse> getReservationById(String reservationId);
}