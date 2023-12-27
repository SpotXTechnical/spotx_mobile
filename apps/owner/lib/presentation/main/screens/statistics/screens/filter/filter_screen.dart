import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/data/remote/region/region_repository.dart';
import 'package:owner/data/remote/statistics/model/statistics_filter.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/filter/bloc/filter_bloc.dart';
import 'package:owner/presentation/main/screens/statistics/screens/filter/bloc/filter_event.dart';
import 'package:owner/presentation/main/screens/statistics/screens/filter/utils.dart';
import 'package:owner/presentation/main/screens/statistics/screens/filter/widgets/filter_header.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

import '../../../../../../utils/date_utils/utils.dart';
import 'bloc/filter_state.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);
  static const tag = "FilterScreen";
  @override
  Widget build(BuildContext context) {
    final StatisticsFilter? statisticsFilter = ModalRoute.of(context)!.settings.arguments as StatisticsFilter?;

    return BlocProvider<FilterBloc>(
      create: (ctx) => FilterBloc(RegionRepository(), UnitRepository())
        ..add(const GetRegions())
        ..add(SetStatisticsFilter(statisticsFilter, context.locale.languageCode)),
      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          FilterBloc filterBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: !state.hasUnit
                  ? Expanded(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                              child: Text(
                            LocaleKeys.homeEmptyDataMessage.tr(),
                            style: poppinsMedium(color: Theme.of(context).disabledColor, fontSize: 15),
                          ))),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            child: Form(
                              key: FilterBloc.formKey,
                              child: Column(
                                children: [
                                  FilterHeader(
                                    resetAction: () {
                                      if (state.regions != null &&
                                          state.regions!.isNotEmpty &&
                                          state.units != null &&
                                          state.units!.isNotEmpty) {
                                        filterBloc.add(const ResetFilter());
                                      }
                                    },
                                  ),
                                  state.isRegionLoading || state.regions == null
                                      ? Container(
                                          margin: const EdgeInsets.only(top: 32),
                                          width: MediaQuery.of(context).size.width,
                                          child: const LoadingWidget(),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.only(top: 32),
                                          child: buildRegionSection(
                                              state.regions!,
                                              state.selectedRegion!,
                                              (selectedRegion) => filterBloc.add(SetRegionEvent(selectedRegion)),
                                              filterBloc.regionController)),
                                  state.isUnitsLoading
                                      ? Container(
                                          margin: const EdgeInsets.only(top: 32),
                                          width: MediaQuery.of(context).size.width,
                                          child: const LoadingWidget(),
                                        )
                                      : Container(
                                          margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 5),
                                          child: GestureDetector(
                                            child: Container(
                                              color: Colors.transparent,
                                              child: CustomTitledRoundedTextFormWidget(
                                                controller: filterBloc.unitController,
                                                hintText: LocaleKeys.chooseUnit.tr(),
                                                textStyle:
                                                    circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
                                                title: LocaleKeys.chooseUnit.tr(),
                                                focusNode: filterBloc.unitFocus,
                                                textInputAction: TextInputAction.next,
                                                suffixIcon:
                                                    Image.asset(arrowDownIcon, color: kWhite),
                                                enabled: false,
                                                onFieldSubmitted: (name) {
                                                  filterBloc.unitFocus.unfocus();
                                                },
                                                validator: (value) {
                                                  if (value?.isEmpty ?? true) {
                                                    return LocaleKeys.validationInsertData.tr();
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                autoFocus: true,
                                              ),
                                            ),
                                            onTap: () {
                                              if (state.units != null) {
                                                showAndroidBottomSheet(context, state.units!, state.selectedUnit!.id!,
                                                    (unit) {
                                                  filterBloc.add(SetUnitEvent(unit));
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                  Form(
                                      key: FilterBloc.datesFormKey,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 5),
                                            child: GestureDetector(
                                              child: Container(
                                                color: Colors.transparent,
                                                child: CustomTitledRoundedTextFormWidget(
                                                  controller: filterBloc.startDateController,
                                                  hintText: LocaleKeys.dateExample.tr(),
                                                  title: LocaleKeys.startDate.tr(),
                                                  keyboardType: TextInputType.number,
                                                  focusNode: filterBloc.startDateFocus,
                                                  textStyle:
                                                      circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
                                                  textInputAction: TextInputAction.next,
                                                  suffixIcon:
                                                      Image.asset(calenderIconPath, color: kWhite),
                                                  enabled: false,
                                                  onFieldSubmitted: (name) {},
                                                  validator: (value) {
                                                    if (value?.isEmpty ?? true) {
                                                      return LocaleKeys.validationInsertData.tr();
                                                    } else if (checkDatesAlignments(state.startDate, state.endDate)) {
                                                      return LocaleKeys.datesMisAlignmentError.tr();
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  autoFocus: true,
                                                ),
                                              ),
                                              onTap: () {
                                                getDateData(context, (date) {
                                                  filterBloc.add(AddStartDateEvent(date, context.locale.languageCode));
                                                }, state.startDate);
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 5),
                                            child: GestureDetector(
                                              child: Container(
                                                color: Colors.transparent,
                                                child: CustomTitledRoundedTextFormWidget(
                                                  controller: filterBloc.endDateController,
                                                  hintText: LocaleKeys.dateExample.tr(),
                                                  title: LocaleKeys.endDate.tr(),
                                                  keyboardType: TextInputType.number,
                                                  focusNode: filterBloc.endDateFocus,
                                                  textStyle:
                                                      circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
                                                  textInputAction: TextInputAction.next,
                                                  suffixIcon:
                                                      Image.asset(calenderIconPath, color: kWhite),
                                                  enabled: false,
                                                  onFieldSubmitted: (name) {},
                                                  validator: (value) {
                                                    if (value?.isEmpty ?? true) {
                                                      return LocaleKeys.validationInsertData.tr();
                                                    } else if (checkDatesAlignments(state.startDate, state.endDate)) {
                                                      return LocaleKeys.datesMisAlignmentError.tr();
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  autoFocus: true,
                                                ),
                                              ),
                                              onTap: () {
                                                getDateData(context, (date) {
                                                  filterBloc.add(AddEndDateEvent(date, context.locale.languageCode));
                                                }, state.endDate);
                                              },
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsetsDirectional.only(end: 24, start: 24, bottom: 24),
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
                                      var isFormValid = FilterBloc.formKey.currentState?.validate() ?? false;
                                      if (isFormValid) {
                                        FocusScope.of(context).unfocus();
                                        navigationKey.currentState?.pop(StatisticsFilter(
                                            startDate: state.startDate,
                                            endData: state.endDate,
                                            unit: state.selectedUnit,
                                            region: state.selectedRegion));
                                      }
                                    })),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getDateData(BuildContext context, Function(DateTime) action, DateTime? initialDate) async {
    DateTime nowDate = DateTime.now();
    DateTime defaultStartDate =
        DateTime(nowDate.year - 1, nowDate.month, nowDate.day, nowDate.hour, nowDate.minute, nowDate.second);
    var date = await getDate(context, startDate: defaultStartDate, initialDate: initialDate);
    if (date != null) {
      action(date);
    }
  }
}