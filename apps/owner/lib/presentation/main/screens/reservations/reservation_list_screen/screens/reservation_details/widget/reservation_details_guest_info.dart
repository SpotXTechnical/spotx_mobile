import 'package:flutter/material.dart';
import 'package:owner/data/remote/auth/models/guest.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

class ReservationDetailsGuestInfoWidget extends StatelessWidget {
  const ReservationDetailsGuestInfoWidget({
    Key? key,
    required this.owner,
  }) : super(key: key);
  final Guest? owner;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsetsDirectional.only(top: 12, start: 24, end: 24),
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.all(13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    decoration: const BoxDecoration(),
                    child: const CustomClipRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      width: 48,
                      height: 48,
                    )),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        owner?.name ?? "BackEndEmptyDtata",
                        style: circularBold(color: kWhite, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Theme.of(context).disabledColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(chatIconPath, color: kWhite),
                      )),
                  onTap: () {
                    messageOwner(owner?.phone, context);
                  },
                ),
                const SizedBox(
                  width: 13,
                ),
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Theme.of(context).disabledColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(callIconPath, color: kWhite),
                      )),
                  onTap: () {
                    callOwner(owner?.phone, context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }
}