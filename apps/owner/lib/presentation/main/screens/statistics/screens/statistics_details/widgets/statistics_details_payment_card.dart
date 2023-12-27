import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/statistics/model/payment_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';

class StatisticsDetailsPaymentCard extends StatelessWidget {
  const StatisticsDetailsPaymentCard({
    Key? key,
    required this.paymentEntity,
    required this.editAction,
    required this.deleteAction,
  }) : super(key: key);
  final PaymentEntity paymentEntity;
  final Function editAction;
  final Function deleteAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(color: Theme.of(context).disabledColor, width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMd(context.locale.languageCode).format(paymentEntity.date!),
                  style: poppinsRegular(color: Theme.of(context).hintColor, fontSize: 12),
                ),
                Text(
                  paymentEntity.description!,
                  style: poppinsMedium(color: kWhite, fontSize: 13),
                )
              ],
            ),
            Row(children: [
              Text(
                (paymentEntity.amount.toString() + " ") + LocaleKeys.le.tr(),
                style: circularMedium(color: kWhite, fontSize: 14),
              ),
              const SizedBox(
                width: 11,
              ),
              GestureDetector(
                child: Image.asset(moreIconPath, color: kWhite),
                onTap: () {
                  buildBottomSheet(context);
                },
              )
            ])
          ],
        ),
      ),
    );
  }

  void buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).backgroundColor,
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (context) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            margin: const EdgeInsetsDirectional.only(end: 35, start: 35, top: 15, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Image.asset(deleteIconPath, color: kWhite),
                  title: Text(
                    LocaleKeys.delete.tr(),
                    style: circularBook(color: Theme.of(context).hintColor, fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    deleteAction.call();
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Theme.of(context).unselectedWidgetColor,
                ),
                //     context: context, addSingle: addSingle, resourceType: ResourceType.video);

                ListTile(
                  leading: Image.asset(editIconPath, color: kWhite),
                  title: Text(
                    LocaleKeys.edit.tr(),
                    style: circularBook(color: Theme.of(context).hintColor, fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    editAction.call();
                  },
                )
              ],
            )));
  }
}