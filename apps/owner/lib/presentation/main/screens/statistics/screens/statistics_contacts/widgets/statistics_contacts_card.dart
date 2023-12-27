import 'package:flutter/material.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';

class StatisticsContactsCard extends StatelessWidget {
  const StatisticsContactsCard({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.name ?? "empty Data",
                  style: poppinsRegular(color: kWhite, fontSize: 16),
                ),
                Row(children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Theme.of(context).disabledColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(callIconPath, color: kWhite),
                      )),
                  const SizedBox(
                    width: 11,
                  ),
                  GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Theme.of(context).disabledColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(chatIconPath, color: kWhite),
                        )),
                    onTap: () {
                      messageOwner(user.phone, context);
                    },
                  )
                ])
              ],
            ),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 1,
          ),
        ],
      ),
    );
  }
}