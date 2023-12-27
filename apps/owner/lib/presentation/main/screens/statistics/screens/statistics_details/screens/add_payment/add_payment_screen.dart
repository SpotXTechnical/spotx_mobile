import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/data/remote/statistics/model/payment_entity.dart';
import 'package:owner/data/remote/statistics/statistics_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/filter/utils.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/screens/add_payment/bloc/add_payment_bloc.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/screens/add_payment/bloc/add_payment_event.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/screens/add_payment/bloc/add_payment_state.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/header.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

import '../../../../../../../../utils/date_utils/utils.dart';

class AddPaymentScreen extends StatelessWidget {
  const AddPaymentScreen({Key? key}) : super(key: key);
  static const tag = "AddPaymentScreen";
  @override
  Widget build(BuildContext context) {
    final PaymentEntity? payment = ModalRoute.of(context)!.settings.arguments as PaymentEntity?;
    return BlocProvider<AddPaymentBloc>(
      create: (ctx) => AddPaymentBloc(UnitRepository(), StatisticsRepository())
        ..add(GetUnits(payment == null ? null : payment.unitId.toString()))
        ..add(SetPayment(payment, context.locale.languageCode)),
      child: BlocBuilder<AddPaymentBloc, AddPaymentState>(
        builder: (context, state) {
          AddPaymentBloc addPaymentBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
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
                              key: AddPaymentBloc.formKey,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          LocaleKeys.addPayment.tr(),
                                          style: circularBold900(color: kWhite, fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                  state.isUnitsLoading
                                      ? Container(
                                          margin: const EdgeInsets.only(top: 32),
                                          width: MediaQuery.of(context).size.width,
                                          child: const LoadingWidget(),
                                        )
                                      : Container(
                                          margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                          child: GestureDetector(
                                            child: Container(
                                              color: Colors.transparent,
                                              child: CustomTitledRoundedTextFormWidget(
                                                controller: addPaymentBloc.unitController,
                                                hintText: LocaleKeys.chooseUnit.tr(),
                                                title: LocaleKeys.chooseUnit.tr(),
                                                keyboardType: TextInputType.number,
                                                focusNode: addPaymentBloc.unitFocus,
                                                textInputAction: TextInputAction.next,
                                                suffixIcon: Image.asset(calenderIconPath, color: kWhite),
                                                enabled: false,
                                                onFieldSubmitted: (name) {
                                                  addPaymentBloc.unitFocus.unfocus();
                                                  FocusScope.of(context).requestFocus(addPaymentBloc.descriptionFocus);
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
                                                showAndroidBottomSheet(context, state.units!, state.selectedUnit!.id!, (unit) {
                                                  addPaymentBloc.add(SetUnitEvent(unit));
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: GestureDetector(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: CustomTitledRoundedTextFormWidget(
                                          controller: addPaymentBloc.dateController,
                                          hintText: LocaleKeys.dateExample.tr(),
                                          title: LocaleKeys.date.tr(),
                                          keyboardType: TextInputType.number,
                                          focusNode: addPaymentBloc.dateFocus,
                                          textInputAction: TextInputAction.next,
                                          suffixIcon: Image.asset(calenderIconPath, color: kWhite),
                                          enabled: false,
                                          onFieldSubmitted: (name) {
                                            FocusScope.of(context).requestFocus(addPaymentBloc.descriptionFocus);
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
                                        getDateData(context, (date) {
                                          addPaymentBloc.add(AddDateEvent(DateFormat.yMd(context.locale.languageCode).format(date)));
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: CustomTitledRoundedTextFormWidget(
                                      controller: addPaymentBloc.priceController,
                                      hintText: LocaleKeys.addPrice.tr(),
                                      title: LocaleKeys.addPrice.tr(),
                                      keyboardType: TextInputType.number,
                                      focusNode: addPaymentBloc.priceFocus,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (name) {
                                        addPaymentBloc.priceFocus.unfocus();
                                        FocusScope.of(context).requestFocus(addPaymentBloc.descriptionFocus);
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
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: CustomTitledRoundedTextFormWidget(
                                      controller: addPaymentBloc.descriptionController,
                                      hintText: LocaleKeys.writeDescription.tr(),
                                      maxLines: 4,
                                      title: LocaleKeys.description.tr(),
                                      keyboardType: TextInputType.text,
                                      focusNode: addPaymentBloc.descriptionFocus,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (name) {
                                        addPaymentBloc.descriptionFocus.unfocus();
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
                                isLoading: state.isLoading,
                                borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                                textWidget: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(28)),
                                  ),
                                  child: Center(
                                      child: Text(payment == null ? LocaleKeys.add.tr() : LocaleKeys.edit.tr(),
                                          style: circularMedium(color: kWhite, fontSize: 17))),
                                ),
                                action: () async {
                                  if (!state.isLoading) {
                                    await Future.delayed(const Duration(milliseconds: 100));
                                    if (AddPaymentBloc.formKey.currentState?.validate() ?? false) {
                                      FocusScope.of(context).unfocus();
                                      payment == null
                                          ? addPaymentBloc.add(const AddPayment())
                                          : addPaymentBloc.add(UpdatePayment(payment.id.toString()));
                                    } else {
                                      addPaymentBloc.add(const HideError());
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

  Future<void> getDateData(BuildContext context, Function(DateTime) action) async {
    var date = await getDate(context, startDate: DateTime.now().subtract(const Duration(days: 200)));
    if (date != null) {
      action(date);
    }
  }
}