import 'package:spotx/data/remote/reservation/i_reservation_repository.dart';
import 'package:spotx/data/remote/reservation/services/cancel_reservation.dart';
import 'package:spotx/data/remote/reservation/services/get_reservationById.dart';
import 'package:spotx/data/remote/reservation/services/get_reservations_service.dart';
import 'package:spotx/data/remote/reservation/services/post_reservation.dart';
import 'package:spotx/data/remote/reservation/services/reservation_summary.dart';
import 'package:spotx/utils/network/api_response.dart';

class ReservationRepository implements IReservationRepository {
  final PostReservationService _postReservationService = PostReservationService();
  final ReservationSummaryService _getReservationService = ReservationSummaryService();
  final GetReservationsService _getReservationsService = GetReservationsService();
  final GetReservationById _getReservationById = GetReservationById();
  final CancelReservation _cancelReservation = CancelReservation();

  @override
  Future<ApiResponse> postReservation(String from, String to, int unitId, String unitType) {
    return _postReservationService.postReservation(from, to, unitId, unitType);
  }

  @override
  Future<ApiResponse> getReservations(int upcoming, int past, int page) {
    return _getReservationsService.getReservations(upcoming, past, page);
  }

  @override
  Future<ApiResponse> getReservationById(String id) {
    return _getReservationById.getReservationById(id);
  }

  @override
  Future<ApiResponse> cancelReservation(String id) {
    return _cancelReservation.cancelReservation(id);
  }

  @override
  Future<ApiResponse> getSummaryReservation(String from, String to, int unitId, String unitType) {
    return _getReservationService.getReservationSummary(from, to, unitId, unitType);
  }
}