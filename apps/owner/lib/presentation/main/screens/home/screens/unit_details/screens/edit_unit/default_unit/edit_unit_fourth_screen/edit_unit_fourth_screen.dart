import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/data/remote/add_unit/model/feature_entity.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/main_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/widgets/edit_unit_header.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/observation_managers/home_observable_single_tone.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'bloc/edit_unit_fourth_bloc.dart';
import 'bloc/edit_unit_fourth_event.dart';
import 'bloc/edit_unit_fourth_state.dart';

class EditUnitFourthScreen extends StatelessWidget {
  const EditUnitFourthScreen({Key? key}) : super(key: key);
  static const tag = "EditUnitFourthScreen";
  @override
  Widget build(BuildContext context) {
    final Unit unit = ModalRoute.of(context)!.settings.arguments as Unit;
    return BlocProvider<EditUnitFourthBloc>(
      create: (ctx) => EditUnitFourthBloc(UnitRepository())
        ..add(const GetFeaturesEvent())
        ..add(InitFeaturesScreen(unit)),
      child: BlocBuilder<EditUnitFourthBloc, EditUnitFourthState>(
        builder: (context, state) {
          EditUnitFourthBloc editUnitFourBloc = BlocProvider.of(context);
          return WillPopScope(
            onWillPop: () async {
              navigationKey.currentState!.pop(state.unit);
              return false;
            },
            child: CustomSafeArea(
                child: Stack(
              children: [
                CustomScaffold(
                  appBar: EditUnitHeader(
                    cancelAction: () {
                      if (isSelectedFeatureChange(state.features, editUnitFourBloc)) {
                        Fluttertoast.showToast(
                            msg: LocaleKeys.changedDataCheckMessage.tr(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: pacificBlue,
                            textColor: kWhite);
                      } else {
                        navigationKey.currentState?.pushNamedAndRemoveUntil(
                            UnitDetailsScreen.tag, ModalRoute.withName(MainScreen.tag),
                            arguments: state.unit?.id);
                      }
                    },
                    onBackAction: () {
                      navigationKey.currentState!.pop(state.unit);
                    },
                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
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
                                      Text("4",
                                          style: circularBold800(color: kWhite, fontSize: 24)),
                                      Text("/4",
                                          style: circularBold800(color: kWhite, fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(start: 39, end: 39, top: 16),
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 17,
                            mainAxisSpacing: 17,
                            childAspectRatio: (MediaQuery.of(context).size.width / 1.7) / 220,
                            children: List.generate(state.features?.length ?? 0, (index) {
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
                                  editUnitFourBloc.add(ChangeFeatureStateEvent(state.features![index]));
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
                          borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                          textWidget: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(28)),
                            ),
                            child: Center(
                                child: Text(LocaleKeys.finish.tr(),
                                    style: circularMedium(color: kWhite, fontSize: 17))),
                          ),
                          action: () async {
                            if (!(state.isLoading || state.features == null)) {
                              if (isAtLeastOneFeatureSelected(state.features)) {
                                if (isSelectedFeatureChange(state.features, editUnitFourBloc)) {
                                  editUnitFourBloc.add(const FourthScreenUpdateUnit());
                                } else {
                                  navigationKey.currentState?.pushNamedAndRemoveUntil(
                                      UnitDetailsScreen.tag, ModalRoute.withName(MainScreen.tag),
                                      arguments: state.unit?.id);
                                  HomeObservableSingleTone().notify(UpdateSelectedRegionsUnit());
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: LocaleKeys.oneFeatureAtLeastIsRequiredMessage.tr(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: pacificBlue,
                                    textColor: kWhite);
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                if (state.isLoading || state.features == null)
                  Container(
                      color: Colors.black54,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const LoadingWidget())
              ],
            )),
          );
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

bool isSelectedFeatureChange(List<Feature>? features, EditUnitFourthBloc editUnitFourthBloc) {
  List<Feature>? selectedFeatures = features?.where((element) => element.isSelected).toList();
  return editUnitFourthBloc.areFeaturesUpdated(selectedFeatures);
}