import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/data/remote/add_unit/model/RangesPricesWithDefaultPrice.dart';
import 'package:owner/data/remote/add_unit/model/edited_calender_price_range.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/price_range/price_range_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/widgets/selected_price_range_widget.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/bloc/edit_special_price_event.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/bloc/edit_special_price_state.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/screens/calender/edit_calender_screen.dart';
import 'package:owner/utils/extensions/build_context_extensions.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/table_calender/utils.dart';
import 'package:owner/utils/utils.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/header.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

import 'bloc/edit_special_price_bloc.dart';

class EditSpecialPriceScreen extends StatelessWidget {
  EditSpecialPriceScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "EditSpecialPriceScreen";
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final RangesPricesWithDefaultPrice? rangesWithDefault =
        ModalRoute.of(context)!.settings.arguments as RangesPricesWithDefaultPrice?;
    Future.delayed(const Duration(milliseconds: 500), () {
      context.showNormalAlert(
          title: LocaleKeys.warning.tr(),
          body: LocaleKeys.changesWillBeUpdatedDirectly.tr(),
          buttonTitle: LocaleKeys.ok.tr(),
          onPressed: () {
            context.navigator.pop(false);
          });
    });
    return BlocProvider<EditSpecialPriceBloc>(
      create: (ctx) => EditSpecialPriceBloc(PriceRangeRepository())
        ..add(AddPriceRangesListEvent(PriceRange.createNewListOfPriceRange(rangesWithDefault?.ranges))),
      child: BlocBuilder<EditSpecialPriceBloc, EditSpecialPriceState>(
        builder: (context, state) {
          EditSpecialPriceBloc addSpecialPriceBloc = BlocProvider.of(context);
          return WillPopScope(
            onWillPop: () async {
              navigationKey.currentState?.pop(state.selectedPriceRanges);
              return false;
            },
            child: CustomSafeArea(
              child: Stack(
                children: [
                  Scaffold(
                    appBar: Header(
                      margin: const EdgeInsetsDirectional.only(top: 24, start: 24, end: 24),
                      onBackAction: () {
                        navigationKey.currentState?.pop(state.selectedPriceRanges);
                      },
                      title: LocaleKeys.addSpecialPrice.tr(),
                    ),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    body: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
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
                                                LocaleKeys.addSpecialPrice.tr(),
                                                style: circularBook(color: kWhite, fontSize: 17),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    navigateToCalenderScreenAdd(addSpecialPriceBloc, state.selectedPriceRanges,
                                        rangesWithDefault?.defaultPrice, rangesWithDefault?.unitId);
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
                                  child: createSelectPriceWidgets(state.selectedPriceRanges, addSpecialPriceBloc,
                                      rangesWithDefault?.defaultPrice, rangesWithDefault?.unitId),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(20),
                          child: AppButtonGradient(
                            title: LocaleKeys.register.tr(),
                            height: 55,
                            borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                            textWidget: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(28)),
                              ),
                              child: Center(
                                  child: Text(LocaleKeys.done.tr(),
                                      style: circularMedium(color: kWhite, fontSize: 17))),
                            ),
                            action: () async {
                              if (state.selectedPriceRanges == null || state.selectedPriceRanges!.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: LocaleKeys.pleaseSelectRange.tr(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: kWhite);
                              } else {
                                navigationKey.currentState?.pop(state.selectedPriceRanges);
                              }
                            },
                          ),
                        ),
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

  Future<void> navigateToCalenderScreenAdd(EditSpecialPriceBloc addSpecialPriceBloc, List<PriceRange>? currentList,
      String? defaultPrice, String? unitId) async {
    var result = await navigationKey.currentState?.pushNamed(EditCalenderScreen.tag,
        arguments: EditedCalenderPriceRange(currentList, null, null, defaultPrice, unitId!));
    if (result != null) {
      addSpecialPriceBloc.add(AddPriceRangesListEvent(result as List<PriceRange>));
    }
  }

  ListView createSelectPriceWidgets(List<PriceRange>? selectedPriceRanges, EditSpecialPriceBloc editSpecialPriceBloc,
      String? defaultPrice, String? unitId) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: selectedPriceRanges?.length ?? 0,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SelectedPriceRangeWidget(
              priceRange: selectedPriceRanges!.elementAt(index),
              deleteAction: () {
                showDeleteWarningDialog(
                    context: context,
                    onConfirm: () {
                      editSpecialPriceBloc.add(DeletePriceRangeEvent(selectedPriceRanges.elementAt(index)));
                    });
              },
              editAction: () {
                final currentPriceRange = selectedPriceRanges.elementAt(index);
                debugPrint("currentPriceRange= $currentPriceRange");
                if (currentPriceRange.startDay?.isAfter(kToday) == true) {
                  editRangeInCalenderScreen(
                    currentPriceRange,
                    selectedPriceRanges,
                    editSpecialPriceBloc,
                    defaultPrice,
                    unitId!,
                  );
                }
              },
            ),
            const SizedBox(
              height: 11,
            )
          ],
        );
      },
    );
  }

  Future<void> editRangeInCalenderScreen(PriceRange element, List<PriceRange> selectedPriceRanges,
      EditSpecialPriceBloc addSpecialPriceBloc, String? defaultPrice, String unitId) async {
    List<PriceRange> newList = PriceRange.createNewListOfPriceRange(selectedPriceRanges);
    PriceRange editedElement = newList.firstWhere((e) => e.from == element.from);
    int? editedElementIndex = newList.indexWhere((e) => e.from == element.from);
    newList.removeWhere((e) => e.from == element.from);
    navigateToCalenderScreenEdit(addSpecialPriceBloc,
        EditedCalenderPriceRange(newList, editedElement, editedElementIndex, defaultPrice, unitId));
  }

  void navigateToCalenderScreenEdit(
      EditSpecialPriceBloc addSpecialPriceBloc, EditedCalenderPriceRange editedCalenderPriceRange) async {
    var result =
        await navigationKey.currentState?.pushNamed(EditCalenderScreen.tag, arguments: editedCalenderPriceRange);
    if (result != null) {
      addSpecialPriceBloc.add(AddPriceRangesListEvent(result as List<PriceRange>));
    }
  }
}