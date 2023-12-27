import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/statistics/i_statistics_repository.dart';
import 'package:owner/data/remote/statistics/model/total_icomes_entity.dart';
import 'package:owner/presentation/main/screens/statistics/bloc/statistics_event.dart';
import 'package:owner/utils/network/api_response.dart';

import 'statistics_state.dart';

class StatisticsBloc extends BaseBloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc(this.statisticsRepository) : super(const StatisticsState()) {
    on<GetTotalIncomesEvent>(_getTotalIncomes);
  }

  final IStatisticsRepository statisticsRepository;

  FutureOr<void> _getTotalIncomes(GetTotalIncomesEvent event, Emitter<StatisticsState> emit) async {
    emit(state.copyWith(isDetailsHeaderLoading: true));
    ApiResponse apiResponse = await statisticsRepository.getTotalIncomes();
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
}
