import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_button/menu_button.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/reservation/reservation_repository.dart';
import 'package:spotx/data/remote/unit/model/CalenderUnit.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/screens/summary_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/widget/room_list_item.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/widget/room_list_toggled_item.dart';
import 'package:spotx/utils/date_formats.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/table_calender/shared/utils.dart';
import 'package:spotx/utils/table_calender/table_calendar.dart';
import 'package:spotx/utils/table_calender/utils.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';

import 'bloc/calender_bloc.dart';
import 'bloc/calender_event.dart';
import 'bloc/calender_state.dart';

class CalenderScreen extends StatelessWidget {
  static const tag = "CalenderScreen";

  const CalenderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final calenderUnit = ModalRoute.of(context)?.settings.arguments as CalenderUnit;
    return BlocProvider(
        create: (ctx) => CalenderBloc(UnitRepository(), ReservationRepository())
          ..add(calenderUnit.type == UnitType.camp.name
              ? InitDataEvent(DateTime.now(), null)
              : InitDataEvent(DateTime.now(), calenderUnit))
          ..add(GetRoomDetailsEvent(calenderUnit.type, calenderUnit.id, calenderUnit.title)),
        child: BlocBuilder<CalenderBloc, CalenderState>(builder: (context, state) {
          CalenderBloc calenderBloc = BlocProvider.of(context);
          return Directionality(
            textDirection: TextDirection.ltr,
            child: CustomSafeArea(
              child: CustomScaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Header(
                    title: LocaleKeys.checkAvailability.tr(),
                    onBackAction: () {
                      navigationKey.currentState?.pop();
                    },
                  ),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: state.focusedDay == null || state.calenderUnit == null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: const LoadingWidget(),
                      )
                    : CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                Container(
                                    color: Theme.of(context).unselectedWidgetColor,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsetsDirectional.only(top: 30, bottom: 25, end: 25, start: 25),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        isArabic && state.rangeStartDay != null
                                                            ? DateFormat.MMMd(context.locale.languageCode)
                                                                .format(state.rangeStartDay!)
                                                            : state.startedDay,
                                                        style: circularBook(
                                                            color: kWhite, fontSize: 24)),
                                                    Container(
                                                        margin: const EdgeInsetsDirectional.only(top: 2),
                                                        child: Text(
                                                            state.rangeStartDay != null
                                                                ? isArabic
                                                                    ? DateFormat.E(context.locale.languageCode)
                                                                        .format(state.rangeStartDay!)
                                                                    : createDayNameFormat(
                                                                        DateFormat.E(context.locale.languageCode)
                                                                            .format(state.rangeStartDay!))
                                                                : state.startDayWeekName,
                                                            style: circularBook(
                                                                color: Theme.of(context).splashColor, fontSize: 10)))
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                          arrowMiddleIconPath,
                                                          color: kWhite
                                                      ),
                                                      const SizedBox(height: 16,),
                                                      if(state.rangeStartDay != null && state.rangeEndDay != null)
                                                        Text(
                                                            '${state.rangeEndDay?.difference(state.rangeStartDay!).inDays} ${LocaleKeys.nights.tr()}',
                                                          style: circularMedium(color: pacificBlue, fontSize: 18),
                                                        )
                                                    ],
                                                  )
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        isArabic && state.rangeEndDay != null
                                                            ? DateFormat.MMMd(context.locale.languageCode)
                                                                .format(state.rangeEndDay!)
                                                            : state.endedDay,
                                                        style: circularBook(
                                                            color: kWhite, fontSize: 24)),
                                                    Container(
                                                        margin: const EdgeInsetsDirectional.only(top: 2),
                                                        child: Text(
                                                            state.rangeEndDay != null
                                                                ? isArabic
                                                                    ? DateFormat.E(context.locale.languageCode)
                                                                        .format(state.rangeEndDay!)
                                                                    : createDayNameFormat(
                                                                        DateFormat.E(context.locale.languageCode)
                                                                            .format(state.rangeEndDay!))
                                                                : state.endDayWeekName,
                                                            style: circularBook(
                                                                color: Theme.of(context).splashColor, fontSize: 10)))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                calenderUnit.type == UnitType.camp.name
                                    ? Container(
                                        margin: const EdgeInsetsDirectional.only(top: 8, end: 20, start: 20),
                                        child: MenuButton<Room>(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 0),
                                              color: Theme.of(context).backgroundColor,
                                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                                          items: calenderUnit.rooms ?? [],
                                          itemBackgroundColor: Theme.of(context).backgroundColor,
                                          itemBuilder: (Room value) => RoomListItem(
                                            title: value.title ?? "backend empty data",
                                            isSelected: value.id.toString() == state.roomId,
                                          ),
                                          toggledChild: RoomListToggledItem(
                                            title: state.roomTitle ?? "",
                                            isLoading: state.roomRequestStatus == RequestStatus.loading,
                                          ),
                                          onItemSelected: (Room value) {
                                            calenderBloc.add(GetRoomDetailsEvent(state.calenderUnit!.type, value.id!,
                                                value.title ?? "backend empty data"));
                                          },
                                          onMenuButtonToggle: (bool isToggle) {
                                            debugPrint("$isToggle");
                                          },
                                          child: RoomListToggledItem(
                                            title: state.roomTitle ?? "",
                                            isLoading: state.roomRequestStatus == RequestStatus.loading,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                if (!state.isLoading)
                                  TableCalendar(
                                    locale: 'ar_EG',
                                    firstDay: kFirstDay,
                                    pricesRanges: state.calenderUnit?.activeRanges ?? [],
                                    reservedRanges: state.calenderUnit?.activeReservations ?? [],
                                    defaultPrice: state.calenderUnit?.defaultPrice ?? 0,
                                    lastDay: kLastDay,
                                    focusedDay: state.focusedDay ?? defaultDateTime,
                                    selectedDayPredicate: (day) => isSameDay(state.selectedDay, day),
                                    rangeStartDay: state.rangeStartDay,
                                    rangeEndDay: state.rangeEndDay,
                                    rangeSelectionMode: state.rangeSelectionMode,
                                    onDaySelected: (selectedDay, focusedDay) {
                                      if (isDayEnabled(selectedDay)) {
                                        if (!isSameDay(state.selectedDay, selectedDay)) {
                                          calenderBloc.add(DayTappedEvent(
                                              focusedDay, RangeSelectionMode.toggledOff, selectedDay, null, null));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text(LocaleKeys.thisDayIsNotAvailable.tr()),
                                        ));
                                      }
                                    },
                                    onRangeSelected: (start, end, focusedDay) {
                                      calenderBloc.fireRangeSelectedEvent(start, end, focusedDay);
                                    },
                                    onPageChanged: (focusedDay) {
                                      calenderBloc.add(InitDataEvent(focusedDay, state.calenderUnit));
                                    },
                                  ),
                              ],
                            ),
                          ),
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              children: [
                                if (state.isLoading) const Expanded(child: LoadingWidget()),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.all(24),
                                    child: AppButton(
                                      title: LocaleKeys.next.tr(),
                                      height: 55,
                                      borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                                      textWidget: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(28)),
                                        ),
                                        child: Center(
                                            child: Text(LocaleKeys.viewSummary.tr(),
                                                style: circularMedium(color: kWhite, fontSize: 17))),
                                      ),
                                      action: () async {
                                        checkIfUserIsLoggedInBefore(context, () {
                                          if (state.rangeStartDay != null && state.rangeEndDay != null) {
                                            double totalPrice =
                                                calculateTotalPrice(
                                                    calenderUnit,
                                                    state.rangeStartDay ?? defaultDateTime,
                                                    state.rangeEndDay ?? defaultDateTime
                                                );
                                            calenderUnit.startDate = state.rangeStartDay;
                                            calenderUnit.endDate = state.rangeEndDay;
                                            calenderUnit.totalPrice = totalPrice;
                                            navigationKey.currentState
                                                ?.pushNamed(SummaryScreen.tag, arguments: calenderUnit);
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(LocaleKeys.pleaseSelectARange.tr()),
                                            ));
                                          }
                                        });
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          );
        }));
  }

  String createDayNameFormat(String name) {
    var buffer = StringBuffer();
    name.toUpperCase().characters.forEach((element) {
      buffer.write(element);
      buffer.write(" ");
    });
    return buffer.toString().characters.skipLast(1).toString();
  }
}

double calculateTotalPrice(CalenderUnit calenderUnit, DateTime rangeStartDay, DateTime rangeEndDay) {
  DateTime currentDate = rangeStartDay;
  double totalPrice = 0;
  while (currentDate.isBefore(rangeEndDay)) {
    double? rangePrice;
    calenderUnit.activeRanges?.forEach((element) {
      DateTime? dayBeforeRangeStartDate = element.startDay?.subtract(const Duration(days: 1));
      DateTime? dayAfterRangeEndDate = element.endDay?.add(const Duration(days: 1));
      if (dayBeforeRangeStartDate != null && dayAfterRangeEndDate != null ){
        if (currentDate.isAfter(dayBeforeRangeStartDate) && currentDate.isBefore(dayAfterRangeEndDate)) {
          rangePrice = element.price?.toDouble();
        }
      }

    });
    if (rangePrice != null) {
      totalPrice = totalPrice + rangePrice!;
      rangePrice = null;
    } else {
      totalPrice = totalPrice + calenderUnit.defaultPrice;
    }
    currentDate = currentDate.add(const Duration(days: 1));
  }
  return totalPrice;
}