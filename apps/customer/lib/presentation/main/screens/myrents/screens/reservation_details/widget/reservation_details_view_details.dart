import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/model/unit_details_screen_nav_args.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';

class ReservationDetailsViewDetailsWidget extends StatelessWidget {
  const ReservationDetailsViewDetailsWidget({
    Key? key,
    required this.stateWidget,
    required this.description,
    required this.unitId,
  }) : super(key: key);

  final Text stateWidget;
  final String description;
  final String unitId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 17, start: 24, end: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              stateWidget,
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(22)),
                    border: Border.all(
                        color: Theme.of(context).canvasColor, width: 1)),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      navigationKey.currentState?.pushNamed(
                        UnitDetailsScreen.tag,
                        arguments: UnitDetailsScreenNavArgs(
                            unitId, UnitDetailsScreenType.normalUnit),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 13),
                      child: Text(
                        LocaleKeys.viewDetails.tr(),
                        style: circularBold(
                            color: Theme.of(context).canvasColor, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style:
                circularBook(color: Theme.of(context).hintColor, fontSize: 17),
          ),
        ],
      ),
    );
  }
}