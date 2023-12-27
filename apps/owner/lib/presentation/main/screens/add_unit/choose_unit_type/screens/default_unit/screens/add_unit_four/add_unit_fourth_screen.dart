import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/add_unit/model/feature_entity.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/header.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

import 'bloc/add_unit_fourth_bloc.dart';
import 'bloc/add_unit_fourth_event.dart';
import 'bloc/add_unit_fourth_state.dart';

class AddUnitFourthScreen extends StatelessWidget {
  const AddUnitFourthScreen({Key? key}) : super(key: key);
  static const tag = "AddUnitFourScreen";
  @override
  Widget build(BuildContext context) {
    final Unit unit = ModalRoute.of(context)!.settings.arguments as Unit;
    return BlocProvider<AddUnitFourthBloc>(
      create: (ctx) => AddUnitFourthBloc(UnitRepository())..add(const GetFeaturesEvent()),
      child: BlocBuilder<AddUnitFourthBloc, AddUnitFourthState>(
        builder: (context, state) {
          AddUnitFourthBloc addUnitFourBloc = BlocProvider.of(context);
          return CustomSafeArea(
              child: CustomScaffold(
            appBar: const Header(
              margin: EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.selectHomeFeature.tr(),
                          style: circularBold800(color: kWhite, fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            child: Image.asset(progress4_4IconPath),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.ideographic,
                              children: [
                                Text("4", style: circularBold800(color: kWhite, fontSize: 24)),
                                Text("/4", style: circularBold800(color: kWhite, fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: (state.isLoading || state.features == null)
                      ? const Center(child: LoadingWidget())
                      : Container(
                          margin: const EdgeInsetsDirectional.only(start: 39, end: 39, top: 16),
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 17,
                            mainAxisSpacing: 17,
                            childAspectRatio: (MediaQuery.of(context).size.width / 1.7) / 220,
                            children: List.generate(state.features!.length, (index) {
                              return GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColorDark,
                                      borderRadius: const BorderRadius.all(Radius.circular(14))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(top: 10),
                                              child: state.features![index].url != null
                                                  ? Image.network(
                                                      state.features![index].url ?? "",
                                                      width: 40,
                                                      height: 35,
                                                    )
                                                  : Image.asset(
                                                      deleteIconPath,
                                                      color: kWhite,
                                                      width: 35,
                                                      height: 35,
                                                    ),
                                            ),
                                            Image.asset(
                                                state.features![index].isSelected ? checkIconPath : unCheckIconPath,
                                                width: 35,
                                                height: 35,
                                                color: kWhite),
                                          ],
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            state.features?[index].name ?? "",
                                            style: circularBook(
                                                color: Theme.of(context).dialogBackgroundColor, fontSize: 17),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  addUnitFourBloc.add(ChangeFeatureStateEvent(state.features![index]));
                                },
                              );
                            }),
                          ),
                        ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(24),
                  child: AppButtonGradient(
                    title: LocaleKeys.apply.tr(),
                    height: 55,
                    enabled:
                        !(state.isLoading || state.features == null) && isAtLeastOneFeatureSelected(state.features),
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
                      addUnitFourBloc.add(CreateUnitEvent(unit));
                    },
                  ),
                )
              ],
            ),
          ));
        },
      ),
    );
  }

  bool isAtLeastOneFeatureSelected(List<Feature>? features) {
    if (features != null) {
      for (var element in features) {
        if (element.isSelected) {
          return element.isSelected;
        }
      }
    }
    return false;
  }
}