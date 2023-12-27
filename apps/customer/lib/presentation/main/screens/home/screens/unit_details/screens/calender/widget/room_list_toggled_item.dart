import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';

class RoomListToggledItem extends StatelessWidget {
  const RoomListToggledItem({
    Key? key,
    required this.title,
    required this.isLoading,
  }) : super(key: key);
  final String title;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).backgroundColor,
        ),
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 4 / 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: circularBook(color: Theme.of(context).splashColor, fontSize: 14),
                  )),
                  Image.asset(arrowDownIconPath, color: kWhite),
                ],
              ),
            ),
            if (isLoading)
              Row(
                children: [
                  Container(
                      width: 15,
                      height: 15,
                      margin: const EdgeInsetsDirectional.only(start: 20),
                      child: LoadingWidget(
                        color: Theme.of(context).splashColor,
                        strokeWith: 2,
                      )),
                ],
              )
          ],
        ),
      ),
    );
  }
}