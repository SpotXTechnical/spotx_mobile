import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/bloc/choose_unit_type_state.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_first/add_camp_first_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_first_screen/edit_unit_first_screen.dart';
import 'package:owner/utils/deep_link_utils.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/locale_icon_direction.dart';

class UnitDetailsHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const UnitDetailsHeaderWidget({
    Key? key,
    this.unit,
    required this.setUnit,
  }) : super(key: key);
  final Unit? unit;
  final Function(Unit unit) setUnit;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: AlignmentDirectional.centerStart,
            child: GestureDetector(
              child: const LocaleIconDirection(icon: backNavIconPath),
              onTap: () {
                navigationKey.currentState?.pop();
              },
            ),
          ),
          const SizedBox(width: 6,),
          Expanded(child: Container(alignment: AlignmentDirectional.center, child: Text(unit?.title ?? ""))),
          Container(
            alignment: AlignmentDirectional.centerEnd,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Image.asset(shareIconPath, color: kWhite),
                  ),
                  onTap: () {
                    if (unit?.id != null) {
                      createDynamicLink(unit!.id.toString(), DynamicLinksTargets.unit);
                    }
                  },
                ),
                GestureDetector(
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Image.asset(editWithoutRadiusIconPath, color: kWhite),
                  ),
                  onTap: () async {
                    if (unit != null) {
                      if (unit!.type == chalet) {
                        var result = await navigationKey.currentState
                            ?.pushNamed(EditUnitFirstScreen.tag, arguments: unit) as Unit;
                        setUnit(result);
                      } else if (unit?.type == camp) {
                        navigationKey.currentState?.pushNamed(AddCampFirstScreen.tag, arguments: unit);
                      }
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}