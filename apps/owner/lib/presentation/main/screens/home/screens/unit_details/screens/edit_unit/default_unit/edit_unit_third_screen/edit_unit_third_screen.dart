import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/data/remote/region/region_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/main_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/number_counter_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/regions_section_loading_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/regions_section_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/subRegions_section_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/sub_regions_section_loading_widget.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_first_screen/widgets/edit_screens_actions.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/widgets/edit_unit_header.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'bloc/edit_unit_third_bloc.dart';
import 'bloc/edit_unit_third_event.dart';
import 'bloc/edit_unit_third_state.dart';

class EditUnitThirdScreen extends StatelessWidget {
  EditUnitThirdScreen({Key? key}) : super(key: key);
  static const tag = "EditUnitThirdScreen";
  PersistentBottomSheetController? bottomSheetController;
  @override
  Widget build(BuildContext context) {
    final Unit unit = ModalRoute.of(context)!.settings.arguments as Unit;
    TimeOfDay checkIn = parseTime(unit.checkIn);
    TimeOfDay checkOut = parseTime(unit.checkOut);
    String checkInString = checkIn.format(context);
    String checkOutString = checkOut.format(context);
    return BlocProvider<EditUnitThirdBloc>(
      create: (ctx) => EditUnitThirdBloc(RegionRepository(), UnitRepository())
        ..add(const GetRegionsWithSubRegion())
        ..add(InitEditUnitThirdScreen(unit, checkIn, checkOut, checkInString, checkOutString)),
      child: BlocBuilder<EditUnitThirdBloc, EditUnitThirdState>(
        builder: (context, state) {
          EditUnitThirdBloc editUnitThirdBloc = BlocProvider.of(context);
          return WillPopScope(
            onWillPop: () async {
              navigationKey.currentState!.pop(state.unit);
              return false;
            },
            child: CustomSafeArea(
              child: Stack(
                children: [
                  CustomScaffold(
                    appBar: EditUnitHeader(
                      cancelAction: () {
                        if (isUnitDataChanged(editUnitThirdBloc, state.unit, context, state)) {
                          Fluttertoast.showToast(
                              msg: LocaleKeys.changedDataCheckMessage.tr(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: pacificBlue,
                              textColor: kWhite);
                        } else {
                          navigationKey.currentState?.pushNamedAndRemoveUntil(
                              UnitDetailsScreen.tag, ModalRoute.withName(MainScreen.tag),
                              arguments: state.unit?.id);
                        }
                      },
                      margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
                      onBackAction: () {
                        navigationKey.currentState!.pop(state.unit);
                      },
                    ),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    body: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Form(
                            key: EditUnitThirdBloc.formKey,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.addUnitDetails.tr(),
                                        style: circularBold900(color: kWhite, fontSize: 30),
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            alignment: Alignment.center,
                                            child: Image.asset(progress3_4IconPath),
                                          ),
                                          Container(
                                            width: 60,
                                            height: 60,
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              textBaseline: TextBaseline.ideographic,
                                              children: [
                                                Text("3",
                                                    style: circularBold800(
                                                        color: kWhite, fontSize: 24)),
                                                Text("/4",
                                                    style: circularBold800(
                                                        color: kWhite, fontSize: 14)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                      child: CustomTitledRoundedTextFormWidget(
                                        enabled: false,
                                        suffixIcon: Image.asset(timerIconPath, color: kWhite),
                                        controller: editUnitThirdBloc.checkInTimeController,
                                        hintText: LocaleKeys.pleaseChooseCheckInTime.tr(),
                                        title: LocaleKeys.checkInTime.tr(),
                                        textStyle: circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
                                        keyboardType: TextInputType.text,
                                        focusNode: editUnitThirdBloc.checkInTimeFocus,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (name) {},
                                        validator: (value) {
                                          if (value?.isEmpty ?? true) {
                                            return LocaleKeys.validationInsertData.tr();
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        color: Colors.transparent,
                                        width: MediaQuery.of(context).size.width,
                                        height: 80,
                                      ),
                                      onTap: () {
                                        getCheckInTime(context, editUnitThirdBloc, state.checkIn);
                                      },
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                      child: CustomTitledRoundedTextFormWidget(
                                        enabled: false,
                                        suffixIcon: Image.asset(timerIconPath, color: kWhite),
                                        controller: editUnitThirdBloc.checkOutTimeController,
                                        hintText: LocaleKeys.pleaseChooseCheckOutTime.tr(),
                                        title: LocaleKeys.checkOutTime.tr(),
                                        textStyle: circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
                                        keyboardType: TextInputType.text,
                                        focusNode: editUnitThirdBloc.checkOutTimeFocus,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (name) {},
                                        validator: (value) {
                                          if (value?.isEmpty ?? true) {
                                            return LocaleKeys.validationInsertData.tr();
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        color: Colors.transparent,
                                        width: MediaQuery.of(context).size.width,
                                        height: 80,
                                      ),
                                      onTap: () {
                                        getCheckOutTime(context, editUnitThirdBloc, state.checkOut);
                                      },
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Theme.of(context).splashColor,
                                  height: .5,
                                  margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                                ),
                                buildRegionSection(state, editUnitThirdBloc),
                                Container(
                                  color: Theme.of(context).splashColor,
                                  height: .5,
                                  margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                                ),
                                !state.hideSubRegionsSection
                                    ? buildSubRegionSection(state, editUnitThirdBloc, context)
                                    : Container(),
                                !state.hideSubRegionsSection
                                    ? Container(
                                        color: Theme.of(context).splashColor,
                                        height: .5,
                                        margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                                      )
                                    : Container(),
                                NumbersCounter(
                                  incrementNumber: () {
                                    editUnitThirdBloc.add(const IncrementRoomNumberEvent());
                                  },
                                  decrementNumber: () {
                                    editUnitThirdBloc.add(const DecrementRoomNumberEvent());
                                  },
                                  number: state.roomNumber,
                                  title: LocaleKeys.roomNumbers.tr(),
                                ),
                                NumbersCounter(
                                  incrementNumber: () {
                                    editUnitThirdBloc.add(const IncrementBedNumberEvent());
                                  },
                                  decrementNumber: () {
                                    editUnitThirdBloc.add(const DecrementBedNumberEvent());
                                  },
                                  number: state.bedNumber,
                                  title: LocaleKeys.bedNumbers.tr(),
                                ),
                                NumbersCounter(
                                  incrementNumber: () {
                                    editUnitThirdBloc.add(const IncrementBathNumberEvent());
                                  },
                                  decrementNumber: () {
                                    editUnitThirdBloc.add(const DecrementBathNumberEvent());
                                  },
                                  number: state.bathNumber,
                                  title: LocaleKeys.bathNumber.tr(),
                                ),
                                NumbersCounter(
                                  incrementNumber: () {
                                    editUnitThirdBloc.add(const IncrementGuestsNumberEvent());
                                  },
                                  decrementNumber: () {
                                    editUnitThirdBloc.add(const DecrementGuestsNumberEvent());
                                  },
                                  number: state.guestsNumber,
                                  title: LocaleKeys.guestsNumber.tr(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.all(24),
                                child: EditScreensActions(
                                  nextAction: () {
                                    if ((EditUnitThirdBloc.formKey.currentState?.validate() ?? false) &&
                                        !(state.isRegionsLoading ?? true) &&
                                        !(state.isRegionsLoading ?? true)) {
                                      if (isUnitDataChanged(editUnitThirdBloc, unit, context, state)) {
                                        Fluttertoast.showToast(
                                            msg: LocaleKeys.changedDataCheckMessage.tr(),
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: pacificBlue,
                                            textColor: kWhite);
                                      } else {
                                        editUnitThirdBloc.add(const MoveToFourthScreenEvent());
                                      }
                                    }
                                  },
                                  updateAction: () {
                                    if ((EditUnitThirdBloc.formKey.currentState?.validate() ?? false) &&
                                        !(state.isRegionsLoading ?? true) &&
                                        !(state.isRegionsLoading ?? true)) {
                                      if (isUnitDataChanged(editUnitThirdBloc, unit, context, state)) {
                                        editUnitThirdBloc.add(const ThirdScreenUpdateUnit());
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: LocaleKeys.noChangeInDataToUpdateMessage.tr(),
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: pacificBlue,
                                            textColor: kWhite);
                                      }
                                    }
                                  },
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (state.isLoading)
                    Container(
                        color: Colors.black54,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: const LoadingWidget())
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getCheckInTime(BuildContext context, EditUnitThirdBloc addUnitThirdBloc, TimeOfDay? checkIn) async {
    TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: checkIn ?? TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(data: timePickerThemeData(context), child: child ?? Container());
        });
    if (timeOfDay != null) {
      addUnitThirdBloc.add(AddCheckInTime(timeOfDay, timeOfDay.format(context)));
    }
  }

  Future<void> getCheckOutTime(BuildContext context, EditUnitThirdBloc addUnitThirdBloc, TimeOfDay? checkOut) async {
    TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: checkOut ?? TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(data: timePickerThemeData(context), child: child ?? Container());
        });
    if (timeOfDay != null) {
      addUnitThirdBloc.add(AddCheckOutTime(timeOfDay, timeOfDay.format(context)));
    }
  }

  Widget buildRegionSection(EditUnitThirdState state, EditUnitThirdBloc addUnitThirdBloc) {
    if (state.isRegionsLoading != null && state.isRegionsLoading!) {
      return Container(margin: const EdgeInsets.only(top: 20), child: const RegionsSectionLoadingWidget());
    } else {
      if (state.isGetRegionsAndSubRegionsApiError) {
        return Container();
      } else {
        return RegionSectionWidget(
          title: LocaleKeys.region.tr(),
          selectedRegion: state.selectedRegion,
          regions: state.regions,
          addSetRegionEvent: (selectedRegion) {
            addUnitThirdBloc.add(SetRegion(selectedRegion));
          },
          controller: addUnitThirdBloc.regionController,
        );
      }
    }
  }

  Widget buildSubRegionSection(EditUnitThirdState state, EditUnitThirdBloc addUnitThirdBloc, BuildContext context) {
    if (state.isSubRegionsLoading != null && state.isSubRegionsLoading!) {
      return Container(margin: const EdgeInsets.only(top: 20), child: const SubRegionsSectionLoadingWidget());
    } else {
      if (state.isGetRegionsAndSubRegionsApiError) {
        return Container();
      } else {
        if (bottomSheetController != null) {
          Future.delayed(const Duration(milliseconds: 500), () {
            bottomSheetController!.setState!(() {});
          });
        }
        return SubRegionSectionWidget(
          title: LocaleKeys.subRegion.tr(),
          selectedSubRegion: state.selectedSubRegion,
          addSetSubRegionEvent: (selectedSubRegion) {
            addUnitThirdBloc.add(SetSelectedSubRegion(selectedSubRegion));
          },
          controller: addUnitThirdBloc.subRegionController,
          selectedRegion: state.selectedRegion,
        );
      }
    }
  }
}

bool isUnitDataChanged(
    EditUnitThirdBloc editUnitThirdBloc, Unit? unit, BuildContext context, EditUnitThirdState state) {
  debugPrint("state.guestsNumber: ${state.guestsNumber}, unit?.guests: ${unit?.maxNumberOfGuests}");
  TimeOfDay checkIn = parseTime(unit?.checkIn);
  TimeOfDay checkOut = parseTime(unit?.checkOut);
  bool isRegionIdChanged = state.selectedRegion?.id.toString() != unit?.regionId;
  if (state.selectedSubRegion != null) {
    isRegionIdChanged = state.selectedSubRegion?.id.toString() != unit?.regionId;
  }
  return editUnitThirdBloc.checkInTimeController.text.trim() != checkIn.format(context) ||
      editUnitThirdBloc.checkOutTimeController.text.trim() != checkOut.format(context) ||
      isRegionIdChanged ||
      state.roomNumber.toString() != unit?.bedRooms ||
      state.bedNumber.toString() != unit?.beds ||
      state.guestsNumber.toString() != unit?.maxNumberOfGuests ||
      state.bathNumber.toString() != unit?.bathRooms;
}