import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:owner/data/remote/add_unit/model/RangesPricesWithDefaultPrice.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/image_upload_section.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/add_special_price_screen.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/header.dart';

import 'bloc/add_unit_second_bloc.dart';
import 'bloc/add_unit_second_event.dart';
import 'bloc/add_unit_second_state.dart';

class AddUnitSecondScreen extends StatelessWidget {
  const AddUnitSecondScreen({Key? key}) : super(key: key);
  static const tag = "AddUnitSecondScreen";
  @override
  Widget build(BuildContext context) {
    final Unit unit = ModalRoute.of(context)!.settings.arguments as Unit;
    return BlocProvider<AddUnitSecondBloc>(
      create: (ctx) => AddUnitSecondBloc(UnitRepository()),
      child: BlocBuilder<AddUnitSecondBloc, AddUnitSecondState>(
        builder: (context, state) {
          AddUnitSecondBloc addUnitSecondBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: const Header(
                margin: EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SingleChildScrollView(
                child: Form(
                  key: AddUnitSecondBloc.formKey,
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
                      Form(
                        key: AddUnitSecondBloc.defaultPriceFromKey,
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 5),
                          child: CustomTitledRoundedTextFormWidget(
                            controller: addUnitSecondBloc.defaultPriceController,
                            hintText: LocaleKeys.enterDefaultPrice.tr(),
                            title: LocaleKeys.defaultPrice.tr(),
                            keyboardType: TextInputType.number,
                            focusNode: addUnitSecondBloc.defaultPriceFocus,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (name) {
                              addUnitSecondBloc.defaultPriceFocus.unfocus();
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
                            autoFocus: true,
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
                                              LocaleKeys.add.tr(),
                                              style: circularBook(color: kWhite, fontSize: 17),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (AddUnitSecondBloc.defaultPriceFromKey.currentState?.validate() ?? false) {
                                      FocusScope.of(context).unfocus();
                                      navigateToAddSpecialScreen(addUnitSecondBloc, state.selectedPriceRanges);
                                    }
                                  },
                                )
                              ],
                            ),
                            state.selectedPriceRanges != null && state.selectedPriceRanges!.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      "${LocaleKeys.theNumberOfSpecialPricesYouAdded.tr()} ${state.selectedPriceRanges!.length}",
                                      style: circularBook(color: Theme.of(context).primaryColorLight, fontSize: 13),
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
                          addUnitSecondBloc.add(AddUnitSecondScreenAddFilesToList(files));
                        },
                        deleteFileLocallyAction: (element) {
                          addUnitSecondBloc.add(DeleteImageLocallyEvent(element));
                        },
                        loadingMediaAction: (path) {
                          addUnitSecondBloc.add(LoadingMediaEvent(path));
                        },
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
                                addUnitSecondBloc.add(ChangeIsPublishedEvent(value));
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
                                addUnitSecondBloc.add(ChangeIsOnlyFamiliesEvent(value));
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(24),
                        child: AppButtonGradient(
                          title: LocaleKeys.next.tr(),
                          height: 55,
                          borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                          textWidget: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(28)),
                            ),
                            child: Center(
                                child: Text(LocaleKeys.next.tr(),
                                    style: circularMedium(color: kWhite, fontSize: 17))),
                          ),
                          action: () async {
                            FocusScope.of(context).unfocus();
                            bool isAllInputsValid = AddUnitSecondBloc.formKey.currentState?.validate() ?? false;
                            bool isDefaultPriceInputValid =
                                AddUnitSecondBloc.defaultPriceFromKey.currentState?.validate() ?? false;
                            if (isAllInputsValid && isDefaultPriceInputValid) {
                              addUnitSecondBloc.add(MoveToThirdScreen(unit));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> navigateToAddSpecialScreen(
      AddUnitSecondBloc addUnitSecondBloc, List<PriceRange>? selectedPriceRanges) async {
    RangesPricesWithDefaultPrice rangesPricesWithDefaultPrice =
        RangesPricesWithDefaultPrice(selectedPriceRanges, addUnitSecondBloc.defaultPriceController.text, null);

    var result =
        await navigationKey.currentState?.pushNamed(AddSpecialPriceScreen.tag, arguments: rangesPricesWithDefaultPrice);
    addUnitSecondBloc.add(AddSpecialPriceRangesEvent(result as List<PriceRange>?));
  }
}