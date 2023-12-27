import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/const.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/header.dart';

import 'bloc/settings_bloc.dart';
import 'bloc/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "SettingsScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (ctx) => SettingsBloc(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Header(title: LocaleKeys.settings.tr()),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 32, start: 20, end: 20),
                      child: Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.all(Radius.circular(15))),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "عربى",
                                    style: circularMedium(color: kWhite, fontSize: 30),
                                  ),
                                ),
                              ),
                              onTap: () {
                                context.setLocale(arabicLocale);
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.all(Radius.circular(15))),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "English",
                                    style: circularMedium(color: kWhite, fontSize: 30),
                                  ),
                                ),
                              ),
                              onTap: () {
                                context.setLocale(englishLocale);
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}