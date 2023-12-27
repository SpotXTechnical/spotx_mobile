import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/region_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/number_counter_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/regions_section_loading_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/regions_section_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/subRegions_section_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/sub_regions_section_loading_widget.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/header.dart';
import 'bloc/add_unit_third_bloc.dart';
import 'bloc/add_unit_third_event.dart';
import 'bloc/add_unit_third_state.dart';

class AddUnitThirdScreen extends StatelessWidget {
  AddUnitThirdScreen({Key? key}) : super(key: key);
  static const tag = "AddUnitThirdScreen";
  PersistentBottomSheetController? bottomSheetController;
  @override
  Widget build(BuildContext context) {
    final Unit unit = ModalRoute.of(context)!.settings.arguments as Unit;
    return BlocProvider<AddUnitThirdBloc>(
      create: (ctx) => AddUnitThirdBloc(RegionRepository())..add(const GetRegionsWithSubRegion()),
      child: BlocBuilder<AddUnitThirdBloc, AddUnitThirdState>(
        builder: (context, state) {
          AddUnitThirdBloc addUnitThirdBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: const Header(
                margin: EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Form(
                      key: AddUnitThirdBloc.formKey,
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
                                              style: circularBold800(color: kWhite, fontSize: 24)),
                                          Text("/4",
                                              style: circularBold800(color: kWhite, fontSize: 14)),
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
                                  controller: addUnitThirdBloc.checkInTimeController,
                                  hintText: LocaleKeys.pleaseChooseCheckInTime.tr(),
                                  title: LocaleKeys.checkInTime.tr(),
                                  textStyle: circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
                                  keyboardType: TextInputType.text,
                                  focusNode: addUnitThirdBloc.checkInTimeFocus,
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
                                  getCheckInTime(context, addUnitThirdBloc, state.checkIn);
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
                                  controller: addUnitThirdBloc.checkOutTimeController,
                                  hintText: LocaleKeys.pleaseChooseCheckOutTime.tr(),
                                  title: LocaleKeys.checkOutTime.tr(),
                                  textStyle: circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
                                  keyboardType: TextInputType.text,
                                  focusNode: addUnitThirdBloc.checkOutTimeFocus,
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
                                  getCheckOutTime(context, addUnitThirdBloc, state.checkOut);
                                },
                              ),
                            ],
                          ),
                          Container(
                            color: Theme.of(context).splashColor,
                            height: .5,
                            margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                          ),
                          buildRegionSection(state, addUnitThirdBloc),
                          Container(
                            color: Theme.of(context).splashColor,
                            height: .5,
                            margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                          ),
                          !state.hideSubRegionsSection
                              ? buildSubRegionSection(state, addUnitThirdBloc, context)
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
                              addUnitThirdBloc.add(const IncrementRoomNumberEvent());
                            },
                            decrementNumber: () {
                              addUnitThirdBloc.add(const DecrementRoomNumberEvent());
                            },
                            number: state.roomNumber,
                            title: LocaleKeys.roomNumbers.tr(),
                          ),
                          NumbersCounter(
                            incrementNumber: () {
                              addUnitThirdBloc.add(const IncrementBedNumberEvent());
                            },
                            decrementNumber: () {
                              addUnitThirdBloc.add(const DecrementBedNumberEvent());
                            },
                            number: state.bedNumber,
                            title: LocaleKeys.bedNumbers.tr(),
                          ),
                          NumbersCounter(
                            incrementNumber: () {
                              addUnitThirdBloc.add(const IncrementBathNumberEvent());
                            },
                            decrementNumber: () {
                              addUnitThirdBloc.add(const DecrementBathNumberEvent());
                            },
                            number: state.bathNumber,
                            title: LocaleKeys.bathNumber.tr(),
                          ),
                          NumbersCounter(
                            incrementNumber: () {
                              addUnitThirdBloc.add(const IncrementGuestsNumberEvent());
                            },
                            decrementNumber: () {
                              addUnitThirdBloc.add(const DecrementGuestsNumberEvent());
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
                                child: Text(LocaleKeys.next.tr(),
                                    style: circularMedium(color: kWhite, fontSize: 17))),
                          ),
                          action: () async {
                            if (AddUnitThirdBloc.formKey.currentState?.validate() ?? false) {
                              addUnitThirdBloc.add(MoveToFourthScreenEvent(unit));
                            }
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getCheckInTime(BuildContext context, AddUnitThirdBloc addUnitThirdBloc, TimeOfDay? checkIn) async {
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

  Future<void> getCheckOutTime(BuildContext context, AddUnitThirdBloc addUnitThirdBloc, TimeOfDay? checkOut) async {
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

  Widget buildRegionSection(AddUnitThirdState state, AddUnitThirdBloc addUnitThirdBloc) {
    if (state.regions != null && state.regions!.isNotEmpty) {
      return RegionSectionWidget(
        title: LocaleKeys.region.tr(),
        selectedRegion: state.selectedRegion,
        regions: state.regions!,
        addSetRegionEvent: (selectedRegion) {
          addUnitThirdBloc.add(SetRegion(selectedRegion));
        },
        controller: addUnitThirdBloc.regionController,
      );
    } else {
      if (state.isGetRegionsAndSubRegionsApiError) {
        return Container();
      } else {
        return Container(margin: const EdgeInsets.only(top: 20), child: const RegionsSectionLoadingWidget());
      }
    }
  }

  Widget buildSubRegionSection(AddUnitThirdState state, AddUnitThirdBloc addUnitThirdBloc, BuildContext context) {
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