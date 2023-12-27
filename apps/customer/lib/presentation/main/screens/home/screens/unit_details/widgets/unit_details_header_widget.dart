import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/favouite_base_bloc/favourite_icon_bloc.dart';
import 'package:spotx/base/favouite_base_bloc/favourite_icon_state.dart';
import 'package:spotx/base/favouite_base_bloc/favourtie_icon_event.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/locale_icon_direction.dart';

import '../../../../../../../utils/deep_link_utils.dart';

class UnitDetailsHeaderWidget extends StatelessWidget {
  const UnitDetailsHeaderWidget({
    Key? key,
    this.unit,
  }) : super(key: key);
  final Unit? unit;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                child: const LocaleIconDirection(
                  icon: backNavIconPath,
                ),
              ),
              onTap: () {
                navigationKey.currentState?.pop();
              },
            ),
          ),
          Expanded(
            child: Container(
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
                      createDynamicLink(unit!.id.toString(), DynamicLinksTargets.unit);
                    },
                  ),
                  if (unit != null) BlocProvider<FavouriteIconBloc>(
                          create: (ctx) => FavouriteIconBloc(UnitRepository(), unit!),
                          child: BlocBuilder<FavouriteIconBloc, FavouriteIconState>(builder: (context, state) {
                            FavouriteIconBloc favouriteIconBloc = BlocProvider.of(context);
                            return GestureDetector(
                              child: Container(
                                  width: 44,
                                  height: 44,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(top: 8.0, start: 8, bottom: 8),
                                    child: Image.asset(
                                        state.unit.uiIsFavourite! ? favouriteIconPath : inactiveFavouriteIconPath,
                                        color: kWhite),
                                  )),
                              onTap: () {
                                checkIfUserIsLoggedInBefore(context, () {
                                  if (state.unit.uiIsFavourite!) {
                                    favouriteIconBloc.add(RemoveFromFavouriteEvent());
                                  } else {
                                    favouriteIconBloc.add(AddToFavouriteEvent());
                                  }
                                });
                              },
                            );
                          }),
                        ) else Container(
                          width: 44,
                          height: 44,
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(top: 8.0, start: 8, bottom: 8),
                            child: Image.asset(inactiveFavouriteIconPath, color: kWhite),
                          ))
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}