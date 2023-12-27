import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/add_unit/model/RangesPricesWithDefaultPrice.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_second/widgets/number_counter_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/room/widgets/add_price_ranges_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/image_upload_section.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/add_special_price_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/header.dart';
import 'bloc/add_room_bloc.dart';
import 'bloc/add_room_event.dart';
import 'bloc/add_room_state.dart';

class AddRoomScreen extends StatelessWidget {
  const AddRoomScreen({Key? key}) : super(key: key);
  static const tag = "AddRoomScreen";
  @override
  Widget build(BuildContext context) {
    final Room? room = ModalRoute.of(context)!.settings.arguments as Room?;
    return BlocProvider<AddRoomBloc>(
      create: (ctx) => AddRoomBloc(UnitRepository())..add(InitRoomEvent(room)),
      child: BlocBuilder<AddRoomBloc, AddRoomState>(
        builder: (context, state) {
          AddRoomBloc addRoomBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: const Header(
                margin: EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Form(
                      key: AddRoomBloc.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 24, top: 10),
                            child: Text(
                              LocaleKeys.addRoomModel.tr(),
                              style: circularBold900(color: kWhite, fontSize: 30),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                            child: CustomTitledRoundedTextFormWidget(
                              controller: addRoomBloc.titleController,
                              hintText: LocaleKeys.enterModelTitle.tr(),
                              title: LocaleKeys.modelTitle.tr(),
                              keyboardType: TextInputType.text,
                              focusNode: addRoomBloc.titleFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (name) {
                                addRoomBloc.titleFocus.unfocus();
                                FocusScope.of(context).requestFocus(addRoomBloc.descriptionArFocus);
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return LocaleKeys.validationInsertData.tr();
                                } else {
                                  return null;
                                }
                              },
                              autoFocus: true,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                            child: CustomTitledRoundedTextFormWidget(
                              controller: addRoomBloc.descriptionEnController,
                              hintText: LocaleKeys.writeDescription.tr(),
                              maxLines: 4,
                              title: LocaleKeys.descriptionEn.tr(),
                              keyboardType: TextInputType.text,
                              focusNode: addRoomBloc.descriptionEnFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (name) {
                                addRoomBloc.descriptionEnFocus.unfocus();
                                FocusScope.of(context).requestFocus(addRoomBloc.descriptionArFocus);
                                FocusScope.of(context).requestFocus(addRoomBloc.descriptionArFocus);
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return LocaleKeys.validationInsertData.tr();
                                } else {
                                  return null;
                                }
                              },
                              autoFocus: true,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                            child: CustomTitledRoundedTextFormWidget(
                              controller: addRoomBloc.descriptionArController,
                              hintText: LocaleKeys.writeDescription.tr(),
                              maxLines: 4,
                              title: LocaleKeys.descriptionAr.tr(),
                              keyboardType: TextInputType.text,
                              focusNode: addRoomBloc.descriptionArFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (name) {
                                addRoomBloc.descriptionArFocus.unfocus();
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return LocaleKeys.validationInsertData.tr();
                                } else {
                                  return null;
                                }
                              },
                              autoFocus: true,
                            ),
                          ),
                          NumbersCounter(
                            incrementNumber: () {
                              addRoomBloc.add(const IncrementRoomNumberEvent());
                            },
                            decrementNumber: () {
                              addRoomBloc.add(const DecrementRoomNumberEvent());
                            },
                            number: state.roomNumbers,
                            title: LocaleKeys.roomNumbers.tr(),
                          ),
                          NumbersCounter(
                            incrementNumber: () {
                              addRoomBloc.add(const IncrementBedNumberEvent());
                            },
                            decrementNumber: () {
                              addRoomBloc.add(const DecrementBedNumberEvent());
                            },
                            number: state.bedNumbers,
                            title: LocaleKeys.bedNumbers.tr(),
                          ),
                          ImageUploadSection(
                            imageError: state.imageError,
                            mediaFiles: state.files ?? List.empty(),
                            addFilesAction: (files) {
                              addRoomBloc.add(AddRoomAddFilesToList(files));
                            },
                            deleteFileLocallyAction: (element) {
                              addRoomBloc.add(DeleteImageLocallyEvent(element));
                            },
                            loadingMediaAction: (path) {
                              addRoomBloc.add(LoadingMediaEvent(path));
                            },
                          ),
                          Form(
                            key: AddRoomBloc.defaultPriceFromKey,
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 5),
                              child: CustomTitledRoundedTextFormWidget(
                                controller: addRoomBloc.defaultPriceController,
                                hintText: LocaleKeys.enterDefaultPrice.tr(),
                                title: LocaleKeys.defaultPrice.tr(),
                                keyboardType: TextInputType.number,
                                focusNode: addRoomBloc.defaultPriceFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (name) {
                                  addRoomBloc.defaultPriceFocus.unfocus();
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
                                    AddPriceRangesWidget(addPriceRangesAction: () {
                                      if (AddRoomBloc.defaultPriceFromKey.currentState?.validate() ?? false) {
                                        addRoomBloc.defaultPriceFocus.unfocus();
                                        navigateToAddSpecialScreen(addRoomBloc, state.selectedPriceRanges);
                                      }
                                    })
                                  ],
                                ),
                                state.selectedPriceRanges != null && state.selectedPriceRanges!.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          "${LocaleKeys.theNumberOfSpecialPricesYouAdded.tr()} ${state.selectedPriceRanges!.length}",
                                          style: circularBook(color: Theme.of(context).primaryColorLight, fontSize: 15),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          state.isPriceRangesEmpty
                              ? Container(
                                  margin: const EdgeInsetsDirectional.only(top: 10, start: 40),
                                  child: Text(
                                    LocaleKeys.validationInsertData.tr(),
                                    style: errorTextStyle,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
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
                                child: Text(LocaleKeys.submit.tr(),
                                    style: circularMedium(color: kWhite, fontSize: 17))),
                          ),
                          action: () async {
                            bool isAllInputsValid = AddRoomBloc.formKey.currentState?.validate() ?? false;
                            bool isDefaultPriceInputValid =
                                AddRoomBloc.defaultPriceFromKey.currentState?.validate() ?? false;
                            if (isAllInputsValid && isDefaultPriceInputValid) {
                              addRoomBloc.add(NavigateBack(room));
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

  Future<void> navigateToAddSpecialScreen(AddRoomBloc addUnitSecondBloc, List<PriceRange>? selectedPriceRanges) async {
    RangesPricesWithDefaultPrice rangesPricesWithDefaultPrice =
        RangesPricesWithDefaultPrice(selectedPriceRanges, addUnitSecondBloc.defaultPriceController.text, null);
    var result =
        await navigationKey.currentState?.pushNamed(AddSpecialPriceScreen.tag, arguments: rangesPricesWithDefaultPrice);
    addUnitSecondBloc.add(AddSpecialPriceRangesEvent(result as List<PriceRange>?));
  }
}