import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/main_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_first_screen/widgets/edit_screens_actions.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/widgets/edit_unit_header.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'bloc/edit_unit_first_bloc.dart';
import 'bloc/edit_unit_first_event.dart';
import 'bloc/edit_unit_first_state.dart';

class EditUnitFirstScreen extends StatelessWidget {
  const EditUnitFirstScreen({Key? key}) : super(key: key);
  static const tag = "EditUnitFirstScreen";
  @override
  Widget build(BuildContext context) {
    final Unit unit = ModalRoute.of(context)!.settings.arguments as Unit;
    return BlocProvider<EditUnitFirstBloc>(
      create: (ctx) => EditUnitFirstBloc(UnitRepository())..add(GetUnitById(unit)),
      child: BlocBuilder<EditUnitFirstBloc, EditUnitFirstState>(
        builder: (context, state) {
          EditUnitFirstBloc editUnitFirstBloc = BlocProvider.of(context);
          return WillPopScope(
            onWillPop: () async {
              navigationKey.currentState?.pop(state.unit);
              return true;
            },
            child: CustomSafeArea(
              child: Stack(
                children: [
                  CustomScaffold(
                    resizeToAvoidBottomInset: true,
                    appBar: EditUnitHeader(
                      cancelAction: () {
                        if (isUnitDataChanged(editUnitFirstBloc, state.unit)) {
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
                        navigationKey.currentState?.pop(state.unit);
                      },
                      margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
                    ),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    body: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            child: Form(
                              key: EditUnitFirstBloc.formKey,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          LocaleKeys.addUnitDetails.tr(),
                                          style: circularBold900(color: kWhite, fontSize: 30),
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              alignment: Alignment.center,
                                              child: Image.asset(progress1_4IconPath),
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
                                                  Text("1",
                                                      style: circularBold800(
                                                          color: kWhite, fontSize: 24)),
                                                  Text("/4",
                                                      style: circularBold800(
                                                          color: kWhite, fontSize: 14)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: CustomTitledRoundedTextFormWidget(
                                      controller: editUnitFirstBloc.titleEnController,
                                      hintText: LocaleKeys.enterUnitTitle.tr(),
                                      title: LocaleKeys.titleEn.tr(),
                                      keyboardType: TextInputType.text,
                                      focusNode: editUnitFirstBloc.titleEnFocus,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (name) {
                                        editUnitFirstBloc.titleEnFocus.unfocus();
                                        FocusScope.of(context).requestFocus(editUnitFirstBloc.titleArFocus);
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: CustomTitledRoundedTextFormWidget(
                                      controller: editUnitFirstBloc.titleArController,
                                      hintText: LocaleKeys.enterUnitTitle.tr(),
                                      title: LocaleKeys.titleAr.tr(),
                                      keyboardType: TextInputType.text,
                                      focusNode: editUnitFirstBloc.titleArFocus,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (name) {
                                        editUnitFirstBloc.titleArFocus.unfocus();
                                        FocusScope.of(context).requestFocus(editUnitFirstBloc.descriptionEnFocus);
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: CustomTitledRoundedTextFormWidget(
                                      controller: editUnitFirstBloc.descriptionEnController,
                                      hintText: LocaleKeys.writeDescription.tr(),
                                      maxLines: 4,
                                      title: LocaleKeys.descriptionEn.tr(),
                                      keyboardType: TextInputType.multiline,
                                      focusNode: editUnitFirstBloc.descriptionEnFocus,
                                      textInputAction: TextInputAction.newline,
                                      onFieldSubmitted: (name) {
                                        editUnitFirstBloc.descriptionEnFocus.unfocus();
                                        FocusScope.of(context).requestFocus(editUnitFirstBloc.descriptionArFocus);
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: CustomTitledRoundedTextFormWidget(
                                      controller: editUnitFirstBloc.descriptionArController,
                                      hintText: LocaleKeys.writeDescription.tr(),
                                      maxLines: 4,
                                      title: LocaleKeys.descriptionAr.tr(),
                                      keyboardType: TextInputType.multiline,
                                      focusNode: editUnitFirstBloc.descriptionArFocus,
                                      textInputAction: TextInputAction.newline,
                                      onFieldSubmitted: (name) {
                                        editUnitFirstBloc.descriptionArFocus.unfocus();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsetsDirectional.only(end: 24, start: 24, bottom: 24, top: 24),
                                child: EditScreensActions(
                                  nextAction: () {
                                    if (EditUnitFirstBloc.formKey.currentState?.validate() ?? false) {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      if (isUnitDataChanged(editUnitFirstBloc, state.unit)) {
                                        Fluttertoast.showToast(
                                            msg: LocaleKeys.changedDataCheckMessage.tr(),
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: pacificBlue,
                                            textColor: kWhite);
                                      } else {
                                        editUnitFirstBloc.add(const MoveToSecondScreen());
                                      }
                                    }
                                  },
                                  updateAction: () {
                                    if (EditUnitFirstBloc.formKey.currentState?.validate() ?? false) {
                                      if (isUnitDataChanged(editUnitFirstBloc, state.unit)) {
                                        editUnitFirstBloc.add(const FirstScreenUpdateUnit());
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: LocaleKeys.noChangeInDataToUpdateMessage.tr(),
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: pacificBlue,
                                            textColor: kWhite);
                                      }
                                    }
                                  },
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (state.isLoading)
                    Container(
                        color: Colors.black54,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: const LoadingWidget()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

bool isUnitDataChanged(EditUnitFirstBloc addUnitFirstBloc, Unit? unit) {
  return addUnitFirstBloc.titleArController.text.trim() != (unit?.titleAr??'').trim() ||
      addUnitFirstBloc.titleEnController.text.trim() != (unit?.titleEn??'').trim() ||
      addUnitFirstBloc.descriptionArController.text.trim() != (unit?.descriptionAr??'').trim() ||
      addUnitFirstBloc.descriptionEnController.text.trim() != (unit?.descriptionEn??'').trim();
}