import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';
import '../../../../../data/remote/auth/models/login_response_entity.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Theme.of(context).disabledColor)),
                  margin: const EdgeInsetsDirectional.only(start: 0),
                  child: CustomClipRect(
                    borderRadius: BorderRadius.circular(16),
                    path: user?.image,
                  )),
              onTap: () {},
            ),
            // Your widgets here
          ],
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
