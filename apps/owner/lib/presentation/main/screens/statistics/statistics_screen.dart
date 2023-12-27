import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/statistics/statistics_repository.dart';
import 'package:owner/presentation/main/screens/statistics/bloc/statistics_bloc.dart';
import 'package:owner/presentation/main/screens/statistics/bloc/statistics_state.dart';
import 'package:owner/presentation/main/screens/statistics/widgets/statistics_actions.dart';
import 'package:owner/presentation/main/screens/statistics/widgets/statistics_header.dart';
import 'package:owner/presentation/main/screens/statistics/widgets/statistics_info.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

import 'bloc/statistics_event.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "StatisticsScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatisticsBloc>(
      create: (ctx) => StatisticsBloc(StatisticsRepository())..add(const GetTotalIncomesEvent()),
      child: BlocBuilder<StatisticsBloc, StatisticsState>(
        builder: (context, state) {
          StatisticsBloc statisticsBloc = BlocProvider.of(context);
          return CustomSafeArea(
              child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Todo ("check if this needed")
                  // const StatisticsHeader(),
                  Container(
                    margin: const EdgeInsets.only(top: 27, left: 22, right: 22),
                    child: Column(
                      children: [
                        state.isDetailsHeaderLoading || state.totalIncomesEntity == null
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: const LoadingWidget(),
                              )
                            : StatisticsInfo(
                                totalIncomesEntity: state.totalIncomesEntity!,
                              ),
                        StatisticsAction(() {
                          statisticsBloc.add(const GetTotalIncomesEvent());
                        })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
