import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/data/remote/add_unit/model/edited_calender_price_range.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_thrid/bloc/add_camp_third_event.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_thrid/bloc/add_camp_third_state.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_thrid/widgets/room_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/room/add_room_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_four/add_unit_fourth_screen.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/header.dart';

import 'bloc/add_camp_third_bloc.dart';

class AddCampThirdScreen extends StatelessWidget {
  const AddCampThirdScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "AddCampThirdScreen";
  @override
  Widget build(BuildContext context) {
    final Unit unit = ModalRoute.of(context)!.settings.arguments as Unit;
    return BlocProvider<AddCampThirdBloc>(
      create: (ctx) => AddCampThirdBloc(),
      child: BlocBuilder<AddCampThirdBloc, AddCampThirdState>(
        builder: (context, state) {
          AddCampThirdBloc addRoomsBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: Scaffold(
              appBar: Header(
                margin: const EdgeInsetsDirectional.only(top: 24, start: 24, end: 24),
                onBackAction: () {
                  if (state.rooms != null && state.rooms!.isNotEmpty) {
                    showExitWarningDialog(context: context);
                  } else {
                    navigationKey.currentState?.pop();
                  }
                },
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 10, start: 24, end: 24),
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
                              child: Image.asset(progress3_4IconPath),
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
                                  Text("3", style: circularBold800(color: kWhite, fontSize: 24)),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 14),
                            child: Column(
                              children: createSelectPriceWidgets(state.rooms, addRoomsBloc),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
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
                                          LocaleKeys.addModels.tr(),
                                          style: circularBook(color: kWhite, fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              navigateToRoomScreen(addRoomsBloc);
                            },
                          )
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
                            child: Text(LocaleKeys.next.tr(),
                                style: circularMedium(color: kWhite, fontSize: 17))),
                      ),
                      action: () async {
                        if (state.rooms == null || state.rooms!.isEmpty) {
                          Fluttertoast.showToast(
                              msg: LocaleKeys.addRoomsMessage.tr(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: kWhite);
                        } else {
                          unit.models = state.rooms;
                          unit.type = UnitType.camp.name;
                          navigationKey.currentState?.pushNamed(AddUnitFourthScreen.tag, arguments: unit);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> navigateToRoomScreen(AddCampThirdBloc addRoomsBloc) async {
    var result = await navigationKey.currentState?.pushNamed(AddRoomScreen.tag);
    if (result != null) {
      addRoomsBloc.add(AddCampThirdAddRoomEvent(result as Room));
    }
  }

  List<Widget> createSelectPriceWidgets(
    List<Room>? rooms,
    AddCampThirdBloc addRoomsBloc,
  ) {
    List<Widget> widgets = List.empty(growable: true);
    rooms?.forEach((element) {
      widgets.add(Column(
        children: [
          RoomWidget(
            room: element,
            deleteAction: () {
              addRoomsBloc.add(AddCampThirdDeleteRoomsEvent(element));
            },
            editAction: () {
              editRoom(element, rooms, addRoomsBloc);
            },
          ),
          const SizedBox(
            height: 11,
          )
        ],
      ));
    });
    return widgets;
  }

  Future<void> editRoom(Room room, List<Room> rooms, AddCampThirdBloc addRoomsBloc) async {
    var result = await navigationKey.currentState?.pushNamed(AddRoomScreen.tag, arguments: room);
    if (result != null) {
      addRoomsBloc.add(AddCampThirdAddRoomEvent(result as Room));
    }
  }

  void navigateToCalenderScreenEdit(
      AddCampThirdBloc addSpecialPriceBloc, EditedCalenderPriceRange editedCalenderPriceRange) async {
    // var result = await navigationKey.currentState?.pushNamed(CalenderScreen.tag, arguments: editedCalenderPriceRange);
    // if (result != null) {
    //   addSpecialPriceBloc.add(AddPriceRangesListEvent(result as List<PriceRange>));
    // }
  }
}