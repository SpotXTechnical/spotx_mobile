import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/data/remote/region/region_repository.dart';
import 'package:owner/data/remote/reservation/reservation_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/add_reservation_screen/models/add_reservation_config.dart';
import 'package:owner/presentation/main/screens/statistics/screens/filter/utils.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/header.dart';
import '../../../../../../../utils/date_utils/utils.dart';
import 'bloc/add_reservation_bloc.dart';
import 'bloc/add_reservation_event.dart';
import 'bloc/add_reservation_state.dart';
import 'widget/shimmer_section_widget.dart';

class AddReservationScreen extends StatelessWidget {
  const AddReservationScreen({Key? key}) : super(key: key);
  static const tag = "AddReservationScreen";
  @override
  Widget build(BuildContext context) {
    final AddReservationConfig? config = ModalRoute.of(context)!.settings.arguments as AddReservationConfig?;
    return BlocProvider<AddReservationBloc>(
      create: (ctx) =>
          AddReservationBloc(RegionRepository(), UnitRepository(), ReservationRepository())..add(GetRegions(config)),
      child: BlocBuilder<AddReservationBloc, AddReservationState>(
        builder: (context, state) {
          AddReservationBloc addReservationBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              resizeToAvoidBottomInset: true,
              appBar: const Header(
                margin: EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
              ),
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
                              key: AddReservationBloc.formKey,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          LocaleKeys.addNewReservation.tr(),
                                          style: poppinsBold(color: kWhite, fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (config == null)
                                    state.isRegionLoading || state.regions == null
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: const EdgeInsetsDirectional
                                                    .only(
                                                start: 24, end: 24, top: 10),
                                            child: const ShimmerSectionWidget(),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(top: 8),
                                            child: buildRegionSection(
                                                state.regions!,
                                                state.selectedRegion!,
                                                (selectedRegionId) =>
                                                    addReservationBloc.add(SetRegionEvent(selectedRegionId)),
                                                addReservationBloc.regionController)),
                                  if (config == null)
                                    state.isUnitsLoading
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: const EdgeInsetsDirectional
                                                    .only(
                                                start: 24, end: 24, top: 10),
                                            child: const ShimmerSectionWidget(),
                                          )
                                        : Container(
                                            margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                            child: GestureDetector(
                                              child: Container(
                                                color: Colors.transparent,
                                                child: CustomTitledRoundedTextFormWidget(
                                                  controller: addReservationBloc.unitController,
                                                  hintText: LocaleKeys.chooseUnit.tr(),
                                                  title: LocaleKeys.chooseUnit.tr(),
                                                  textStyle:
                                                      circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
                                                  keyboardType: TextInputType.number,
                                                  focusNode: addReservationBloc.unitFocus,
                                                  textInputAction: TextInputAction.next,
                                                  suffixIcon:
                                                      Image.asset(arrowDownIcon, color: kWhite),
                                                  enabled: false,
                                                  onFieldSubmitted: (name) {
                                                    addReservationBloc.unitFocus.unfocus();
                                                  },
                                                  validator: (value) {
                                                    if (value?.isEmpty ?? true) {
                                                      return LocaleKeys.validationInsertData.tr();
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),
                                              ),
                                              onTap: () {
                                                FocusScope.of(context).unfocus();
                                                if (state.units != null) {
                                                  showAndroidBottomSheet(
                                                      context, state.units!, state.addReservationConfig!.id, (unit) {
                                                    addReservationBloc.add(SetUnitEvent(unit));
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                  Form(
                                    key: AddReservationBloc.datesFormKey,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                            child: Container(
                                              margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                              child: CustomTitledRoundedTextFormWidget(
                                                controller: addReservationBloc.startDateController,
                                                hintText: LocaleKeys.startDate.tr(),
                                                title: LocaleKeys.startDate.tr(),
                                                textInputAction: TextInputAction.next,
                                                textStyle:
                                                    circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
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
                                              ),
                                            ),
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              getDateData(
                                                  context: context,
                                                  action: (date) {
                                                    addReservationBloc.add(
                                                        AddStartDateEvent(
                                                            date,
                                                        DateFormat.yMd(context.locale.languageCode).format(date)
                                                      )
                                                    );
                                                  },
                                                  startDate: state.startDate);
                                            }),
                                        GestureDetector(
                                          child: Container(
                                            margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                            child: CustomTitledRoundedTextFormWidget(
                                              controller: addReservationBloc.endDateController,
                                              hintText: LocaleKeys.endDate.tr(),
                                              title: LocaleKeys.endDate.tr(),
                                              textInputAction: TextInputAction.next,
                                              textStyle:
                                                  circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
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
                                            ),
                                          ),
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            getDateData(
                                                context: context,
                                                action: (date) {
                                                  addReservationBloc.add(AddEndDateEvent(
                                                      date, DateFormat.yMd(context.locale.languageCode).format(date)));
                                                },
                                                startDate: state.endDate);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
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
                              margin: const EdgeInsetsDirectional.only(end: 24, start: 24, bottom: 24, top: 24),
                              child: AppButtonGradient(
                                title: LocaleKeys.add.tr(),
                                height: 55,
                                borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                                isLoading: state.isLoading,
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
                                  if (!state.isLoading) {
                                    await Future.delayed(const Duration(milliseconds: 100));
                                    var isFormValid = AddReservationBloc.formKey.currentState?.validate() ?? false;
                                    var isDatesValid =
                                        AddReservationBloc.datesFormKey.currentState?.validate() ?? false;
                                    if (isFormValid && isDatesValid) {
                                      FocusScope.of(context).unfocus();
                                      addReservationBloc.add(const PostReservationEvent());
                                    } else {
                                      addReservationBloc.add(const HideError());
                                    }
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

  Future<void> getDateData(
      {required BuildContext context, required Function(DateTime) action, DateTime? startDate}) async {
    DateTime now = DateTime.now();
    var date = await getDateAfterToday(context, startDate ?? DateTime(now.year, now.month, now.day + 1));
    if (date != null) {
      action(date);
    }
  }
}