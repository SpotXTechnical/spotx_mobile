import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

class SubRegionUnitCard extends StatelessWidget {
  const SubRegionUnitCard({Key? key, required this.unit, required this.deleteAction}) : super(key: key);
  final Unit unit;
  final Function(String) deleteAction;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Row(
            children: [
              Expanded(
                child: CustomClipRect(
                  borderRadius: BorderRadius.circular(20),
                  path: unit.mainImage?.url,
                  height: 109,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsetsDirectional.only(start: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(11.5)),
                                  color: Theme.of(context).indicatorColor),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                child: Text(
                                  unit.type ?? "",
                                  style: circularMedium(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                                ),
                              )),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 7),
                        child: Text(
                          unit.title ?? "",
                          style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 6.2),
                        child: Row(
                          children: [
                            Text(
                              unit.currentPrice ?? " ${LocaleKeys.le.tr()}",
                              style: circularMedium(color: kWhite, fontSize: 14),
                            ),
                            Text(
                              LocaleKeys.perDayWithSlash.tr(),
                              style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Theme.of(context).disabledColor, width: .5)),
                                margin: const EdgeInsetsDirectional.only(top: 9, start: 5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        unit.bedRooms ?? "",
                                        style: circularMedium(
                                            color: Theme.of(context).dialogBackgroundColor, fontSize: 13),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Image.asset(bedRoomIconPath, color: kWhite)
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Theme.of(context).disabledColor, width: .5)),
                                margin: const EdgeInsetsDirectional.only(top: 9, start: 5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        unit.bathRooms ?? "",
                                        style: circularMedium(
                                            color: Theme.of(context).dialogBackgroundColor, fontSize: 13),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Image.asset(bathTubIconPath, color: kWhite)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        navigationKey.currentState?.pushNamed(UnitDetailsScreen.tag, arguments: unit.id);

        // showConfirmationEditingDialog(
        //     context: context,
        //     onConfirm: () {
        //       navigationKey.currentState?.pushNamed(AddUnitFirstScreen.tag,
        //           arguments: UnitAndAction(unit: unit, actionType: ActionType.edit));
        //     });
      },
    );
  }
}