import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/model/reservations_calender_config.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/model/units_with_selected_unit_id.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/header.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

import '../../../../../../../data/remote/add_unit/model/unit.dart';
import 'bloc/select_unit_bloc.dart';
import 'bloc/select_unit_event.dart';
import 'bloc/select_unit_state.dart';

class SelectUnitScreen extends StatelessWidget {
  const SelectUnitScreen({
    Key? key,
  }) : super(key: key);

  static const tag = "SelectUnitScreen";

  @override
  Widget build(BuildContext context) {
    final unitsWithSelectedUnitId = ModalRoute.of(context)?.settings.arguments
        as UnitsWithSelectedIdAndType;
    final List<Unit> units = unitsWithSelectedUnitId.units;
    final String selectedId = unitsWithSelectedUnitId.selectedId;
    final String type = unitsWithSelectedUnitId.type;
    return BlocProvider<SelectUnitBloc>(
      create: (ctx) => SelectUnitBloc()..add(const GetCities()),
      child: BlocBuilder<SelectUnitBloc, SelectUnitState>(
        builder: (context, state) {
          return CustomSafeArea(
              child: state.isLoading
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Theme.of(context).dividerColor,
                      child: const LoadingWidget(),
                    )
                  : CustomScaffold(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(60),
                        child: Header(title: LocaleKeys.selectUnit.tr()),
                      ),
                      body: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(top: 30, bottom: 30),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) => GestureDetector(
                                        child: units[index].type == UnitType.camp.name
                                            ? Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: createCampRoomsWidget(units[index], context, selectedId, type),
                                              )
                                            : Container(
                                                color: Colors.transparent,
                                                width: MediaQuery.of(context).size.width,
                                                margin: const EdgeInsetsDirectional.only(end: 35, start: 35, top: 10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          units[index].title ?? "",
                                                          style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 16),
                                                        ),
                                                        if (selectedId == units[index].id && units[index].type == type)
                                                          SizedBox(
                                                              width: 15,
                                                              height: 15,
                                                              child: Image.asset(doneIconPath, color: kWhite))
                                                      ],
                                                    ),
                                                    if (index != units.length - 1)
                                                      Container(
                                                        margin: const EdgeInsetsDirectional.only(top: 16),
                                                        width: MediaQuery.of(context).size.width,
                                                        height: 1,
                                                        color: Theme.of(context).unselectedWidgetColor,
                                                      )
                                                  ],
                                                ),
                                              ),
                                        onTap: () {
                                          navigationKey.currentState?.pop(
                                              ReservationsCalenderConfig(
                                                  units[index].id ?? "",
                                                  units[index].type ?? "",
                                                  units[index].title ?? "",
                                                  units[index].defaultPrice ??
                                                      ""));
                                        },
                                      ),
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      indent: 15,
                                    );
                                  },
                                  itemCount: units.length),
                            )
                          ],
                        ),
                      ),
                    ));
        },
      ),
    );
  }

  List<Widget> createCampRoomsWidget(Unit camp, BuildContext context, String selectedId, String type) {
    List<Widget> widgets = List.empty(growable: true);
    widgets.add(Container(
      margin: const EdgeInsetsDirectional.only(end: 35, start: 35, top: 10, bottom: 20),
      child: Text(
        "${camp.title} ${LocaleKeys.rooms.tr()}:",
        style: circularMedium(color: Theme.of(context).primaryColorLight, fontSize: 16),
      ),
    ));
    camp.rooms?.asMap().forEach((key, value) {
      widgets.add(Padding(
        padding: const EdgeInsetsDirectional.only(start: 25),
        child: GestureDetector(
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsetsDirectional.only(end: 35, start: 35, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      value.title ?? "",
                      style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 16),
                    ),
                    if (selectedId == value.id && camp.type == type)
                      SizedBox(width: 15, height: 15, child: Image.asset(doneIconPath, color: kWhite))
                  ],
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 16),
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Theme.of(context).unselectedWidgetColor,
                )
              ],
            ),
          ),
          onTap: () {
            navigationKey.currentState?.pop(ReservationsCalenderConfig(
                value.id ?? "",
                camp.type ?? "",
                value.title ?? "",
                value.defaultPrice ?? ""));
          },
        ),
      ));
    });
    return widgets;
  }
}