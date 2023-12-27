import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/model/reservations_calender_config.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/select_unit/select_unit_screen.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/table_calender/shared/utils.dart';
import 'package:owner/utils/table_calender/table_calendar_reservations.dart';
import 'package:owner/utils/table_calender/utils.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'package:owner/utils/widgets/pagination/pagination_list.dart';
import '../../../../../../utils/navigation/navigation_helper.dart';
import '../model/units_with_selected_unit_id.dart';
import '../screens/reservation_details/reservation_details_screen.dart';
import 'calender_reservation_card.dart';

class ReservationCalender extends StatelessWidget {
  const ReservationCalender(
      {Key? key,
      required this.reservations,
      required this.isLoading,
      required this.units,
      required this.onUnitClickedAction,
      required this.title,
      required this.onPageChanged,
      required this.focusedDay,
      required this.oldConfig,
      this.defaultPrice})
      : super(key: key);
  final List<Reservation> reservations;
  final bool isLoading;
  final List<Unit>? units;
  final Function(ReservationsCalenderConfig) onUnitClickedAction;
  final Function(DateTime) onPageChanged;
  final String title;
  final DateTime focusedDay;
  final String? defaultPrice;
  final ReservationsCalenderConfig? oldConfig;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: BorderRadiusDirectional.circular(10)),
            margin: const EdgeInsetsDirectional.only(top: 8, end: 20, start: 20),
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.6),
                                child: Text(
                                  title,
                                  style: circularBook(color: Theme.of(context).hintColor, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              Image.asset(arrowDownIcon, color: kWhite)
                            ],
                          ),
                          isLoading
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: const EdgeInsetsDirectional.only(start: 12),
                                          width: 16,
                                          height: 16,
                                          child: LoadingWidget(
                                            strokeWith: 3.0,
                                            color: Theme.of(context).hintColor,
                                          )),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  onTap: () async {
                    var newConfig = await navigationKey.currentState
                        ?.pushNamed(SelectUnitScreen.tag, arguments: UnitsWithSelectedIdAndType(units ?? [], oldConfig?.id ?? "", oldConfig?.type ?? ""));
                    if (newConfig != null) {
                      ReservationsCalenderConfig config = newConfig as ReservationsCalenderConfig;
                      onUnitClickedAction(config);
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 11, start: 21, end: 21),
            child: TableCalendarReservations(
              headerIcon: shareIconPath,
              firstDay: kYearBeforeNowDay,
              pricesRanges: const [],
              onPageChanged: (date) {
                onPageChanged.call(date);
              },
              lastDay: kLastDay,
              focusedDay: focusedDay,
              selectedDayPredicate: (day) => isSameDay(DateTime.now(), day),
              calendarFormat: CalendarFormat.month,
              rangeSelectionMode: RangeSelectionMode.disabled,
              onDisabledDayTapped: (day) {
                try {
                  Reservation? reservation = reservations.firstWhere((element) => _isWithinRange(day, element.from!, element.to!));
                  navigationKey.currentState?.pushNamed(ReservationDetailsScreen.tag, arguments: reservation.id.toString());
                } catch (e) {}
              },
              showFooter: true,
              defaultPrice: defaultPrice ?? "",
              reservedRanges: reservations.where((element) => element.status != ReservationStatus.reject.name).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: PaginationList<Reservation>(
              isLoading: false,
              hasMore: false,
              list: reservations,
              loadMore: () {},
              builder: (Reservation reservation) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        "${DateFormat.Md(context.locale.languageCode).format(reservation.from!)} ${LocaleKeys.toSmall.tr()} ${DateFormat.Md(context.locale.languageCode).format(reservation.to!)}",
                        style: circularBook(color: Theme.of(context).splashColor, fontSize: 14),
                      ),
                    ),
                    CalenderReservationCard(reservation: reservation),
                  ],
                );
              },
              onRefresh: () {},
              loadingWidget: const LoadingWidget(),
            ),
          )
        ],
      ),
    );
  }

  bool _isWithinRange(DateTime day, DateTime start, DateTime end) {
    if (isSameDay(day, start) || isSameDay(day, end)) {
      return true;
    }

    if (day.isAfter(start) && day.isBefore(end)) {
      return true;
    }

    return false;
  }
}