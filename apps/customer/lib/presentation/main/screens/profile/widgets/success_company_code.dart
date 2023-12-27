import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';

class SuccessCompanyCode extends StatelessWidget {
  const SuccessCompanyCode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 115,
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
          Expanded(
            child: Row(
              children: [
                Image.asset(finishReservation),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.codeNumber.tr(),
                            style: helveticMedium(
                              color: languidLavender,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            LocaleKeys.codeAccepted.tr(),
                            style: circularMedium(color: kWhite, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        LocaleKeys.discountMessage.tr(),
                        style: helveticRegular(color: cadetGrey, fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}