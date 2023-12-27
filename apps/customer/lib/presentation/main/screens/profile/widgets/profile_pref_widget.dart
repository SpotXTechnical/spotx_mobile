import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/bloc/main_bloc.dart';
import 'package:spotx/presentation/main/bloc/main_event.dart';
import 'package:spotx/presentation/main/screens/profile/screens/favourite/favourite_screen.dart';
import 'package:spotx/presentation/main/screens/profile/widgets/lang_row.dart';
import 'package:spotx/presentation/main/screens/profile/widgets/profile_option_widget.dart';
import 'package:spotx/utils/force_update.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:spotx/utils/const.dart';
import 'package:spotx/presentation/auth/login/login_screen.dart';

class ProfilePrefWidget extends StatelessWidget {
  const ProfilePrefWidget(
      {Key? key, this.user, required this.reloadProfileScreen})
      : super(key: key);
  final User? user;
  final Function reloadProfileScreen;
  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = BlocProvider.of(context);

    return Container(
      margin: const EdgeInsetsDirectional.only(top: 14, start: 10, end: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ProfileOptionWidget(
                  title: LocaleKeys.favourite.tr(),
                  iconPath: favouriteBigIconPath,
                  onPressed: () {
                    if (user != null) {
                      navigationKey.currentState
                          ?.pushNamed(FavouriteScreen.tag);
                    } else {
                      showAuthorizationDialog(
                          context: context,
                          onConfirm: () async {
                            var result = await navigationKey.currentState
                                ?.pushNamed(LoginScreen.tag, arguments: true);
                            if (result != null && result as bool) {
                              reloadProfileScreen();
                            }
                          });
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ProfileOptionWidget(
                  title: LocaleKeys.language.tr(),
                  iconPath: langIconPath,
                  onPressed: () {
                    buildBottomSheet(context, mainBloc);
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 11),
            child: Row(
              children: [
                Expanded(
                  child: ProfileOptionWidget(
                    title: LocaleKeys.contactUs.tr(),
                    iconPath: contactUsIconPath,
                    onPressed: () {
                      launch("tel://01022874708");
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ProfileOptionWidget(
                    title: LocaleKeys.shareApp.tr(),
                    iconPath: shareBigIconPath,
                    onPressed: () async {
                      final baseService = BaseService();
                      if ((await baseService.platform) == 'ios') {
                        Share.share(APP_STORE_URL);
                      } else if ((await baseService.platform) == 'android') {
                        Share.share(PLAY_STORE_URL);
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void buildBottomSheet(BuildContext context, MainBloc mainBloc) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        margin: const EdgeInsetsDirectional.only(
            end: 35, start: 35, top: 15, bottom: 10),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext myContext, int index) => LangRow(
            index: index,
            lang: localeList[index],
            selectedLang: context.locale,
            onPressed: (selectedLang) {
              if (selectedLang != localeList[index]) {
                context.setLocale(localeList[index]);
                Navigator.of(context).pop();
                context.setLocale(localeList[index]);
                final isAr = localeList[index].languageCode == 'ar';
                mainBloc.add(
                  UpdateIndexAndLanguage(
                    isAr ? 0 : 3,
                    isAr,
                  ),
                );
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.transparent,
            );
          },
          itemCount: localeList.length,
        ),
      ),
    );
  }
}