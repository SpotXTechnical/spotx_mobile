import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/utils/style/theme.dart';

class RoomListToggledItem extends StatelessWidget {
  const RoomListToggledItem({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).backgroundColor,
        ),
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
                child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: circularBook(color: Theme.of(context).splashColor, fontSize: 14),
            )),
          ],
        ),
      ),
    );
  }
}
