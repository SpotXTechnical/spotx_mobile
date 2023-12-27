import 'package:flutter/material.dart';
import 'package:spotx/utils/style/theme.dart';

class ProfileActionWidget extends StatelessWidget {
  const ProfileActionWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 19.0, right: 19),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(23),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 10),
                Text(
                  title,
                  style: circularMedium(
                    color: Theme.of(context).dialogBackgroundColor,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}