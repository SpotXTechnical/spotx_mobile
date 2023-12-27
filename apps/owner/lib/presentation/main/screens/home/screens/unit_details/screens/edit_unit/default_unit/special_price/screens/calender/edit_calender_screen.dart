import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/data/remote/add_unit/model/edited_calender_price_range.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/price_range/price_range_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/screens/calender/bloc/calender_bloc.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/screens/calender/bloc/edit_calender_bloc.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/screens/calender/bloc/edit_calender_event.dart';
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
import 'package:owner/utils/widgets/loading_widget.dart';

import 'bloc/edit_calender_state.dart';

class EditCalenderScreen extends StatelessWidget {
  static const tag = "EditCalenderScreen";

  const EditCalenderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final editedCalenderPriceRange = ModalRoute.of(context)!.settings.arguments as EditedCalenderPriceRange?;
    return BlocProvider(
        create: (ctx) => EditCalenderBloc(PriceRangeRepository())
          ..add(EditCalenderInitDataEvent(
              DateTime.now(), editedCalenderPriceRange?.list, editedCalenderPriceRange?.editedElement)),
        child: BlocBuilder<EditCalenderBloc, EditCalenderState>(builder: (context, state) {
          EditCalenderBloc editCalenderBloc = BlocProvider.of(context);
          return WillPopScope(
            onWillPop: () async {
              popCalenderScreen(state.priceRanges);
              return false;
            },
            child: CustomSafeArea(
              child: Stack(
                children: [
                  CustomScaffold(
                    appBar: Header(
                      margin: const EdgeInsetsDirectional.only(top: 24, start: 24, end: 24),
                      title: LocaleKeys.addSpecialPrice.tr(),
                      onBackAction: () {
                        if (editedCalenderPriceRange != null && editedCalenderPriceRange.editedElement != null) {
                          if (checkEditedElementChanged(
                              editCalenderBloc.priceController, state, editedCalenderPriceRange.editedElement)) {
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
                                                    style:
                                                        circularBook(color: kWhite, fontSize: 24)),
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
                                              child:
                                                  Image.asset(arrowMiddleIconPath, color: kWhite)),
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
                                                    style:
                                                        circularBook(color: kWhite, fontSize: 24)),
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
                          state.focusedDay == null
                              ? Container()
                              : TableCalendarPrices(
                                  specialPrice: state.specialPrice ?? editCalenderBloc.priceController.text,
                                  defaultPrice: editedCalenderPriceRange?.defaultPrice ?? "",
                                  firstDay: kFirstDay,
                                  priceRanges: state.priceRanges!,
                                  lastDay: kLastDay,
                                  focusedDay: state.focusedDay!,
                                  selectedDayPredicate: (day) => isSameDay(state.selectedDay, day),
                                  rangeStartDay: state.rangeStartDay,
                                  rangeEndDay: state.rangeEndDay,
                                  rangeSelectionMode: state.rangeSelectionMode,
                                  onDisabledDayTapped: (day) {
                                    Fluttertoast.showToast(
                                        msg: LocaleKeys.disabledDayMessage.tr(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
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
                                      startedDay = "$day $month";
                                      startDayWeekName = DateFormat('EEE').format(start);
                                    } else {
                                      startedDay = "-  -  -";
                                      startDayWeekName = "-  -  -";
                                    }
                                    if (end != null) {
                                      String month = months[end.month - 1];
                                      String day = end.day.toString();
                                      endedDay = "$day $month";
                                      endDayWeekName = DateFormat('EEE').format(end);
                                    } else {
                                      endedDay = "-  -  -";
                                      endDayWeekName = "-  -  -";
                                    }
                                    editCalenderBloc.add(EditCalenderRangeSelectedEvent(
                                        focusedDay,
                                        RangeSelectionMode.toggledOn,
                                        null,
                                        start,
                                        end,
                                        startedDay,
                                        endedDay,
                                        startDayWeekName,
                                        endDayWeekName));
                                  },
                                  onPageChanged: (focusedDay) {
                                    editCalenderBloc
                                        .add(EditCalenderInitDataEvent(focusedDay, state.priceRanges, null));
                                  },
                                ),
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Form(
                                  key: CalenderBloc.formKey,
                                  child: Container(
                                      margin: const EdgeInsetsDirectional.only(start: 24, end: 10, bottom: 18),
                                      child: CustomTitledRoundedTextFormWidget(
                                          onChanged: (value) {
                                            editCalenderBloc.add(EditCalenderUpdateSpecialPrice(value));
                                          },
                                          autoFocus: true,
                                          title: LocaleKeys.specialPrice.tr(),
                                          hintText: LocaleKeys.eg2000.tr(),
                                          controller: editCalenderBloc.priceController,
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
                                  toggleSize: 28.0,
                                  borderRadius: 50.0,
                                  activeColor: Theme.of(context).primaryColorLight,
                                  value: state.isOffer,
                                  onToggle: (value) {
                                    editCalenderBloc.add(EditCalenderChangeOfferStateEvent(value));
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
                                      child: Text(
                                          editedCalenderPriceRange?.editedElement == null
                                              ? LocaleKeys.add.tr()
                                              : LocaleKeys.edit.tr(),
                                          style: circularMedium(color: kWhite, fontSize: 17))),
                                ),
                                action: () async {
                                  if (CalenderBloc.formKey.currentState?.validate() ?? false) {
                                    if (state.rangeStartDay != null && state.rangeEndDay != null) {
                                      if (editedCalenderPriceRange != null &&
                                          editedCalenderPriceRange.editedElement != null) {
                                        editPriceRange(state, editCalenderBloc, editedCalenderPriceRange,
                                            editedCalenderPriceRange.unitId);
                                      } else {
                                        addAnewPriceRange(state, editCalenderBloc, editedCalenderPriceRange?.unitId);
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: LocaleKeys.pleaseSelectRange.tr(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
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
                  if (state.isLoading)
                    Container(
                        color: Colors.black54,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: const LoadingWidget()),
                ],
              ),
            ),
          );
        }));
  }

  void editPriceRange(EditCalenderState state, EditCalenderBloc calenderBloc,
      EditedCalenderPriceRange editedCalenderPriceRange, String? unitId) {
    var priceRange = PriceRange(
        id: editedCalenderPriceRange.editedElement?.id,
        isOffer: state.isOffer ? 1 : 0,
        startDay: state.rangeStartDay,
        endDay: state.rangeEndDay,
        from: DateFormat('yyyy-MM-dd HH:mm:ss').format(state.rangeStartDay!),
        to: DateFormat('yyyy-MM-dd HH:mm:ss').format(state.rangeEndDay!),
        price: calenderBloc.priceController.text);
    List<PriceRange>? list = state.priceRanges;
    list?.insert(editedCalenderPriceRange.index!, priceRange);
    calenderBloc.add(EditCalenderEditPriceRangeEvent(priceRange, unitId!, list!));
  }

  void addAnewPriceRange(EditCalenderState state, EditCalenderBloc bloc, String? unitId) {
    List<PriceRange>? oldList = state.priceRanges;
    List<PriceRange> newList = PriceRange.createNewListOfPriceRange(oldList);
    PriceRange priceRange = PriceRange(
        isOffer: state.isOffer ? 1 : 0,
        startDay: state.rangeStartDay,
        endDay: state.rangeEndDay,
        from: DateFormat('yyyy-MM-dd HH:mm:ss').format(state.rangeStartDay!),
        to: DateFormat('yyyy-MM-dd HH:mm:ss').format(state.rangeEndDay!),
        price: bloc.priceController.text);
    newList.add(priceRange);
    bloc.add(EditCalenderAddPriceRangeEvent(priceRange, unitId!, newList));
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

bool checkEditedElementChanged(
    TextEditingController priceController, EditCalenderState state, PriceRange? editedElement) {
  bool isSamePrice = priceController.text == editedElement?.price;
  bool isSameStartDay = state.rangeStartDay?.isAtSameMomentAs(editedElement!.startDay!) ?? false;
  bool isSameEndDay = state.rangeEndDay?.isAtSameMomentAs(editedElement!.endDay!) ?? false;
  return !isSamePrice || !isSameStartDay || !isSameEndDay;
}