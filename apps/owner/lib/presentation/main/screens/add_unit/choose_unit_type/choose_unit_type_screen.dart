import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/bloc/choose_unit_type_event.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_first/add_camp_first_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_one/add_unit_first_screen.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/header.dart';
import 'bloc/choose_unit_type_bloc.dart';
import 'bloc/choose_unit_type_state.dart';

class ChooseUnitTypeScreen extends StatelessWidget {
  const ChooseUnitTypeScreen({Key? key}) : super(key: key);
  static const tag = "ChooseUnitTypeScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseUnitTypeBloc>(
      create: (ctx) => ChooseUnitTypeBloc(),
      child: BlocBuilder<ChooseUnitTypeBloc, ChooseUnitTypeState>(
        builder: (context, state) {
          ChooseUnitTypeBloc chooseUnitTypeBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: Scaffold(
              appBar: const Header(
                margin: EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 24, left: 45, right: 45),
                          child: Text(
                            LocaleKeys.pleaseChooseUnitType.tr(),
                            style: circularBold800(color: kWhite, fontSize: 25),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            chooseUnitTypeBloc.add(const SelectUnitTypeEvent(chalet));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 21, right: 45, left: 45),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: const BorderRadius.all(Radius.circular(21)),
                                border: Border.all(
                                    width: 1,
                                    color: state.unitType == chalet
                                        ? Theme.of(context).primaryColorLight
                                        : Colors.transparent)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 38),
                              child: Column(
                                children: [
                                  state.unitType == chalet
                                      ? Image.asset(defaultActiveIconPath, color: kWhite)
                                      : Image.asset(defaultIconPath, color: kWhite),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      LocaleKeys.defaultUnit.tr(),
                                      style: circularBold700(color: Theme.of(context).hintColor, fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      "loersdasd sadsad sadas dasdsadsa sadsadsad",
                                      textAlign: TextAlign.center,
                                      style: circularBook(color: Theme.of(context).dividerColor, fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            chooseUnitTypeBloc.add(const SelectUnitTypeEvent(camp));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 21, right: 45, left: 45),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: const BorderRadius.all(Radius.circular(21)),
                                border: Border.all(
                                    width: 1,
                                    color: state.unitType == camp
                                        ? Theme.of(context).primaryColorLight
                                        : Colors.transparent)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 38),
                              child: Column(
                                children: [
                                  state.unitType == camp
                                      ? Image.asset(campActiveIconPath, color: kWhite)
                                      : Image.asset(campIconPath, color: kWhite),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      LocaleKeys.camp.tr(),
                                      style: circularBold700(color: Theme.of(context).hintColor, fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      "loersdasd sadsad sadas dasdsadsa sadsadsad",
                                      textAlign: TextAlign.center,
                                      style: circularBook(color: Theme.of(context).dividerColor, fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        margin: const EdgeInsets.all(20),
                        child: AppButtonGradient(
                          title: LocaleKeys.create.tr(),
                          height: 55,
                          borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                          textWidget: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(28)),
                            ),
                            child: Center(
                                child: Text(LocaleKeys.create.tr(),
                                    style: circularMedium(color: kWhite, fontSize: 17))),
                          ),
                          action: () async {
                            if (state.unitType == chalet) {
                              navigationKey.currentState?.pushNamed(
                                AddUnitFirstScreen.tag,
                              );
                            } else if (state.unitType == camp) {
                              navigationKey.currentState?.pushNamed(
                                AddCampFirstScreen.tag,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}