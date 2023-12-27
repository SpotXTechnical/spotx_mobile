import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';

class RoomListItem extends StatelessWidget {
  const RoomListItem({
    Key? key,
    required this.title,
    required this.isSelected,
  }) : super(key: key);
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).backgroundColor),
            color: Theme.of(context).backgroundColor,
          ),
          width: MediaQuery.of(context).size.width,
          height: 45,
          child: Container(
            alignment: AlignmentDirectional.center,
            width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width / 5 + 80),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: circularBook(color: Theme.of(context).splashColor, fontSize: 14),
            ),
          ),
        ),
        if (isSelected)
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width / 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 10, height: 10, child: Image.asset(doneIconPath, color: kWhite)),
              ],
            ),
            height: 45,
          )
      ],
    );
  }
}