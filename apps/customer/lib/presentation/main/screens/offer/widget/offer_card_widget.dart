import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/favouite_base_bloc/favourite_icon_bloc.dart';
import 'package:spotx/base/favouite_base_bloc/favourite_icon_state.dart';
import 'package:spotx/base/favouite_base_bloc/favourtie_icon_event.dart';
import 'package:spotx/data/remote/unit/model/offer_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/camp_details/camp_details_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/model/unit_details_screen_nav_args.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:spotx/utils/extensions/build_context_extensions.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';

class OfferCardWidget extends StatelessWidget {
  const OfferCardWidget({Key? key, required this.offer}) : super(key: key);

  final OfferEntity offer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 156,
                        child: CustomClipRect(
                          borderRadius: BorderRadius.circular(20),
                          path: offer.unit?.images?.findImageToDisplay()?.url,
                        )),
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).dialogBackgroundColor,
                                borderRadius: const BorderRadius.all(Radius.circular(11))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                              child: Text(
                                "${offer.unit!.type}",
                                style: circularMedium(color: Theme.of(context).primaryColorLight, fontSize: 14),
                              ),
                            ),
                          ),
                          BlocProvider<FavouriteIconBloc>(
                            create: (ctx) => FavouriteIconBloc(UnitRepository(), offer.unit!)
                              ..add(UpdateFavouriteUnitEvent(offer.unit!)),
                            child: BlocBuilder<FavouriteIconBloc, FavouriteIconState>(builder: (context, state) {
                              FavouriteIconBloc favouriteIconBloc = BlocProvider.of(context);
                              return GestureDetector(
                                child: Image.asset(
                                    state.unit.uiIsFavourite! ? favouriteIconPath : inactiveFavouriteIconPath,
                                    color: kWhite),
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                    margin: const EdgeInsetsDirectional.only(top: 10),
                    child: Text(
                      "${offer.unit!.title}",
                      style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 15),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: Text(
                    "${offer.dayCount} ${LocaleKeys.nights.tr()}",
                    style: circularMedium(color: kWhite, fontSize: 14),
                  ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          if (offer.startDate != null) ...[
                            TextSpan(
                              text: '${LocaleKeys.from.tr()}  ',
                              style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                            ),
                            TextSpan(
                              text: DateFormat.Md(context.locale.languageCode).format(offer.startDate!),
                              style: circularBook(color: kWhite, fontSize: 14),
                            ),
                          ],
                          if (offer.endDate != null) ...[
                            TextSpan(
                            text: '  ${LocaleKeys.to.tr()}  ',
                            style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                            ),
                            TextSpan(
                            text: DateFormat.Md(context.locale.languageCode).format(offer.endDate!),
                            style: circularBook(color: kWhite, fontSize: 14),
                            )
                          ]
                        ]),
                      ),
                      Container(
                          margin: const EdgeInsetsDirectional.only(start: 5),
                          child: Row(
                            children: [
                              Text(
                                "${offer.totalPrice?.replaceFarsiNumber()} ${LocaleKeys.le.tr()}",
                                style: circularMedium(color: kWhite, fontSize: 14),
                              ),
                              Text(
                                " / ${LocaleKeys.totalCost.tr()}",
                                style: circularMedium(color: Theme.of(context).disabledColor, fontSize: 11),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            border: Border.all(color: Theme.of(context).disabledColor)),
                        margin: const EdgeInsetsDirectional.only(top: 13),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 5.0),
                          child: Row(
                            children: [
                              Text(
                                "${offer.unit!.bedRooms}",
                                style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 13),
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
                            border: Border.all(color: Theme.of(context).disabledColor)),
                        margin: const EdgeInsetsDirectional.only(top: 9, start: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 5.0),
                          child: Row(
                            children: [
                              Text(
                                "${offer.unit!.bathrooms}",
                                style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        if (offer.unit!.type == UnitType.camp.name) {
          navigationKey.currentState?.pushNamed(CampDetailsScreen.tag, arguments: offer.unit!.id);
        } else {
          navigationKey.currentState?.pushNamed(UnitDetailsScreen.tag,
              arguments: UnitDetailsScreenNavArgs(offer.id.toString(), UnitDetailsScreenType.offer));
        }
      },
    );
  }
}