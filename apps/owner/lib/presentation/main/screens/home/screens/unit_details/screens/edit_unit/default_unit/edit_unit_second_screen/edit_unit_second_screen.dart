import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/data/remote/add_unit/model/RangesPricesWithDefaultPrice.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/main_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/image_upload_section.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_first_screen/widgets/edit_screens_actions.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/edit_special_price_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/widgets/edit_unit_header.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'bloc/edit_unit_second_bloc.dart';
import 'bloc/edit_unit_second_event.dart';
import 'bloc/edit_unit_second_state.dart';

class EditUnitSecondScreen extends StatelessWidget {
  const EditUnitSecondScreen({Key? key}) : super(key: key);
  static const tag = "EditUnitSecondScreen";
  @override
  Widget build(BuildContext context) {
    final Unit unit = ModalRoute.of(context)!.settings.arguments as Unit;
    return BlocProvider<EditUnitSecondBloc>(
      create: (ctx) => EditUnitSecondBloc(UnitRepository())..add(InitEditUnitSecondScreen(unit)),
      child: BlocBuilder<EditUnitSecondBloc, EditUnitSecondState>(
        builder: (context, state) {
          EditUnitSecondBloc editUnitSecondBloc = BlocProvider.of(context);
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
                        if (isUnitDataChanged(editUnitSecondBloc, state.unit, state.isPublished, state.isOnlyFamilies)) {
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
                    body: SingleChildScrollView(
                      child: Form(
                        key: EditUnitSecondBloc.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                        child: Image.asset(progress2_4IconPath),
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
                                            Text("2",
                                                style:
                                                    circularBold800(color: kWhite, fontSize: 24)),
                                            Text("/4",
                                                style:
                                                    circularBold800(color: kWhite, fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Form(
                              key: EditUnitSecondBloc.defaultPriceFromKey,
                              child: Container(
                                margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 5),
                                child: CustomTitledRoundedTextFormWidget(
                                  controller: editUnitSecondBloc.defaultPriceController,
                                  hintText: LocaleKeys.enterDefaultPrice.tr(),
                                  title: LocaleKeys.defaultPrice.tr(),
                                  keyboardType: TextInputType.number,
                                  focusNode: editUnitSecondBloc.defaultPriceFocus,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (name) {
                                    editUnitSecondBloc.defaultPriceFocus.unfocus();
                                  },
                                  validator: (value) {
                                    try {
                                      if (value?.isEmpty ?? true) {
                                        return LocaleKeys.validationInsertData.tr();
                                      } else if (int.parse(value!) < 1 || int.parse(value) > 50000) {
                                        return LocaleKeys.defaultPriceErrorMessage.tr();
                                      } else {
                                        return null;
                                      }
                                    } catch (e) {
                                      return LocaleKeys.defaultPriceErrorMessage.tr();
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.customSpecialPrice.tr(),
                                        style: circularBook(color: kWhite, fontSize: 17),
                                      ),
                                      GestureDetector(
                                        child: DottedBorder(
                                          color: Theme.of(context).disabledColor,
                                          strokeWidth: 1,
                                          dashPattern: const [8, 4],
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(10),
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(addIconPath, color: kWhite),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    LocaleKeys.edit.tr(),
                                                    style:
                                                        circularBook(color: kWhite, fontSize: 17),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          if (EditUnitSecondBloc.defaultPriceFromKey.currentState?.validate() ??
                                              false) {
                                            FocusScope.of(context).unfocus();
                                            navigateToAddSpecialScreen(
                                                editUnitSecondBloc, state.unit?.ranges, state.unit?.id);
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                  state.unit != null && state.unit?.ranges != null && state.unit!.ranges!.isNotEmpty
                                      ? Container(
                                          margin: const EdgeInsets.only(top: 10),
                                          child: Text(
                                            "${LocaleKeys.theNumberOfSpecialPricesYouAdded.tr()} ${state.unit?.ranges!.length}",
                                            style:
                                                circularBook(color: Theme.of(context).primaryColorLight, fontSize: 13),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            Container(
                              color: Theme.of(context).splashColor,
                              height: .5,
                              margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                            ),
                            ImageUploadSection(
                              imageError: state.imageError,
                              mediaFiles: state.files ?? List.empty(),
                              addFilesAction: (files) {
                                editUnitSecondBloc.add(EditUnitSecondScreenAddFilesToList(files));
                              },
                              deleteFileLocallyAction: (element) {
                                editUnitSecondBloc.add(DeleteImageLocallyEvent(element));
                              },
                              loadingMediaAction: (path) {
                                editUnitSecondBloc.add(LoadingMediaEvent(path));
                              },
                              isEdit: true,
                            ),
                            Container(
                              color: Theme.of(context).splashColor,
                              height: .5,
                              margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.published.tr(),
                                    style: circularBook(color: kWhite, fontSize: 17),
                                  ),
                                  FlutterSwitch(
                                    height: 30.0,
                                    width: 55.0,
                                    padding: 4.0,
                                    toggleSize: 28.0,
                                    borderRadius: 50.0,
                                    activeColor: Theme.of(context).primaryColorLight,
                                    value: state.isPublished,
                                    onToggle: (value) {
                                      editUnitSecondBloc.add(ChangeIsPublishedEvent(value));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.familiesOnly.tr(),
                                    style: circularBook(color: kWhite, fontSize: 17),
                                  ),
                                  FlutterSwitch(
                                    height: 30.0,
                                    width: 55.0,
                                    padding: 4.0,
                                    toggleSize: 28.0,
                                    borderRadius: 50.0,
                                    activeColor: Theme.of(context).primaryColorLight,
                                    value: state.isOnlyFamilies,
                                    onToggle: (value) {
                                      editUnitSecondBloc.add(ChangeIsOnlyFamiliesEvent(value));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(24),
                              child: EditScreensActions(
                                nextAction: () {
                                  FocusScope.of(context).unfocus();
                                  bool isAllInputsValid = EditUnitSecondBloc.formKey.currentState?.validate() ?? false;
                                  bool isDefaultPriceInputValid =
                                      EditUnitSecondBloc.defaultPriceFromKey.currentState?.validate() ?? false;
                                  if (isAllInputsValid && isDefaultPriceInputValid) {
                                    if (isUnitDataChanged(editUnitSecondBloc, state.unit, state.isPublished, state.isOnlyFamilies)) {
                                      Fluttertoast.showToast(
                                          msg: LocaleKeys.changedDataCheckMessage.tr(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: pacificBlue,
                                          textColor: kWhite);
                                    } else {
                                      editUnitSecondBloc.add(const MoveToThirdScreen());
                                    }
                                  }
                                },
                                updateAction: () {
                                  FocusScope.of(context).unfocus();
                                  bool isAllInputsValid = EditUnitSecondBloc.formKey.currentState?.validate() ?? false;
                                  bool isDefaultPriceInputValid =
                                      EditUnitSecondBloc.defaultPriceFromKey.currentState?.validate() ?? false;

                                  if (isAllInputsValid && isDefaultPriceInputValid) {
                                    if (isUnitDataChanged(editUnitSecondBloc, state.unit, state.isPublished, state.isOnlyFamilies)) {
                                      editUnitSecondBloc.add(const SecondScreenUpdateUnit());
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: LocaleKeys.noChangeInDataToUpdateMessage.tr(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: pacificBlue,
                                          textColor: kWhite
                                      );
                                    }
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
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

  Future<void> navigateToAddSpecialScreen(
    EditUnitSecondBloc addUnitSecondBloc,
    List<PriceRange>? selectedPriceRanges,
    String? unitId,
  ) async {
    RangesPricesWithDefaultPrice rangesPricesWithDefaultPrice =
        RangesPricesWithDefaultPrice(selectedPriceRanges, addUnitSecondBloc.defaultPriceController.text, unitId!);
    var result = await navigationKey.currentState
        ?.pushNamed(EditSpecialPriceScreen.tag, arguments: rangesPricesWithDefaultPrice);
    addUnitSecondBloc.add(AddSpecialPriceRangesEvent(result as List<PriceRange>?));
  }

  bool isUnitDataChanged(EditUnitSecondBloc editUnitSecondBloc, Unit? unit, bool isPublished, bool isFamiliesOnly) {
    return
        editUnitSecondBloc.defaultPriceController.text.trim() != unit?.defaultPrice?.trim() ||
        isPublished != (unit?.isVisible == 0 ? false : true) ||
        isFamiliesOnly != (unit?.isFamiliesOnly == 0 ? false : true) ||
        editUnitSecondBloc.isMediaChanged();
  }
}