import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/presentation/main/bloc/main_bloc.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';

import '../../../bloc/main_event.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    this.user,
  }) : super(key: key);
  final User? user;
  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = BlocProvider.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Row(
        children: <Widget>[
          if (user != null)
            GestureDetector(
              child: Container(
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Theme.of(context).disabledColor)),
                margin: const EdgeInsetsDirectional.only(),
                child: CustomClipRect(
                  height: 45,
                  borderRadius: BorderRadius.circular(16),
                  path: user?.image,
                ),
              ),
              onTap: () {
                mainBloc.add(UpdateIndex(3,previousIndex:  0));
              },
            ),
          // Your widgets here
        ],
      ),
    );
  }
}