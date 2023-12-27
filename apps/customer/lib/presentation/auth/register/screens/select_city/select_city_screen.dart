import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/auth/auth_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';

import 'bloc/select_city_bloc.dart';
import 'bloc/select_city_event.dart';
import 'bloc/select_city_state.dart';

class SelectCityScreen extends StatelessWidget {
  const SelectCityScreen({
    Key? key,
  }) : super(key: key);

  static const tag = "SelectCityScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SelectCityBloc>(
      create: (ctx) => SelectCityBloc(AuthRepository())..add(const GetCities()),
      child: BlocBuilder<SelectCityBloc, SelectCityState>(
        builder: (context, state) {
          return CustomSafeArea(
              child: state.isLoading
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: const LoadingWidget(),
                    )
                  : CustomScaffold(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      appBar: PreferredSize(
                        child: Header(title: LocaleKeys.selectCity.tr()),
                        preferredSize: const Size.fromHeight(60),
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
                                        child: Container(
                                          color: Colors.transparent,
                                          width: MediaQuery.of(context).size.width,
                                          margin: const EdgeInsetsDirectional.only(end: 35, start: 35, top: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.cities![index].name!,
                                                style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 16),
                                              ),
                                              if (index != state.cities!.length - 1)
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
                                          navigationKey.currentState?.pop(state.cities![index]);
                                        },
                                      ),
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      indent: 15,
                                    );
                                  },
                                  itemCount: state.cities!.length),
                            )
                          ],
                        ),
                      ),
                    ));
        },
      ),
    );
  }
}
