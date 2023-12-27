import 'package:flutter/material.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/presentation/owner_profile/owner_profile_screen.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';

class UnitDetailsOwnerDetails extends StatelessWidget {
  const UnitDetailsOwnerDetails({Key? key, required this.owner})
      : super(key: key);
  final Owner owner;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigationKey.currentState?.pushNamed(OwnerProfileScreen.tag,
            arguments: [owner.id.toString()]);
      },
      child: Container(
        margin: const EdgeInsetsDirectional.only(top: 12, start: 24, end: 24),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.all(13),
        child: Row(
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
                    owner.name!,
                    style: circularBold(color: kWhite, fontSize: 14),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 3),
                    child: Text(
                      owner.type!,
                      style: circularMedium(color: kWhite, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}