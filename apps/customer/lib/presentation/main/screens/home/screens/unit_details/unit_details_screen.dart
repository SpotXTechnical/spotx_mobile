import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/reservation/reservation_repository.dart';
import 'package:spotx/data/remote/unit/model/CalenderUnit.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/screens/summary_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/util.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/overview/overview_section.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/review/review_section.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/unit_details_content_choices.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/unit_details_header_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/unit_details_loading_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/unit_details_offer_section.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/unit_details_slider_widget.dart';
import 'package:spotx/utils/extensions/build_context_extensions.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/error_widget.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';
import 'bloc/unit_details_bloc.dart';
import 'bloc/unit_details_event.dart';
import 'bloc/unit_details_state.dart';
import 'model/unit_details_screen_nav_args.dart';

class UnitDetailsScreen extends StatelessWidget {
  const UnitDetailsScreen({Key? key}) : super(key: key);
  static const tag = "UnitDetailsScreen";
  @override
  Widget build(BuildContext context) {
    UnitDetailsScreenNavArgs unitDetailsScreenNavArgs =
        ModalRoute.of(context)!.settings.arguments as UnitDetailsScreenNavArgs;
    return BlocProvider(
        create: (ctx) =>
            UnitDetailsBloc(UnitRepository(), ReservationRepository())..add(GetDetails(unitDetailsScreenNavArgs)),
        child: BlocBuilder<UnitDetailsBloc, UnitDetailsState>(builder: (context, state) {
          UnitDetailsBloc unitDetailsBloc = BlocProvider.of(context);
          return WillPopScope(
            onWillPop: () async {
              navigationKey.currentState?.pop(state.unit);
              return false;
            },
            child: CustomSafeArea(
                child: CustomScaffold(
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: UnitDetailsHeaderWidget(
                        unit: state.unit,
                      ),
                    ),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    body: Stack(children: [
                      (state.unit == null)
                          ? state.isLoading
                              ? const UnitDetailsLoadingWidget()
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                        child: AppErrorWidget(action: () {
                                    navigationKey.currentState
                                        ?.pushReplacementNamed(UnitDetailsScreen.tag,
                                            arguments: UnitDetailsScreenNavArgs(
                                                unitDetailsScreenNavArgs.id,
                                                unitDetailsScreenNavArgs.type));
                                  }),
                                )
                          : Column(
                              children: [
                                Expanded(
                                  child: CustomScrollView(slivers: [
                                    SliverToBoxAdapter(
                                        child: Column(
                                      children: [
                                        UnitDetailsSliderWidget(
                                          unitType: state.unit!.type!,
                                          showRate: state.unit!.rate != null,
                                          rate: state.unit!.rate,
                                          images: state.unit!.images!,
                                          discountPercentage:  state.unit?.discountPercentage,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsetsDirectional.only(top: 19, start: 24, end: 24),
                                          child: Text(
                                            state.unit?.title?.trim() ?? "",
                                            style: circularMedium(color: kWhite, fontSize: 17),
                                          ),
                                        ),
                                        if (state.offerEntity != null)
                                          UnitDetailsOfferSection(offer: state.offerEntity!),
                                        UnitDetailsContentChoices(
                                          selectedContentType: state.selectedContentType,
                                          typeAction: () {
                                            unitDetailsBloc.add(ChangeContentType());
                                          },
                                        ),
                                        if (state.selectedContentType == SelectedContentType.overView)
                                          OverViewSection(unit: state.unit!),
                                        if (state.selectedContentType == SelectedContentType.review)
                                          ReviewSection(
                                            reviews: state.unit!.reviews ?? [],
                                          )
                                      ],
                                    )),
                                    if (state.selectedContentType == SelectedContentType.review && state.unit != null)
                                      if (state.unit!.reviews == null || state.unit!.reviews!.isEmpty)
                                        SliverFillRemaining(
                                          hasScrollBody: false,
                                          child: Align(
                                            child: Text(
                                              LocaleKeys.noDataMessage.tr(),
                                              style: circularBook(color: Theme.of(context).disabledColor, fontSize: 18),
                                            ),
                                          ),
                                        )
                                  ]),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(top: 19),
                                  color: Theme.of(context).backgroundColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(21.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: unitDetailsScreenNavArgs.type == UnitDetailsScreenType.normalUnit
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      "${state.unit!.currentPrice?.replaceFarsiNumber()}",
                                                      style: circularMedium(
                                                          color: kWhite, fontSize: 17),
                                                    ),
                                                    Text(
                                                      LocaleKeys.perDayWithSlash.tr(),
                                                      style: circularMedium(
                                                          color: Theme.of(context).disabledColor, fontSize: 14),
                                                    ),
                                                  ],
                                                )
                                              : state.offerEntity != null
                                                  ? Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(LocaleKeys.totalPrice.tr(),
                                                            style: circularBook(
                                                                color: kWhite, fontSize: 12)),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                            "${state.offerEntity!.totalPrice.toString()} ${LocaleKeys.le.tr()}",
                                                            style: circularMedium(
                                                                color: kWhite, fontSize: 15))
                                                      ],
                                                    )
                                                  : Container(),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            margin: const EdgeInsetsDirectional.only(start: 17),
                                            height: 56,
                                            color: Colors.transparent,
                                            child: AppButton(
                                              borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                                              textWidget: Text(
                                                unitDetailsScreenNavArgs.type == UnitDetailsScreenType.normalUnit
                                                    ? LocaleKeys.checkAvailability.tr()
                                                    : LocaleKeys.bookUnit.tr(),
                                                style: circularMedium(color: kWhite, fontSize: 17),
                                              ),
                                              title: '',
                                              color: Theme.of(context).primaryColorLight,
                                              action: () {
                                                unitDetailsScreenNavArgs.type ==
                                                        UnitDetailsScreenType
                                                            .normalUnit
                                                    ? navigateToCalender(
                                                        state.unit!)
                                                    : checkIfUserIsLoggedInBefore(
                                                      context, () {
                                                  final calenderUnit =
                                                      CalenderUnit(
                                                          0,
                                                          0,
                                                         "",
                                                          [],
                                                          [],
                                                          [],
                                                          "",
                                                          unit: state.unit,
                                                          startDate: state
                                                              .offerEntity
                                                              ?.startDate,
                                                          endDate: state
                                                              .offerEntity
                                                              ?.endDate);
                                                      navigationKey.currentState
                                                          ?.pushNamed(SummaryScreen.tag, arguments: calenderUnit);
                                                  });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                      if (state.isPostReservationLoading != null && state.isPostReservationLoading!)
                        Container(
                          color: Colors.black45,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                            child: LoadingWidget(),
                          ),
                        )
                    ]))),
          );
        }));
  }
}