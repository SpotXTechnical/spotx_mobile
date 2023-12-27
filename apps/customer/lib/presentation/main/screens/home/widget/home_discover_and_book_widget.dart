import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/search_screen.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';

class HomeDiscoverAndBookWidget extends StatelessWidget {
  const HomeDiscoverAndBookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 24, start: 24, top: 17),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.discoverAndBook.tr(),
                    style: circularMedium(color: kWhite, fontSize: 24),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 14),
                    child: Material(
                      color: Theme.of(context).unselectedWidgetColor,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Image.asset(searchIconPath, color: kWhite),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 10),
                                  child: Text(
                                    LocaleKeys.search.tr(),
                                    style: circularBook(color: kWhite, fontSize: 13),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          navigationKey.currentState?.pushNamed(SearchScreen.tag);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}