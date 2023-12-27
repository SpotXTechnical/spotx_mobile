import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spotx/data/remote/unit/model/CalenderUnit.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/camp_details/widgets/overview_section.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/bloc/unit_details_state.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/calender_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/review/review_section.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/unit_details_header_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/unit_details_slider_widget.dart';
import 'package:spotx/utils/extensions/build_context_extensions.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/error_widget.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';
import '../unit_details/widgets/unit_details_content_choices.dart';
import 'bloc/Camp_details_state.dart';
import 'bloc/camp_details_bloc.dart';
import 'bloc/camp_details_event.dart';

class CampDetailsScreen extends StatelessWidget {
  const CampDetailsScreen({Key? key}) : super(key: key);
  static const tag = "CampDetailsScreen";
  @override
  Widget build(BuildContext context) {
    final unitId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
        create: (ctx) => CampDetailsBloc(UnitRepository())..add(GetCampDetails(int.parse(unitId))),
        child: BlocBuilder<CampDetailsBloc, CampDetailsState>(builder: (context, state) {
          CampDetailsBloc campDetailsBloc = BlocProvider.of(context);
          return WillPopScope(
            onWillPop: () async {
              navigationKey.currentState?.pop(state.unit);
              return false;
            },
            child: CustomSafeArea(
                child: CustomScaffold(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    body: (state.unit == null)
                        ? state.isLoading
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: const LoadingWidget(),
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: AppErrorWidget(action: () {
                                  navigationKey.currentState
                                      ?.pushReplacementNamed(CampDetailsScreen.tag, arguments: unitId);
                                }))
                        : Column(
                            children: [
                              Expanded(
                                child: CustomScrollView(
                                  slivers: [
                                    SliverToBoxAdapter(
                                      child: Column(
                                        children: [
                                          UnitDetailsHeaderWidget(
                                            unit: state.unit!,
                                          ),
                                          UnitDetailsSliderWidget(
                                            unitType: state.unit!.type!,
                                            showRate: state.unit!.rate != null,
                                            rate: state.unit!.rate,
                                            images: state.unit!.images!,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsetsDirectional.only(top: 19, start: 24, end: 24),
                                            child: Text(
                                              state.unit!.title!,
                                              style: circularMedium(color: kWhite, fontSize: 17),
                                            ),
                                          ),
                                          UnitDetailsContentChoices(
                                            selectedContentType: state.selectedContentType,
                                            typeAction: () {
                                              campDetailsBloc.add(ChangeContentType());
                                            },
                                          ),
                                          if (state.selectedContentType == SelectedContentType.overView)
                                            OverViewSection(
                                              unit: state.unit!,
                                              onRoomClicked: (room) {
                                                navigateToCalender(state.unit!, room);
                                              },
                                            ),
                                          if (state.selectedContentType == SelectedContentType.review)
                                            ReviewSection(reviews: state.unit!.reviews ?? [])
                                        ],
                                      ),
                                    ),
                                    if (state.selectedContentType == SelectedContentType.review && state.unit != null)
                                      if (state.unit!.reviews == null || state.unit!.reviews!.isEmpty)
                                        SliverFillRemaining(
                                          hasScrollBody: false,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              LocaleKeys.noDataMessage.tr(),
                                              style: circularBook(color: Theme.of(context).disabledColor, fontSize: 18),
                                            ),
                                          ),
                                        )
                                  ],
                                ),
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
                                        child: Row(
                                          children: [
                                            Text(
                                              "${state.unit!.currentPrice?.replaceFarsiNumber()}",
                                              style: circularMedium(color: kWhite, fontSize: 17),
                                            ),
                                            Text(
                                              LocaleKeys.perDayWithSlash.tr(),
                                              style:
                                                  circularMedium(color: Theme.of(context).disabledColor, fontSize: 14),
                                            ),
                                          ],
                                        ),
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
                                              LocaleKeys.checkAvailability.tr(),
                                              style: circularMedium(color: kWhite, fontSize: 17),
                                            ),
                                            title: '',
                                            color: Theme.of(context).primaryColorLight,
                                            action: () {
                                              checkRoomsAreExist(state.unit!, context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ))),
          );
        }));
  }

  void checkRoomsAreExist(Unit unit, BuildContext context) {
    if (unit.rooms == null || unit.rooms!.isEmpty) {
      Fluttertoast.showToast(
          msg: LocaleKeys.noRoomsInCampMessage.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColorLight,
          textColor: kWhite);
    } else {
      navigateToCalender(unit, unit.rooms![0]);
    }
  }

  void navigateToCalender(Unit unit, Room selectedRoom) {
    navigationKey.currentState?.pushNamed(CalenderScreen.tag,
        arguments: CalenderUnit(
            selectedRoom.id!, -1, unit.type!, null, null, unit.rooms, selectedRoom.title ?? "backend empty data",
            unit: unit));
  }
}