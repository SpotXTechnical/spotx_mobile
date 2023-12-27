import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/camp_details/camp_details_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/model/unit_details_screen_nav_args.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:spotx/utils/extensions/build_context_extensions.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';
import '../../../../../../../base/favouite_base_bloc/favourite_icon_bloc.dart';
import '../../../../../../../base/favouite_base_bloc/favourite_icon_state.dart';
import '../../../../../../../base/favouite_base_bloc/favourtie_icon_event.dart';
import '../../../../../../../data/remote/unit/unit_repository.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';

class FavouriteCard extends StatelessWidget {
  const FavouriteCard({Key? key, required this.unit, this.removeUnFavouriteUnit, this.reloadFavouriteList})
      : super(key: key);
  final Unit unit;
  final Function(Unit)? removeUnFavouriteUnit;
  final Function? reloadFavouriteList;
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
                  height: 100,
                  borderRadius: BorderRadius.circular(20),
                  path: unit.images?.findImageToDisplay()?.url,
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
                          Container(),
                          BlocProvider<FavouriteIconBloc>(
                            create: (ctx) => FavouriteIconBloc(UnitRepository(), unit),
                            child: BlocBuilder<FavouriteIconBloc, FavouriteIconState>(builder: (context, state) {
                              FavouriteIconBloc favouriteIconBloc = BlocProvider.of(context);
                              if (!unit.isFavourite!) {
                                reloadFavouriteList?.call();
                              }
                              return GestureDetector(
                                child: Container(
                                    color: Colors.transparent,
                                    child: Image.asset(deleteIconPath, color: kWhite)),
                                onTap: () {
                                  favouriteIconBloc.add(RemoveFromFavouriteEvent());
                                },
                              );
                            }),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(top: 7),
                        child: Text(
                          unit.description??'',
                          style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(top: 6.2),
                        child: Row(
                          children: [
                            Text(
                              "${unit.currentPrice?.replaceFarsiNumber()} ${LocaleKeys.le.tr()}",
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
                                        unit.bedRooms.toString(),
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
                                        unit.bathrooms.toString(),
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
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        navigateToUnitDetails(unit);
      },
    );
  }

  void navigateToUnitDetails(Unit unit) async {
    dynamic result;
    if (unit.type == UnitType.camp.name) {
      result = await navigationKey.currentState?.pushNamed(CampDetailsScreen.tag, arguments: unit.id.toString());
    } else {
      result = await navigationKey.currentState?.pushNamed(UnitDetailsScreen.tag,
          arguments: UnitDetailsScreenNavArgs(unit.id.toString(), UnitDetailsScreenType.normalUnit));
    }
    if (result != null && !(result as Unit).isFavourite!) {
      removeUnFavouriteUnit!(result);
    }
  }
}