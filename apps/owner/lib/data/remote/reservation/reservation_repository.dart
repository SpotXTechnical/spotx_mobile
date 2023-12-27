import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/data/remote/reservation/i_reservation_repository.dart';
import 'package:owner/data/remote/reservation/service/approve_reservation_service.dart';
import 'package:owner/data/remote/reservation/service/cancel_reservation_service.dart';
import 'package:owner/data/remote/reservation/service/get_reservation_by_id.dart';
import 'package:owner/data/remote/reservation/service/get_reservations_service.dart';
import 'package:owner/data/remote/reservation/service/post_reservation_service.dart';
import 'package:owner/data/remote/reservation/service/reject_reservation_service.dart';
import 'package:owner/utils/network/api_response.dart';

class ReservationRepository implements IReservationRepository {
  final GetReservationsService _getReservationsService = GetReservationsService();
  final ApproveReservationService _approveReservationService = ApproveReservationService();
  final RejectReservationService _rejectReservationService = RejectReservationService();
  final CancelReservationService _cancelReservationService = CancelReservationService();
  final PostReservationService _postReservationService = PostReservationService();
  final GetReservationByIdService _getReservationByIdService = GetReservationByIdService();

  @override
  Future<ApiResponse> approveReservation(String reservationId) {
    return _approveReservationService.approveReservation(reservationId);
  }

  @override
  Future<ApiResponse> rejectReservation(String reservationId) {
    return _rejectReservationService.rejectReservation(reservationId);
  }

  @override
  Future<ApiResponse> postReservation(
      String from, String to, String totalPrice, String unitId, String unitType, User user) {
    return _postReservationService.postReservation(from, to, totalPrice, unitId, unitType, user);
  }

  @override
  Future<ApiResponse> getReservations(
      {required int page, int? upcoming, int? past, int? month, String? type, String? unitId}) {
    return _getReservationsService.getReservations(
        page: page, upcoming: upcoming, past: past, month: month, type: type, unitId: unitId);
  }

  @override
  Future<ApiResponse> getReservationById(String reservationId) {
    return _getReservationByIdService.getReservationById(reservationId);
  }

  @override
  Future<ApiResponse> cancelReservation(String reservationId) {
    return _cancelReservationService.cancelReservation(reservationId);
  }
}