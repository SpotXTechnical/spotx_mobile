import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';

class UnitDetailsContentWidget extends StatelessWidget {
  const UnitDetailsContentWidget({Key? key, required this.bedrooms, required this.bathrooms}) : super(key: key);
  final int bedrooms;
  final int bathrooms;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsetsDirectional.only(top: 18, start: 24, end: 24),
      height: 106,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark, borderRadius: const BorderRadius.all(Radius.circular(13))),
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        bedRoomIconPath,
                        color: kWhite,
                        fit: BoxFit.fill,
                      )),
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 10),
                    child: AutoSizeText(
                      LocaleKeys.bedRooms.tr(),
                      minFontSize: 7,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: circularMedium(color: kWhite, fontSize: 10),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(top: 10),
                      child: Text(
                        "$bedrooms",
                        style: circularMedium(color: kWhite, fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
              width: 80,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark, borderRadius: BorderRadius.all(const Radius.circular(13))),
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        bathTubIconPath,
                        color: kWhite,
                        fit: BoxFit.fill,
                      )),
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 10),
                    child: AutoSizeText(
                      LocaleKeys.bathRooms.tr(),
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 7,
                      maxLines: 1,
                      style: circularMedium(color: kWhite, fontSize: 10),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(top: 10),
                      child: Text(
                        "$bathrooms",
                        style: circularMedium(color: kWhite, fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}