import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/data/remote/reservation/reservation_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/widgets/reservation_calender.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/widgets/reservation_card.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/widgets/reservations_loading_widget.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/error_widget.dart';
import 'package:owner/utils/widgets/header.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'package:owner/utils/widgets/pagination/pagination_list.dart';

import 'bloc/reservations_bloc.dart';
import 'bloc/reservations_event.dart';
import 'bloc/reservations_state.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "ReservationScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReservationsBloc>(
      create: (ctx) => ReservationsBloc(ReservationRepository(), UnitRepository())
        ..add(const GetReservationsByPastOrUpcomingEvent(1, 0, SelectedReservationsType.upComing))
        ..add(const GetUnits()),
      child: BlocBuilder<ReservationsBloc, ReservationsState>(
        builder: (context, state) {
          ReservationsBloc reservationsBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: Header(
                  title: LocaleKeys.reservations.tr(),
                  endIconPath: state.reservationShowType == ReservationShowType.list
                      ? null
                      : listIconPath,
                  showBackIcon: false,
                  endIconAction: () {
                    reservationsBloc.add(const ChangeShowType());
                  },
                ),
                body: state.reservationShowType == ReservationShowType.calender
                    ? getCurrentDisplayOfCalender(reservationsBloc, state, context)
                    : Column(
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: const BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: (state.selectedReservationsType == SelectedReservationsType.upComing)
                                                ? Theme.of(context).primaryColorLight
                                                : Theme.of(context).unselectedWidgetColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                                          child: Text(
                                            LocaleKeys.current.tr(),
                                            style: circularBook(color: kWhite, fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        if (state.selectedReservationsType == SelectedReservationsType.past) {
                                          reservationsBloc.add(const GetReservationsByPastOrUpcomingEvent(
                                              1, 0, SelectedReservationsType.upComing));
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: (state.selectedReservationsType == SelectedReservationsType.past)
                                                ? Theme.of(context).primaryColorLight
                                                : Theme.of(context).unselectedWidgetColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                                          child: Text(
                                            LocaleKeys.past.tr(),
                                            style: circularBook(color: kWhite, fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        if (state.selectedReservationsType == SelectedReservationsType.upComing) {
                                          reservationsBloc.add(const GetReservationsByPastOrUpcomingEvent(
                                              0, 1, SelectedReservationsType.past));
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (state.typesReservationsRequestStatus == RequestStatus.loading)
                            Expanded(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: const LoadingWidget(),
                              ),
                            )
                          else if (state.typesReservationsRequestStatus == RequestStatus.failure)
                            Expanded(
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: AppErrorWidget(action: () {
                                    if (state.selectedReservationsType == SelectedReservationsType.upComing) {
                                      reservationsBloc.add(const GetReservationsByPastOrUpcomingEvent(
                                          1, 0, SelectedReservationsType.upComing));
                                    } else {
                                      reservationsBloc.add(const GetReservationsByPastOrUpcomingEvent(
                                          0, 1, SelectedReservationsType.past));
                                    }
                                  })),
                            )
                          else if (state.typesReservationsRequestStatus == RequestStatus.success)
                            Expanded(
                              child: CustomScrollView(
                                controller: reservationsBloc.scrollController,
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (state.typesReservations!.isNotEmpty)
                                          Padding(
                                              padding: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 20),
                                              child: PaginationList<Reservation>(
                                                isLoading: false,
                                                hasMore: state.hasMore,
                                                list: state.typesReservations!,
                                                loadMore: () {
                                                  debugPrint('load more called');
                                                  switch (state.selectedReservationsType) {
                                                    case SelectedReservationsType.past:
                                                      reservationsBloc.add(
                                                          LoadMoreReservations(0, 1, state.selectedReservationsType));
                                                      break;
                                                    case SelectedReservationsType.upComing:
                                                      reservationsBloc.add(
                                                          LoadMoreReservations(1, 0, state.selectedReservationsType));
                                                      break;
                                                  }
                                                },
                                                builder: (Reservation reservation) {
                                                  return ReservationCardWidget(
                                                    reservation: reservation,
                                                    rejectAction: (id) {
                                                      reservationsBloc.add(RejectReservationEvent(id));
                                                    },
                                                    acceptAction: (id) {
                                                      reservationsBloc.add(ApproveReservationEvent(id));
                                                    },
                                                  );
                                                },
                                                onRefresh: () {},
                                                loadingWidget: const ReservationsLoadingWidget(),
                                              )
                                          ),
                                      ],
                                    ),
                                  ),
                                  SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: state.typesReservations!.isEmpty
                                        ? SizedBox(
                                            child: Center(
                                            child: Text(
                                              LocaleKeys.noReservationsMessage.tr(),
                                              style: circularMedium(
                                                  color: Theme.of(context).dialogBackgroundColor, fontSize: 15),
                                            ),
                                          ))
                                        : Container(),
                                  )
                                ],
                              ),
                            )
                        ],
                      )),
          );
        },
      ),
    );
  }

  Widget getCurrentDisplayOfCalender(ReservationsBloc reservationsBloc, ReservationsState state, BuildContext context) {
    if (state.monthReservationsRequestStatus == RequestStatus.failure) {
      return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AppErrorWidget(action: () {
            reservationsBloc.add(const GetUnits());
          }));
    } else {
      return ReservationCalender(
        oldConfig: state.reservationsCalenderConfig,
        defaultPrice: state.reservationsCalenderConfig == null ? "" : state.reservationsCalenderConfig!.defaultPrice,
        reservations: state.monthReservations ?? [],
        isLoading: state.monthReservationsRequestStatus == RequestStatus.loading,
        units: state.units,
        onUnitClickedAction: (config) {
          reservationsBloc.add(GetReservationsByMonth(config, DateTime.now()));
        },
        focusedDay: state.focusedDay ?? DateTime.now(),
        title: state.reservationsCalenderConfig == null ? "" : state.reservationsCalenderConfig!.title,
        onPageChanged: (date) {
          if (state.reservationsCalenderConfig != null) {
            reservationsBloc.add(GetReservationsByMonth(state.reservationsCalenderConfig!, date));
          }
        },
      );
    }
  }
}