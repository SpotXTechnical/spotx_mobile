import 'package:owner/data/remote/statistics/model/statistics_filter.dart';
import 'package:owner/utils/network/api_response.dart';

abstract class IStatisticsRepository {
  Future<ApiResponse> addPayment(String unitId, String date, String amount, String description);
  Future<ApiResponse> getPayments(int page, {StatisticsFilter? statisticsFilter});
  Future<ApiResponse> getIncomes(int page, {StatisticsFilter? statisticsFilter});
  Future<ApiResponse> getTotalIncomes({StatisticsFilter? statisticsFilter});
  Future<ApiResponse> getUsers(int page);
  Future<ApiResponse> getGuests(int page);
  Future<ApiResponse> postNotifications(String message, String? unitId, List<String> regionsIds);
  Future<ApiResponse> updatePayment(String paymentId, String unitId, String date, String amount, String description);
  Future<ApiResponse> deletePayment(String paymentId);
}
