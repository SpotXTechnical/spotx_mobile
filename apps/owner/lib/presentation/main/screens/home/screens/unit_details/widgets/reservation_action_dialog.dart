import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/widgets/review/reservation_details_info_dialog.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/widget/reservation_details_customer_info.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/app_button.dart';

class ReservationActionDialog extends StatelessWidget {
  const ReservationActionDialog({
    super.key,
    required this.reservation,
    this.positiveAction,
    this.negativeAction,
    this.positiveActionText,
    this.hintMessage,
    this.hideCustomerInfo = false,
  });

  final Reservation reservation;
  final VoidCallback? positiveAction;
  final VoidCallback? negativeAction;
  final String? positiveActionText;
  final String? hintMessage;
  final bool hideCustomerInfo;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).dividerColor,
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!hideCustomerInfo) ReservationDetailsCustomerInfoWidget(owner: reservation.customer),
          Padding(
            padding:
                const EdgeInsetsDirectional.only(top: 12, start: 24, end: 24),
            child: Text(
              reservation.status!.toUpperCase(),
              style: circularMedium(
                  color: Theme.of(context).selectedRowColor, fontSize: 14),
            ),
          ),
          ReservationDetailsInfoDialogWidget(reservation: reservation),
          const SizedBox(height: 20),
          if (hintMessage != null)
            Container(
              padding: const EdgeInsetsDirectional.all(12),
              margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Text(
                hintMessage ?? "",
                style: circularBook(
                  color: kWhite,
                  fontSize: 14,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          Container(
            margin: const EdgeInsetsDirectional.only(
                top: 17, start: 24, end: 24, bottom: 17),
            child: Row(
              children: [
                if (negativeAction != null)
                  Expanded(
                    child: AppButton(
                      height: 50,
                      textWidget: Text(
                        LocaleKeys.reject.tr(),
                        style: circularBold800(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 17),
                      ),
                      backGround: Theme.of(context).scaffoldBackgroundColor,
                      borderColor: Theme.of(context).primaryColorLight,
                      title: LocaleKeys.reject.tr(),
                      borderRadius: const BorderRadiusDirectional.all(
                          Radius.circular(28)),
                      action: negativeAction,
                    ),
                  ),
                const SizedBox(width: 10),
                if (positiveAction != null)
                  Expanded(
                    child: AppButton(
                      height: 50,
                      title: positiveActionText ?? "",
                      textWidget: Text(
                        positiveActionText ?? "",
                        style: circularBold800(color: kWhite, fontSize: 17),
                      ),
                      borderRadius: const BorderRadiusDirectional.all(
                          Radius.circular(28)),
                      action: positiveAction,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}