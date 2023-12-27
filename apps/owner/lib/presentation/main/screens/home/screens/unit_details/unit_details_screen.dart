import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_button/menu_button.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/data/remote/reservation/reservation_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/screens/calender/widget/room_list_item.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/screens/calender/widget/room_list_toggled_item.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/util.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/widgets/overview/overview_section.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/widgets/reservation_action_dialog.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/widgets/review/review_section.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/widgets/unit_details_content_choices.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/widgets/unit_details_header_widget.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/widgets/unit_details_slider_widget.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/widgets/unit_details_loading_widget.dart';
import 'package:owner/utils/extensions/build_context_extensions.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/table_calender/table_calendar_reservations.dart';
import 'package:owner/utils/table_calender/utils.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/error_widget.dart';
import 'bloc/unit_details_bloc.dart';
import 'bloc/unit_details_event.dart';
import 'bloc/unit_details_state.dart';

class UnitDetailsScreen extends StatelessWidget {
  const UnitDetailsScreen({Key? key}) : super(key: key);
  static const tag = "UnitDetailsScreen";
  @override
  Widget build(BuildContext context) {
    final unitId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
        create: (ctx) => UnitDetailsBloc(UnitRepository(), ReservationRepository())..add(GetUnitDetails(unitId)),
        child: BlocBuilder<UnitDetailsBloc, UnitDetailsState>(
            builder: (context, state) {
              UnitDetailsBloc unitDetailsBloc = BlocProvider.of(context);
              return WillPopScope(
                onWillPop: () async {
                  navigationKey.currentState?.pop(state.unit);
                  return false;
                },
                child: CustomSafeArea(
                  child: CustomScaffold(
                        appBar: UnitDetailsHeaderWidget(
                            unit: state.unit,
                            setUnit: (unit) {
                              unitDetailsBloc.add(UnitDetailsSetUnit(unit));
                            }
                        ),
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        body: (state.unit == null)
                            ? state.isLoading
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: const UnitDetailsLoadingWidget(),
                                  )
                                : SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: AppErrorWidget(action: () {
                                      navigationKey.currentState
                                          ?.pushReplacementNamed(UnitDetailsScreen.tag, arguments: unitId);
                                    }))
                            : state.isLoading ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: const UnitDetailsLoadingWidget(),
                        ) : Column(
                                children: [
                                  Expanded(
                                    child: CustomScrollView(slivers: [
                                      SliverToBoxAdapter(
                                        child: Column(
                                          children: [
                                            UnitDetailsSliderWidget(
                                              unitType: state.unit!.type!,
                                              showRate: state.unit!.rate != null && state.unit!.rate != '0',
                                              rate: state.unit!.rate,
                                              images: state.unit!.images!,
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsetsDirectional.only(top: 19, start: 24, end: 24),
                                              child: Text(
                                                state.unit?.title??'',
                                                style: circularMedium(color: kWhite, fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsetsDirectional.only(start: 21, end: 21),
                                              child: UnitDetailsContentChoices(
                                                calenderButtonAction: () {
                                                  unitDetailsBloc
                                                      .add(SetSelectedContentTypeEvent(SelectedContentType.calender));
                                                },
                                                overViewButtonAction: () {
                                                  unitDetailsBloc
                                                      .add(SetSelectedContentTypeEvent(SelectedContentType.overView));
                                                },
                                                selectedContentType: state.selectedContentType,
                                                reviewButtonAction: () {
                                                  unitDetailsBloc
                                                      .add(SetSelectedContentTypeEvent(SelectedContentType.review));
                                                },
                                              ),
                                            ),
                                            if (state.selectedContentType == SelectedContentType.overView)
                                              OverViewSection(unit: state.unit!)
                                            else if (state.selectedContentType == SelectedContentType.review)
                                              ReviewSection(reviews: state.unit!.reviews)
                                            else if (state.selectedContentType == SelectedContentType.calender)
                                              Column(
                                                children: [
                                                  if (state.unit!.rooms != null && state.unit!.rooms!.isNotEmpty)
                                                    Container(
                                                      margin: const EdgeInsetsDirectional.only(
                                                          top: 8, end: 20, start: 20, bottom: 20),
                                                      child: MenuButton<Room>(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(width: 0),
                                                            color: Theme.of(context).backgroundColor,
                                                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                                                        items: state.unit!.rooms!,
                                                        itemBackgroundColor: Theme.of(context).backgroundColor,
                                                        itemBuilder: (Room value) => RoomListItem(
                                                          title: value.title ?? "backend empty data",
                                                          isSelected: value.id.toString() == state.selectedRoom!.id,
                                                        ),
                                                        toggledChild: RoomListToggledItem(
                                                          title: state.selectedRoom!.title ?? "",
                                                        ),
                                                        onItemSelected: (Room value) {
                                                          unitDetailsBloc.add(SetSelectedRoom(value));
                                                        },
                                                        onMenuButtonToggle: (bool isToggle) {
                                                          debugPrint('$isToggle');
                                                        },
                                                        child: RoomListToggledItem(
                                                          title: state.selectedRoom!.title ?? "",
                                                        ),
                                                      ),
                                                    ),
                                                  Container(
                                                    margin: const EdgeInsetsDirectional.only(start: 21, end: 21),
                                                    child: TableCalendarReservations(
                                                      firstDay: kFirstDay,
                                                      pricesRanges: getPriceRanges(state.unit!, state.selectedRoom) ?? [],
                                                      lastDay: kLastDay,
                                                      focusedDay: state.currentDay ?? DateTime.now(),
                                                      onDaySelected: (day, _) {
                                                        unitDetailsBloc.add(PostReservationEvent(day));
                                                      },
                                                      rangeSelectionMode: RangeSelectionMode.disabled,
                                                      onDisabledDayTapped: (day) {
                                                        debugPrint("onDisabledDayTapped()");
                                                        if (day.isAfter(kToday)) {
                                                          onDisabledDayPressed(day, state, context, unitDetailsBloc);
                                                        }
                                                      },
                                                      onPageChanged: (focusedDay) {
                                                        // calenderBloc.add(InitDataEvent(focusedDay, state.priceRanges, null));
                                                      },
                                                      defaultPrice: state.unit?.defaultPrice ?? "",
                                                      reservedRanges: state.reservedRanges ?? [],
                                                      showFooter: true,
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                      if (state.selectedContentType == SelectedContentType.review && state.unit != null)
                                        if (state.unit!.reviews == null || state.unit!.reviews!.isEmpty)
                                          SliverFillRemaining(
                                            hasScrollBody: false,
                                            child: Align(
                                              child: Text(
                                                LocaleKeys.noDataMessage.tr(),
                                                style: circularBook(color: Theme.of(context).disabledColor, fontSize: 18),
                                              ),
                                            ),
                                          )
                                    ]),
                                  ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(top: 19),
                                    color: Theme.of(context).backgroundColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(21.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Text(
                                                  int.parse(state.unit!.currentPrice ?? "").replaceFarsiNumber(),
                                                  style: circularMedium(color: kWhite, fontSize: 17),
                                                ),
                                                Text(
                                                  LocaleKeys.perDayWithSlash.tr(),
                                                  style:
                                                      circularMedium(color: Theme.of(context).disabledColor, fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 3,
                                            child: SizedBox(height: 56),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ))
                ),
              );
          }
        )
    );
  }

  Future<void> onDisabledDayPressed(
    DateTime day,
    UnitDetailsState state,
    BuildContext context,
    UnitDetailsBloc unitDetailsBloc,
  ) async {
    final reservation = findReservationByDay(day, state.reservedRanges ?? []);
    debugPrint("selectedReservation= $reservation");
    if (reservation != null) {
      if (reservation.status == ReservationStatus.pending.name) {
        cancelPendingReservation(context, reservation, unitDetailsBloc);
      } else {
        final isReservedByQuest = reservation.guest != null ? true : false;
        if (isReservedByQuest) {
          cancelQuestReservation(unitDetailsBloc, reservation);
        } else {
          cancelCustomerReservation(context, reservation, unitDetailsBloc);
        }
      }
    }
  }

  void cancelQuestReservation(
    UnitDetailsBloc unitDetailsBloc,
    Reservation reservation,
  ) {
    unitDetailsBloc
        .add(CancelReservationEvent(reservation, true));
  }

  void cancelPendingReservation(
    BuildContext context,
    Reservation reservation,
    UnitDetailsBloc unitDetailsBloc,
  ) {
    showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (BuildContext context) => ReservationActionDialog(
        reservation: reservation,
        positiveActionText: LocaleKeys.accept.tr(),

        positiveAction: () {
          unitDetailsBloc.add(ApproveReservationEvent(reservation));
          Navigator.pop(context);
        },
        negativeAction: () {
          unitDetailsBloc.add(RejectReservationEvent(reservation));
          Navigator.pop(context);
        },
      ),
    );
  }

  void cancelCustomerReservation(
    BuildContext context,
    Reservation reservation,
    UnitDetailsBloc unitDetailsBloc,
  ) {
    showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (BuildContext context) => ReservationActionDialog(
        reservation: reservation,
        positiveAction: () {
          if (reservation.hasCancelRequest == true) {
            unitDetailsBloc.showErrorMsg(
                LocaleKeys.alreadyRequestCancel.tr());
          } else {
            unitDetailsBloc.add(CancelReservationEvent(reservation, false));
          }
          Navigator.pop(context, true);
        },
        hideCustomerInfo: true,
        hintMessage: LocaleKeys.requestCancelMsg.tr(),
        positiveActionText: LocaleKeys.requestToCancel.tr(),
      ),
    );
  }

  List<PriceRange>? getPriceRanges(Unit unit, Room? selectedRoom) {
    if (selectedRoom != null) {
      return selectedRoom.priceRanges;
    }
    return unit.ranges;
  }
}