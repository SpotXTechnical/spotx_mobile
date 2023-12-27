import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/data/remote/add_unit/model/edited_calender_price_range.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/screens/calender/bloc/calender_bloc.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/screens/calender/bloc/calender_event.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/table_calender/shared/utils.dart';
import 'package:owner/utils/table_calender/table_calendar_prices.dart';
import 'package:owner/utils/table_calender/utils.dart';
import 'package:owner/utils/utils.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/header.dart';

import 'bloc/calender_state.dart';

class CalenderScreen extends StatelessWidget {
  static const tag = "CalenderScreen";

  const CalenderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final editedCalenderPriceRange = ModalRoute.of(context)!.settings.arguments as EditedCalenderPriceRange?;
    return BlocProvider(
        create: (ctx) => CalenderBloc()
          ..add(InitDataEvent(DateTime.now(), editedCalenderPriceRange?.list, editedCalenderPriceRange?.editedElement)),
        child: BlocBuilder<CalenderBloc, CalenderState>(builder: (context, state) {
          CalenderBloc calenderBloc = BlocProvider.of(context);
          return WillPopScope(
            onWillPop: () async {
              popCalenderScreen(state.priceRanges);
              return false;
            },
            child: CustomSafeArea(
              child: CustomScaffold(
                appBar: Header(
                  margin: const EdgeInsetsDirectional.only(top: 24, start: 24, end: 24),
                  title: LocaleKeys.addSpecialPrice.tr(),
                  onBackAction: () {
                    if (editedCalenderPriceRange != null && editedCalenderPriceRange.editedElement != null) {
                      if (checkEditedElementChanged(
                          calenderBloc.priceController, state, editedCalenderPriceRange.editedElement)) {
                        showExitWarningDialog(context: context);
                      } else {
                        List<PriceRange>? list = state.priceRanges;
                        list?.add(editedCalenderPriceRange.editedElement!);
                        popCalenderScreen(list);
                      }
                    } else {
                      popCalenderScreen(state.priceRanges);
                    }
                  },
                ),
                resizeToAvoidBottomInset: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          color: Theme.of(context).unselectedWidgetColor,
                          child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsetsDirectional.only(top: 25, bottom: 25, end: 25, start: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                state.rangeStartDay != null
                                                    ? DateFormat.MMMd(context.locale.languageCode)
                                                        .format(state.rangeStartDay!)
                                                    : state.startedDay,
                                                style: circularBook(color: kWhite, fontSize: 24)),
                                            Container(
                                                margin: const EdgeInsets.only(top: 2),
                                                child: Text(
                                                    state.rangeStartDay != null
                                                        ? DateFormat.E(context.locale.languageCode)
                                                            .format(state.rangeStartDay!)
                                                        : state.startedDay,
                                                    style: circularBook(
                                                        color: Theme.of(context).splashColor, fontSize: 10)))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Image.asset(arrowMiddleIconPath, color: kWhite)),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                state.rangeEndDay != null
                                                    ? DateFormat.MMMd(context.locale.languageCode)
                                                        .format(state.rangeEndDay!)
                                                    : state.endedDay,
                                                style: circularBook(color: kWhite, fontSize: 24)),
                                            Container(
                                                margin: const EdgeInsets.only(top: 2),
                                                child: Text(
                                                    state.rangeEndDay != null
                                                        ? DateFormat.E(context.locale.languageCode)
                                                            .format(state.rangeEndDay!)
                                                        : state.endDayWeekName,
                                                    style: circularBook(
                                                        color: Theme.of(context).splashColor, fontSize: 10)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          )),
                      state.isLoading || state.focusedDay == null
                          ? Container()
                          : TableCalendarPrices(
                              specialPrice: state.specialPrice ?? calenderBloc.priceController.text,
                              defaultPrice: editedCalenderPriceRange?.defaultPrice ?? "",
                              firstDay: kFirstDay,
                              priceRanges: state.priceRanges!,
                              lastDay: kLastDay,
                              focusedDay: state.focusedDay!,
                              selectedDayPredicate: (day) => isSameDay(state.selectedDay, day),
                              rangeStartDay: state.rangeStartDay,
                              rangeEndDay: state.rangeEndDay,
                              calendarFormat: CalendarFormat.month,
                              rangeSelectionMode: state.rangeSelectionMode,
                              onDisabledDayTapped: (day) {
                                Fluttertoast.showToast(
                                    msg: LocaleKeys.disabledDayMessage.tr(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: kWhite);
                              },
                              onRangeSelected: (start, end, focusedDay) {
                                String? startedDay;
                                String? startDayWeekName;
                                String? endedDay;
                                String? endDayWeekName;
                                if (start != null) {
                                  String month = months[start.month - 1];
                                  String day = start.day.toString();
                                  startedDay = day + " " + month;
                                  startDayWeekName = DateFormat('EEE').format(start);
                                } else {
                                  startedDay = "-  -  -";
                                  startDayWeekName = "-  -  -";
                                }
                                if (end != null) {
                                  String month = months[end.month - 1];
                                  String day = end.day.toString();
                                  endedDay = day + " " + month;
                                  endDayWeekName = DateFormat('EEE').format(end);
                                } else {
                                  endedDay = "-  -  -";
                                  endDayWeekName = "-  -  -";
                                }
                                calenderBloc.add(RangeSelectedEvent(focusedDay, RangeSelectionMode.toggledOn, null,
                                    start, end, startedDay, endedDay, startDayWeekName, endDayWeekName));
                              },
                              onPageChanged: (focusedDay) {
                                calenderBloc.add(InitDataEvent(focusedDay, state.priceRanges, null));
                              },
                            ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Form(
                              key: CalenderBloc.formKey,
                              child: Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 10, bottom: 18),
                                  child: CustomTitledRoundedTextFormWidget(
                                      onChanged: (value) {
                                        calenderBloc.add(UpdateSpecialPrice(value));
                                      },
                                      autoFocus: true,
                                      title: LocaleKeys.specialPrice.tr(),
                                      hintText: LocaleKeys.eg2000.tr(),
                                      controller: calenderBloc.priceController,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return LocaleKeys.validationInsertData.tr();
                                        } else if (int.parse(value!) < 1 || int.parse(value) > 50000) {
                                          return LocaleKeys.defaultPriceErrorMessage.tr();
                                        } else {
                                          return null;
                                        }
                                      })),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(top: 20),
                              child: Text(
                                LocaleKeys.le.tr(),
                                style: circularBook(color: kWhite, fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.priceAsOffer.tr(),
                              style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 17),
                            ),
                            FlutterSwitch(
                              height: 30.0,
                              width: 55.0,
                              padding: 4.0,
                              toggleSize: 28.0,
                              borderRadius: 50.0,
                              activeColor: Theme.of(context).primaryColorLight,
                              value: state.isOffer,
                              onToggle: (value) {
                                calenderBloc.add(ChangeOfferStateEvent(value));
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(24),
                          child: AppButtonGradient(
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
                                  child: Text(LocaleKeys.add.tr(),
                                      style: circularMedium(color: kWhite, fontSize: 17))),
                            ),
                            action: () async {
                              if (CalenderBloc.formKey.currentState?.validate() ?? false) {
                                if (state.rangeStartDay != null && state.rangeEndDay != null) {
                                  if (editedCalenderPriceRange != null &&
                                      editedCalenderPriceRange.editedElement != null) {
                                    editPriceRange(state, calenderBloc, editedCalenderPriceRange);
                                  } else {
                                    addAnewPriceRange(state, calenderBloc);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: LocaleKeys.pleaseSelectRange.tr(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: kWhite);
                                }
                              }
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  void editPriceRange(
      CalenderState state, CalenderBloc calenderBloc, EditedCalenderPriceRange editedCalenderPriceRange) {
    var priceRange = PriceRange(
        isOffer: state.isOffer ? 1 : 0,
        startDay: state.rangeStartDay,
        endDay: state.rangeEndDay,
        from: DateFormat('yyyy-MM-dd HH:mm:ss').format(state.rangeStartDay!),
        to: DateFormat('yyyy-MM-dd HH:mm:ss').format(state.rangeEndDay!),
        price: calenderBloc.priceController.text);
    List<PriceRange>? list = state.priceRanges;
    list?.insert(editedCalenderPriceRange.index!, priceRange);
    popCalenderScreen(list);
  }

  void addAnewPriceRange(CalenderState state, CalenderBloc calenderBloc) {
    List<PriceRange>? oldList = state.priceRanges;
    List<PriceRange> newList = PriceRange.createNewListOfPriceRange(oldList);
    newList.add(PriceRange(
        isOffer: state.isOffer ? 1 : 0,
        startDay: state.rangeStartDay,
        endDay: state.rangeEndDay,
        from: DateFormat('yyyy-MM-dd HH:mm:ss').format(state.rangeStartDay!),
        to: DateFormat('yyyy-MM-dd HH:mm:ss').format(state.rangeEndDay!),
        price: calenderBloc.priceController.text));
    popCalenderScreen(newList);
  }

  void popCalenderScreen(List<PriceRange>? priceRanges) {
    navigationKey.currentState?.pop(priceRanges);
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

bool checkEditedElementChanged(TextEditingController priceController, CalenderState state, PriceRange? editedElement) {
  bool isSamePrice = priceController.text == editedElement?.price;
  bool isSameStartDay = state.rangeStartDay?.isAtSameMomentAs(editedElement!.startDay!) ?? false;
  bool isSameEndDay = state.rangeEndDay?.isAtSameMomentAs(editedElement!.endDay!) ?? false;
  return !isSamePrice || !isSameStartDay || !isSameEndDay;
}