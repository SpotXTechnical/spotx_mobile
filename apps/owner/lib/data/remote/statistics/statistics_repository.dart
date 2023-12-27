import 'package:owner/data/remote/statistics/i_statistics_repository.dart';
import 'package:owner/data/remote/statistics/model/statistics_filter.dart';
import 'package:owner/data/remote/statistics/service/delete_payment_service.dart';
import 'package:owner/data/remote/statistics/service/get_guests_service.dart';
import 'package:owner/data/remote/statistics/service/get_incomes_service.dart';
import 'package:owner/data/remote/statistics/service/get_payments_service.dart';
import 'package:owner/data/remote/statistics/service/get_total_incomes_service.dart';
import 'package:owner/data/remote/statistics/service/get_users_service.dart';
import 'package:owner/data/remote/statistics/service/post_notifications_service.dart';
import 'package:owner/data/remote/statistics/service/post_payment_service.dart';
import 'package:owner/data/remote/statistics/service/update_payment_service.dart';
import 'package:owner/utils/network/api_response.dart';

class StatisticsRepository implements IStatisticsRepository {
  final PostPaymentService _postPaymentService = PostPaymentService();
  final GetPaymentsService _getPaymentsService = GetPaymentsService();
  final GetIncomesService _getIncomesService = GetIncomesService();
  final GetTotalIncomesService _totalIncomesService = GetTotalIncomesService();
  final GetUsersService _getUsersService = GetUsersService();
  final GetGuestsService _getGuestsService = GetGuestsService();
  final PostNotificationsService _postNotificationsService = PostNotificationsService();
  final UpdatePaymentService _updatePaymentService = UpdatePaymentService();
  final DeletePaymentService _deletePaymentService = DeletePaymentService();

  @override
  Future<ApiResponse> addPayment(String unitId, String date, String amount, String description) {
    return _postPaymentService.postPayment(unitId, date, amount, description);
  }

  @override
  Future<ApiResponse> getPayments(int page, {StatisticsFilter? statisticsFilter}) {
    return _getPaymentsService.getPayments(page, statisticsFilter: statisticsFilter);
  }

  @override
  Future<ApiResponse> getIncomes(int page, {StatisticsFilter? statisticsFilter}) {
    return _getIncomesService.getIncomes(page, statisticsFilter: statisticsFilter);
  }

  @override
  Future<ApiResponse> getTotalIncomes({StatisticsFilter? statisticsFilter}) {
    return _totalIncomesService.getTotalIncomes(statisticsFilter: statisticsFilter);
  }

  @override
  Future<ApiResponse> getGuests(int page) {
    return _getGuestsService.getGuests(page);
  }

  @override
  Future<ApiResponse> getUsers(int page) {
    return _getUsersService.getUser(page);
  }

  @override
  Future<ApiResponse> postNotifications(String message, String? unitId, List<String> regionsIds) {
    return _postNotificationsService.postNotifications(message, unitId, regionsIds);
  }

  @override
  Future<ApiResponse> updatePayment(String paymentId, String unitId, String date, String amount, String description) {
    return _updatePaymentService.updatePayment(paymentId, unitId, date, amount, description);
  }

  @override
  Future<ApiResponse> deletePayment(String paymentId) {
    return _deletePaymentService.deletePayment(paymentId);
  }
}
