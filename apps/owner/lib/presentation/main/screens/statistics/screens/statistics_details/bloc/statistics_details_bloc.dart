import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/statistics/i_statistics_repository.dart';
import 'package:owner/data/remote/statistics/model/income_entity.dart';
import 'package:owner/data/remote/statistics/model/payment_entity.dart';
import 'package:owner/data/remote/statistics/model/total_icomes_entity.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/bloc/statistics_details_event.dart';
import 'package:owner/utils/network/api_response.dart';

import '../../../../../../../generated/locale_keys.g.dart';
import '../../../../../../../utils/style/theme.dart';
import '../utils.dart';
import 'statistics_details_state.dart';

class StatisticsDetailsBloc extends BaseBloc<StatisticsDetailsEvent, StatisticsDetailsState> {
  StatisticsDetailsBloc(this.statisticsRepository) : super(const StatisticsDetailsState()) {
    on<SetSelectionFinancialTypeEvent>(_setSelectedFinancialType);
    on<GetPaymentsEvent>(_getPayments);
    on<LoadMorePaymentsEvent>(_loadMorePayments);
    on<GetIncomesEvent>(_getIncomes);
    on<LoadMoreIncomesEvent>(_loadMoreIncomes);
    on<GetTotalIncomesEvent>(_getTotalIncomes);
    on<DeletePaymentEvent>(_deletePayment);
    on<GetStatisticsData>(_getStatisticsData);
  }
  final IStatisticsRepository statisticsRepository;
  int page = 1;

  FutureOr<void> _setSelectedFinancialType(
      SetSelectionFinancialTypeEvent event, Emitter<StatisticsDetailsState> emit) async {
    emit(state.copyWith(selectedFinancialType: event.selectedFinancialType));
    if (event.selectedFinancialType == SelectedFinancialType.payment) {
      add(const GetPaymentsEvent());
    } else {
      add(const GetIncomesEvent());
    }
  }

  _getStatisticsData(GetStatisticsData event, Emitter<StatisticsDetailsState> emit) async {
    emit(state.copyWith(statisticsFilter: event.statisticsFilter, isDetailsHeaderLoading: true));
    if (state.selectedFinancialType == SelectedFinancialType.income) {
      add(const GetIncomesEvent());
    } else {
      add(const GetPaymentsEvent());
    }
    add(const GetTotalIncomesEvent());
  }

  _getPayments(GetPaymentsEvent event, Emitter<StatisticsDetailsState> emit) async {
    await initiatePaymentList(emit);
  }

  FutureOr<void> _deletePayment(DeletePaymentEvent event, Emitter<StatisticsDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await statisticsRepository.deletePayment(event.paymentId);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Fluttertoast.showToast(
                msg: LocaleKeys.deletePaymentSuccessMessage.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            add(const GetPaymentsEvent());
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _getTotalIncomes(GetTotalIncomesEvent event, Emitter<StatisticsDetailsState> emit) async {
    emit(state.copyWith(isDetailsHeaderLoading: true));
    ApiResponse apiResponse = await statisticsRepository.getTotalIncomes(statisticsFilter: state.statisticsFilter);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            TotalIncomesEntity totalIncomesEntity = apiResponse.data.data;
            emit(state.copyWith(totalIncomesEntity: totalIncomesEntity, isDetailsHeaderLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> initiatePaymentList(Emitter<StatisticsDetailsState> emit) async {
    page = 1;
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await statisticsRepository.getPayments(page, statisticsFilter: state.statisticsFilter);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<PaymentEntity> payments = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > payments.length;
            emit(state.copyWith(hasMore: hasMore, entities: payments, isLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _loadMorePayments(LoadMorePaymentsEvent event, Emitter<StatisticsDetailsState> emit) async {
    page++;
    ApiResponse apiResponse = await statisticsRepository.getPayments(page);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<PaymentEntity> payments = apiResponse.data.data;
            List<PaymentEntity> allPayments = [...state.entities as List<PaymentEntity>, ...payments];
            var meta = apiResponse.data.meta!;
            bool hasMore = meta.currentPage! < meta.lastPage!;
            emit(state.copyWith(hasMore: hasMore, entities: allPayments));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _getIncomes(GetIncomesEvent event, Emitter<StatisticsDetailsState> emit) async {
    await initiateIncomesList(emit);
  }

  FutureOr<void> initiateIncomesList(Emitter<StatisticsDetailsState> emit) async {
    page = 1;
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await statisticsRepository.getIncomes(page, statisticsFilter: state.statisticsFilter);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<IncomeEntity> incomes = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > incomes.length;
            emit(state.copyWith(hasMore: hasMore, entities: incomes, isLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _loadMoreIncomes(LoadMoreIncomesEvent event, Emitter<StatisticsDetailsState> emit) async {
    page++;
    ApiResponse apiResponse = await statisticsRepository.getIncomes(page);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<IncomeEntity> incomes = apiResponse.data.data;
            List<IncomeEntity> allIncomes = [...state.entities as List<IncomeEntity>, ...incomes];
            var meta = apiResponse.data.meta!;
            bool hasMore = meta.currentPage! < meta.lastPage!;
            emit(state.copyWith(hasMore: hasMore, entities: allIncomes));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }
}