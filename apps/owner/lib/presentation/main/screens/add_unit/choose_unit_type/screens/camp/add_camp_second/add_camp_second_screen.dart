import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/data/remote/region/region_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/regions_section_loading_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/regions_section_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/subRegions_section_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/sub_regions_section_loading_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/image_upload_section.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/header.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'bloc/add_camp_second_bloc.dart';
import 'bloc/add_camp_second_event.dart';
import 'bloc/add_camp_second_state.dart';

class AddCampSecondScreen extends StatelessWidget {
  const AddCampSecondScreen({Key? key}) : super(key: key);
  static const tag = "AddCampSecondScreen";
  @override
  Widget build(BuildContext context) {
    final Unit unit = ModalRoute.of(context)!.settings.arguments as Unit;
    return BlocProvider<AddCampSecondBloc>(
      create: (ctx) => AddCampSecondBloc(RegionRepository(), UnitRepository())..add(const GetRegionsWithSubRegion()),
      child: BlocBuilder<AddCampSecondBloc, AddCampSecondState>(
        builder: (context, state) {
          AddCampSecondBloc addCampSecondBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              resizeToAvoidBottomInset: true,
              appBar: const Header(
                margin: EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: state.isLoading
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: LoadingWidget(),
                      ),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Form(
                            key: AddCampSecondBloc.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.addUnitDetails.tr(),
                                        style: circularBold800(color: kWhite, fontSize: 30),
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            alignment: Alignment.center,
                                            child: Image.asset(progress2_4IconPath),
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
                                                Text("2",
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
                                buildRegionSection(state, addCampSecondBloc),
                                Container(
                                  color: Theme.of(context).splashColor,
                                  height: .5,
                                  margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                                ),
                                !state.hideSubRegionsSection
                                    ? buildSubRegionSection(state, addCampSecondBloc, context)
                                    : Container(),
                                !state.hideSubRegionsSection
                                    ? Container(
                                        color: Theme.of(context).splashColor,
                                        height: .5,
                                        margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                                      )
                                    : Container(),
                                ImageUploadSection(
                                  imageError: state.imageError,
                                  mediaFiles: state.files ?? List.empty(),
                                  addFilesAction: (files) {
                                    addCampSecondBloc.add(AddCampSecondScreenAddFilesToListEvent(files));
                                  },
                                  deleteFileLocallyAction: (element) {
                                    addCampSecondBloc.add(DeleteImageLocallyEvent(element));
                                  },
                                  loadingMediaAction: (path) {
                                    addCampSecondBloc.add(LoadingMediaEvent(path));
                                  },
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                      child: CustomTitledRoundedTextFormWidget(
                                        suffixIcon: Image.asset(timerIconPath, color: kWhite),
                                        controller: addCampSecondBloc.checkInTimeController,
                                        hintText: LocaleKeys.pleaseChooseCheckInTime.tr(),
                                        title: LocaleKeys.checkInTime.tr(),
                                        textStyle: circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
                                        keyboardType: TextInputType.text,
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
                                        getCheckInTime(context, addCampSecondBloc, state.checkIn);
                                      },
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                      child: CustomTitledRoundedTextFormWidget(
                                        suffixIcon: Image.asset(timerIconPath, color: kWhite),
                                        controller: addCampSecondBloc.checkOutTimeController,
                                        hintText: LocaleKeys.pleaseChooseCheckOutTime.tr(),
                                        title: LocaleKeys.checkOutTime.tr(),
                                        textStyle: circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
                                        keyboardType: TextInputType.text,
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
                                        getCheckOutTime(context, addCampSecondBloc, state.checkOut);
                                      },
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.published.tr(),
                                        style: circularBook(color: kWhite, fontSize: 17),
                                      ),
                                      FlutterSwitch(
                                        height: 30.0,
                                        width: 55.0,
                                        padding: 4.0,
                                        toggleSize: 28.0,
                                        borderRadius: 50.0,
                                        activeColor: Theme.of(context).primaryColorLight,
                                        value: state.isPublished,
                                        onToggle: (value) {
                                          addCampSecondBloc.add(ChangeIsPublishedEvent(value));
                                        },
                                      ),
                                    ],
                                  ),
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
                                  if (AddCampSecondBloc.formKey.currentState?.validate() ?? false) {
                                    addCampSecondBloc.add(MoveToFourthScreenEvent(unit));
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

  Future<void> getCheckInTime(BuildContext context, AddCampSecondBloc addCampSecondBloc, TimeOfDay? checkIn) async {
    TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: checkIn ?? TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(data: timePickerThemeData(context), child: child ?? Container());
        });
    if (timeOfDay != null) {
      addCampSecondBloc.add(AddCheckInTime(timeOfDay, timeOfDay.format(context)));
    }
  }

  Future<void> getCheckOutTime(BuildContext context, AddCampSecondBloc addCampSecondBloc, TimeOfDay? checkOut) async {
    TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: checkOut ?? TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(data: timePickerThemeData(context), child: child ?? Container());
        });
    if (timeOfDay != null) {
      addCampSecondBloc.add(AddCheckOutTime(timeOfDay, timeOfDay.format(context)));
    }
  }

  Widget buildRegionSection(AddCampSecondState state, AddCampSecondBloc addCampSecondBloc) {
    if (state.regions != null && state.regions!.isNotEmpty) {
      return RegionSectionWidget(
        title: LocaleKeys.region.tr(),
        selectedRegion: state.selectedRegion,
        regions: state.regions!,
        addSetRegionEvent: (selectedRegion) {
          addCampSecondBloc.add(AddCampSecondSetRegion(selectedRegion));
        },
        controller: addCampSecondBloc.regionController,
      );
    } else {
      if (state.isGetRegionsAndSubRegionsApiError) {
        return Container();
      } else {
        return Container(margin: const EdgeInsets.only(top: 20), child: const RegionsSectionLoadingWidget());
      }
    }
  }

  Widget buildSubRegionSection(AddCampSecondState state, AddCampSecondBloc addCampSecondBloc, BuildContext context) {
    if (state.isSubRegionsLoading) {
      return Container(margin: const EdgeInsets.only(top: 20), child: const SubRegionsSectionLoadingWidget());
    } else {
      if (state.isGetRegionsAndSubRegionsApiError) {
        return Container();
      } else {
        return SubRegionSectionWidget(
          title: LocaleKeys.subRegion.tr(),
          selectedSubRegion: state.selectedSubRegion,
          addSetSubRegionEvent: (selectedSubRegion) {
            addCampSecondBloc.add(AddCampSecondSetSubRegion(selectedSubRegion));
          },
          controller: addCampSecondBloc.subRegionController,
          selectedRegion: state.selectedRegion,
        );
      }
    }
  }
}