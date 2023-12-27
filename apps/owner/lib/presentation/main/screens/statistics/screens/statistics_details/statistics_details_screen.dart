import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/statistics/model/income_entity.dart';
import 'package:owner/data/remote/statistics/model/payment_entity.dart';
import 'package:owner/data/remote/statistics/statistics_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/bloc/statistics_details_bloc.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/bloc/statistics_details_event.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/bloc/statistics_details_state.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/screens/add_payment/add_payment_screen.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/utils.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/widgets/statistics_details_income_card.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/widgets/statistics_details_payment_card.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/widgets/statistics_details_header.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/widgets/statistics_details_income_payment_header.dart';
import 'package:owner/presentation/main/screens/statistics/widgets/statistics_info.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

class StatisticsDetailsScreen extends StatelessWidget {
  const StatisticsDetailsScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "StatisticsDetailsScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatisticsDetailsBloc>(
      create: (ctx) => StatisticsDetailsBloc(StatisticsRepository())
        ..add(const GetPaymentsEvent())
        ..add(const GetTotalIncomesEvent()),
      child: BlocBuilder<StatisticsDetailsBloc, StatisticsDetailsState>(
        builder: (context, state) {
          StatisticsDetailsBloc statisticsDetailsBloc = BlocProvider.of(context);
          return CustomSafeArea(
              child: Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo is ScrollUpdateNotification &&
                          scrollInfo.scrollDelta != null &&
                          scrollInfo.scrollDelta! > 0 &&
                          scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent) {
                        if (state.selectedFinancialType == SelectedFinancialType.payment) {
                          statisticsDetailsBloc.add(const LoadMorePaymentsEvent());
                        } else {
                          statisticsDetailsBloc.add(const LoadMoreIncomesEvent());
                        }
                      }
                      return true;
                    },
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              StatisticsDetailsHeader(
                                filterAction: (filterStatistics) {
                                  statisticsDetailsBloc.add(GetStatisticsData(filterStatistics));
                                },
                                statisticsFilter: state.statisticsFilter,
                              ),
                              const SizedBox(height: 28),
                              state.isDetailsHeaderLoading || state.totalIncomesEntity == null
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      child: const LoadingWidget(),
                                    )
                                  : StatisticsInfo(
                                      margin: const EdgeInsetsDirectional.only(start: 22, end: 22),
                                      totalIncomesEntity: state.totalIncomesEntity!,
                                    ),
                              const SizedBox(height: 19),
                            ],
                          ),
                        ),
                        SliverAppBar(
                            automaticallyImplyLeading: false,
                            pinned: true,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            title: StatisticsDetailsIncomePaymentHeader(
                                selectedFinancialType: state.selectedFinancialType,
                                paymentButtonAction: () {
                                  statisticsDetailsBloc
                                      .add(const SetSelectionFinancialTypeEvent(SelectedFinancialType.payment));
                                },
                                inComeButtonAction: () {
                                  statisticsDetailsBloc
                                      .add(const SetSelectionFinancialTypeEvent(SelectedFinancialType.income));
                                })),
                        state.isLoading || state.entities == null || state.entities!.isEmpty
                            ? SliverFillRemaining(
                                hasScrollBody: false,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: state.isLoading
                                      ? const LoadingWidget()
                                      : Text(
                                          LocaleKeys.noDataMessage.tr(),
                                          style: circularBook(color: Theme.of(context).disabledColor, fontSize: 18),
                                        ),
                                ),
                              )
                            : SliverFixedExtentList(
                                itemExtent: 100.0,
                                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                                  if (index == state.entities!.length) {
                                    if (state.hasMore) {
                                      return const SizedBox(child: Center(child: LoadingWidget()));
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    if (state.entities![index] is PaymentEntity) {
                                      return StatisticsDetailsPaymentCard(
                                        paymentEntity: state.entities![index] as PaymentEntity,
                                        editAction: () {
                                          navigateToPaymentScreen(
                                              statisticsDetailsBloc: statisticsDetailsBloc,
                                              paymentEntity: state.entities![index] as PaymentEntity);
                                        },
                                        deleteAction: () {
                                          statisticsDetailsBloc.add(DeletePaymentEvent(
                                              (state.entities![index] as PaymentEntity).id.toString()));
                                        },
                                      );
                                    } else {
                                      return StatisticsDetailsIncomeCard(
                                        incomeEntity: state.entities![index] as IncomeEntity,
                                      );
                                    }
                                  }
                                }, childCount: state.entities == null ? 1 : state.entities!.length + 1),
                              )
                      ],
                    ),
                  ),
                  floatingActionButton: GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      width: 181,
                      height: 60,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Image.asset(addPaymentIconPath, color: kWhite),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          LocaleKeys.addPayment.tr(),
                          style: circularMedium(color: kWhite, fontSize: 16),
                        )
                      ]),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    onTap: () {
                      navigateToPaymentScreen(statisticsDetailsBloc: statisticsDetailsBloc);
                    },
                  )));
        },
      ),
    );
  }

  void navigateToPaymentScreen(
      {required StatisticsDetailsBloc statisticsDetailsBloc, PaymentEntity? paymentEntity}) async {
    await navigationKey.currentState?.pushNamed(AddPaymentScreen.tag, arguments: paymentEntity);
    statisticsDetailsBloc.add(const GetPaymentsEvent());
    statisticsDetailsBloc.add(const GetTotalIncomesEvent());
  }
}