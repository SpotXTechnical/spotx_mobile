import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/auth/login/login_screen.dart';
import 'package:owner/utils/extensions/string_extensions.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/app_button.dart';

class ProfileBasicInfoWidget extends StatelessWidget {
  const ProfileBasicInfoWidget({
    Key? key,
    this.user,
    required this.getProfileData,
  }) : super(key: key);
  final User? user;
  final Function getProfileData;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Stack(
        children: [
          // Todo("Add Edit Profile in upcoming releases")
          /*Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (user != null)
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).disabledColor),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    margin: const EdgeInsets.all(14),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset(editIconPath, color: kWhite),
                    ),
                  ),
                  onTap: () async {
                    if (user != null) {
                      // var result = await navigationKey.currentState?.pushNamed(EditProfileScreen.tag, arguments: user);
                      // if (result != null) {
                      //   getProfileData();
                      // }
                    }
                  },
                )
            ],
          ),*/
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 32),
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: user != null && user!.image != null
                        ? Image.network(user?.image.toString().replaceHttps()??'', fit: BoxFit.cover,)
                        : Image.asset(avatarIconPath, color: kWhite),
                  ),
                ),
                user == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            child: AppButton(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              title: LocaleKeys.login.tr(),
                              textWidget: Text(
                                LocaleKeys.login.tr(),
                                style: circularMedium(color: kWhite, fontSize: 17),
                              ),
                              action: () async {
                                var result =
                                    await navigationKey.currentState?.pushNamed(LoginScreen.tag, arguments: true);
                                if (result != null && result as bool) {
                                  getProfileData();
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(top: 10),
                            child: Text(
                              user?.name ?? "",
                              style: circularBook(color: kWhite, fontSize: 19),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(bottom: 32, top: 7),
                            child: Text(
                              user?.phone ?? "",
                              style: circularBook(color: kWhite, fontSize: 12),
                            ),
                          )
                        ],
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}