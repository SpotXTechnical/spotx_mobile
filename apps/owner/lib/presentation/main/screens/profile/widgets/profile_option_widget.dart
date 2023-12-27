import 'package:flutter/material.dart';
import 'package:owner/utils/style/theme.dart';

class ProfileOptionWidget extends StatelessWidget {
  const ProfileOptionWidget({
    Key? key,
    required this.title,
    required this.iconPath,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final VoidCallback? onPressed;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              color: kWhite,
              width: 40,
              height: 40,
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 13),
              child: Text(
                title,
                style: circularMedium(
                  color: Theme.of(context).dialogBackgroundColor,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}