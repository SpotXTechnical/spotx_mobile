import 'package:flutter/material.dart';
import 'package:spotx/utils/style/theme.dart';

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
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, color: kWhite),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 13),
              child: Text(
                title,
                style: circularMedium(
                    color: Theme.of(context).dialogBackgroundColor,
                    fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}