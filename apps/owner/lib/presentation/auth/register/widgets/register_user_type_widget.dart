import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/auth/models/register_request_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';

class UserTypeWidget extends StatelessWidget {
  const UserTypeWidget({
    Key? key,
    required this.userType,
    required this.setUserType,
  }) : super(key: key);
  final UserType userType;
  final Function(UserType) setUserType;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: Container(
              width: 128,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(21),
                  border: userType == UserType.owner
                      ? Border.all(color: Theme.of(context).primaryColorLight, width: 1)
                      : Border.all(color: Theme.of(context).backgroundColor)),
              child: Padding(
                padding: const EdgeInsets.only(top: 27, bottom: 14),
                child: Column(
                  children: [
                    Image.asset(companyIconPath, color: kWhite),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text(
                        LocaleKeys.owner.tr(),
                        style: circularMedium(color: Theme.of(context).hintColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              setUserType(UserType.owner);
            },
          ),
          GestureDetector(
            child: Container(
              width: 128,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(21),
                  border: userType == UserType.company
                      ? Border.all(color: Theme.of(context).primaryColorLight, width: 1)
                      : Border.all(color: Theme.of(context).backgroundColor)),
              child: Padding(
                padding: const EdgeInsets.only(top: 27, bottom: 14),
                child: Column(
                  children: [
                    Image.asset(companyIconPath, color: kWhite),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        LocaleKeys.company.tr(),
                        style: circularMedium(color: Theme.of(context).hintColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              setUserType(UserType.company);
            },
          )
        ],
      ),
    );
  }
}