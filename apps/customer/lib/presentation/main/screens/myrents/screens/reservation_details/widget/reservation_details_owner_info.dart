import 'package:flutter/material.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';

import '../../../../../../owner_profile/owner_profile_screen.dart';

class ReservationDetailsOwnerInfoWidget extends StatelessWidget {
  const ReservationDetailsOwnerInfoWidget({
    Key? key,
    required this.owner,
  }) : super(key: key);
  final Owner owner;

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
                    child: CustomClipRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      width: 48,
                      height: 48,
                      path: owner.image,
                    )),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        owner.name ?? "BackEndEmptyDtata",
                        style: circularBold(color: kWhite, fontSize: 14),
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(top: 3),
                        child: Text(
                          owner.type ?? "BackEndEmptyDtata",
                          style: circularMedium(color: kWhite, fontSize: 12),
                        ),
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
                    messageOwner(owner.phone, context);
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
                    callOwner(owner.phone, context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        navigationKey.currentState?.pushNamed(OwnerProfileScreen.tag, arguments: [owner.id.toString()]);
      },
    );
  }
}