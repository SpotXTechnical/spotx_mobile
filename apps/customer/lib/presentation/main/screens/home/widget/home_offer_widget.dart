import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/bloc/main_bloc.dart';
import 'package:spotx/presentation/main/bloc/main_event.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/locale_icon_direction.dart';

class HomeOfferWidget extends StatelessWidget {
  const HomeOfferWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsetsDirectional.only(start: 24, top: 20, end: 24),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(20), bottomStart: Radius.circular(20)),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.upTo.tr(),
                          style: circularMedium(color: kWhite, fontSize: 16)),
                      Container(
                        margin: const EdgeInsetsDirectional.only(top: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("20",
                                style: TextStyle(
                                    color: kWhite,
                                    fontSize: 33,
                                    height: .5,
                                    fontWeight: FontWeight.bold)),
                            Container(
                                alignment: Alignment.bottomCenter,
                                child:
                                    Text("%", style: circularMedium(color: kWhite, fontSize: 12))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: isArabic
                              ? [
                                  Theme.of(context).secondaryHeaderColor,
                                  Theme.of(context).shadowColor,
                                ]
                              : [
                                  Theme.of(context).shadowColor,
                                  Theme.of(context).secondaryHeaderColor,
                                ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: const [0.0, 1.0]),
                      borderRadius: const BorderRadiusDirectional.only(
                          topEnd: Radius.circular(20), bottomEnd: Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.getOffers.tr(),
                                    style: circularMedium(color: kWhite, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    LocaleKeys.offerHomeMessage.tr(),
                                    style: circularMedium(color: kWhite, fontSize: 12),
                                    maxLines: 4,
                                  )
                                ]),
                          )),
                      Expanded(
                          flex: 3,
                          child: Container(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: const LocaleIconDirection(
                                icon: homeDecorationPath,
                              ))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        MainBloc mainBloc = BlocProvider.of(context);
        mainBloc.add(UpdateIndex(1,previousIndex:  0));
      },
    );
  }
}