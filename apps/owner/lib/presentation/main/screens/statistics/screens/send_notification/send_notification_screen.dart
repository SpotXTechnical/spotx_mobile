import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:owner/data/local/shared_prefs_manager.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/data/remote/region/region_repository.dart';
import 'package:owner/data/remote/statistics/statistics_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/filter/utils.dart';
import 'package:owner/presentation/main/screens/statistics/screens/send_notification/bloc/send_notification_bloc.dart';
import 'package:owner/presentation/main/screens/statistics/screens/send_notification/bloc/send_notification_event.dart';
import 'package:owner/presentation/main/screens/statistics/screens/send_notification/widgets/notification_message.dart';
import 'package:owner/presentation/main/screens/statistics/screens/send_notification/widgets/regions_section_widget.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/screens/add_payment/bloc/add_payment_bloc.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/header.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

import '../../../../../../data/remote/add_unit/model/unit.dart';
import 'bloc/send_notification_state.dart';

class SendNotificationScreen extends StatelessWidget {
  const SendNotificationScreen({Key? key}) : super(key: key);
  static const tag = "SendNotificationScreen";

  @override
  Widget build(BuildContext context) {
    User? user = Injector().get<SharedPrefsManager>().credentials?.user;
    return BlocProvider<SendNotificationBloc>(
      create: (ctx) =>
          SendNotificationBloc(RegionRepository(), UnitRepository(), StatisticsRepository())..add(const GetRegions()),
      child: BlocBuilder<SendNotificationBloc, SendNotificationState>(
        builder: (context, state) {
          SendNotificationBloc sendNotificationBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              resizeToAvoidBottomInset: true,
              appBar: const Header(
                margin: EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: state.isUnitsLoading
                  ? Container(
                      margin: const EdgeInsets.only(top: 32),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const LoadingWidget(),
                    )
                  : !state.hasUnit
                      ? SizedBox(
                          child: Center(
                              child: Text(
                          LocaleKeys.homeEmptyDataMessage.tr(),
                          style: poppinsMedium(color: Theme.of(context).disabledColor, fontSize: 15),
                        )))
                      : CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: SizedBox(
                                child: Form(
                                  key: AddPaymentBloc.formKey,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              LocaleKeys.sendNotification.tr(),
                                              style: poppinsBold(color: kWhite, fontSize: 24),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (user?.notificationCount != null)
                                        NotificationMessage(
                                          notificationCount: user!.notificationCount!,
                                        ),
                                      state.isRegionLoading || state.regions == null
                                          ? Container(
                                              margin: const EdgeInsets.only(top: 32),
                                              width: MediaQuery.of(context).size.width,
                                              child: const LoadingWidget(),
                                            )
                                          : Container(
                                              margin: const EdgeInsets.only(top: 32),
                                              child: RegionSectionWidget(
                                                regions: state.regions!,
                                                selectedRegion: state.selectedRegionId,
                                                addSetRegionEvent: (selectedRegionId) {
                                                  sendNotificationBloc.add(SetRegionEvent(selectedRegionId));
                                                },
                                                title: LocaleKeys.region.tr(),
                                                isAllSelected: state.isAllRegionsSelected,
                                                allSelectedAction: () {
                                                  sendNotificationBloc.add(const ToggleAllRegions());
                                                },
                                              )),
                                      Container(
                                        margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                        child: GestureDetector(
                                          child: Container(
                                            color: Colors.transparent,
                                            child: CustomTitledRoundedTextFormWidget(
                                              controller: sendNotificationBloc.unitController,
                                              hintText: LocaleKeys.chooseUnit.tr(),
                                              title: LocaleKeys.chooseUnit.tr(),
                                              keyboardType: TextInputType.number,
                                              focusNode: sendNotificationBloc.unitFocus,
                                              textInputAction: TextInputAction.next,
                                              suffixIcon: Image.asset(arrowDownIcon),
                                              enabled: false,
                                              onFieldSubmitted: (name) {
                                                sendNotificationBloc.unitFocus.unfocus();
                                                FocusScope.of(context).requestFocus(sendNotificationBloc.messageFocus);
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
                                              showAndroidBottomSheet(
                                                  context,
                                                  [Unit(id: "0", title: LocaleKeys.all.tr()), ...state.units!],
                                                  state.selectedUnit!.id!, (unit) {
                                                sendNotificationBloc.add(SetUnitEvent(unit));
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                        child: CustomTitledRoundedTextFormWidget(
                                          controller: sendNotificationBloc.messageController,
                                          hintText: LocaleKeys.writeMessage.tr(),
                                          maxLines: 4,
                                          title: LocaleKeys.message.tr(),
                                          keyboardType: TextInputType.text,
                                          focusNode: sendNotificationBloc.messageFocus,
                                          textInputAction: TextInputAction.next,
                                          onFieldSubmitted: (name) {
                                            sendNotificationBloc.messageFocus.unfocus();
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
                                    title: LocaleKeys.next.tr(),
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
                                          child: Text(LocaleKeys.next.tr(),
                                              style: circularMedium(color: kWhite, fontSize: 17))),
                                    ),
                                    action: () async {
                                      if (!state.isLoading) {
                                        await Future.delayed(const Duration(milliseconds: 100));
                                        if (AddPaymentBloc.formKey.currentState?.validate() ?? false) {
                                          FocusScope.of(context).unfocus();
                                          sendNotificationBloc.add(const PostNotificationsEvent());
                                        } else {
                                          sendNotificationBloc.add(const HideError());
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
}