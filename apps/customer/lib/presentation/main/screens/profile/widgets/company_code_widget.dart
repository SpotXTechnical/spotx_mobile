import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomRoundedTextFormField.dart';
import 'package:spotx/utils/widgets/app_button.dart';

class ApplyCompanyCodeWidget extends StatelessWidget {
  const ApplyCompanyCodeWidget({
    Key? key,
    this.onApplyPressed,
    this.controller,
    this.isLoading = false,
  }) : super(key: key);
  final VoidCallback? onApplyPressed;
  final TextEditingController? controller;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsetsDirectional.only(
        start: 16,
        end: 11,
        top: 15,
        bottom: 12,
      ),
      margin: const EdgeInsetsDirectional.only(top: 21, start: 10, end: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.companyCode.tr(),
            style: circularMedium(color: silverSand, fontSize: 15),
          ),
          const SizedBox(height: 11),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomRoundedTextFormField(
                  hintText: LocaleKeys.enterCode.tr(),
                  hintStyle: circularBook(color: cadetGrey, fontSize: 14),
                  hasBorder: true,
                  radius: 10,
                  controller: controller,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppButton(
                  height: 45,
                  textWidget: Text(
                    LocaleKeys.apply.tr(),
                    style: circularMedium(color: kWhite, fontSize: 14),
                  ),
                  color: Theme.of(context).primaryColorLight,
                  backgroundColor: Theme.of(context).primaryColorLight,
                  title: LocaleKeys.apply.tr(),
                  borderRadius:
                      const BorderRadiusDirectional.all(Radius.circular(20)),
                  action: onApplyPressed,
                  isLoading: isLoading,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}