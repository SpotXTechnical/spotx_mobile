import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/data/remote/statistics/model/payment_entity.dart';
import 'package:owner/data/remote/statistics/statistics_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/send_notification/send_notification_screen.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/bloc/statistics_contacts_bloc.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/bloc/statistics_contacts_event.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/bloc/statistics_contacts_state.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/widgets/statistics_contacts_card.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/widgets/statistics_contacts_header.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomRoundedTextFormField.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

class StatisticsContactsScreen extends StatelessWidget {
  const StatisticsContactsScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "StatisticsContactsScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatisticsContactsBloc>(
      create: (ctx) => StatisticsContactsBloc(StatisticsRepository())..add(const GetUsersEvent()),
      child: BlocBuilder<StatisticsContactsBloc, StatisticsContactsState>(
        builder: (context, state) {
          return CustomSafeArea(
              child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo is ScrollUpdateNotification &&
                    scrollInfo.scrollDelta != null &&
                    scrollInfo.scrollDelta! > 0 &&
                    scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent) {
                  // statisticsDetailsBloc.add(const LoadMorePaymentsEvent());
                }
                return true;
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const StatisticsContactsHeader(),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.contacts.tr(),
                                style: poppinsBold(color: kWhite, fontSize: 26),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
                          child: CustomRoundedTextFormField(
                            hintText: LocaleKeys.search.tr(),
                            fillColor: Theme.of(context).backgroundColor,
                            prefixIcon: Image.asset(searchIconPath, color: kWhite),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  state.isLoading || state.entities == null || state.entities!.isEmpty
                      ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: Align(
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
                                return StatisticsContactsCard(
                                  user: state.entities![index] as User,
                                );
                              } else {
                                return StatisticsContactsCard(
                                  user: state.entities![index] as User,
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
                width: 180,
                height: 60,
                decoration: BoxDecoration(color: Theme.of(context).primaryColorLight, borderRadius: const BorderRadius.all(Radius.circular(30))),
                child: Text(
                  LocaleKeys.sendNotification.tr(),
                  style: circularMedium(color: kWhite, fontSize: 16),
                ),
              ),
              onTap: () {
                navigationKey.currentState?.pushNamed(SendNotificationScreen.tag);
              },
            ),
          ));
        },
      ),
    );
  }
}