import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/profile/screens/favourite/widget/favourite_card.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';
import 'package:spotx/utils/widgets/pagination/pagination_list.dart';

import 'bloc/favourite_bloc.dart';
import 'bloc/favourite_event.dart';
import 'bloc/favourite_state.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "FavouriteScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavouriteBloc>(
      create: (ctx) => FavouriteBloc(UnitRepository())..add(GetFavouriteUnits()),
      child: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          FavouriteBloc favouriteBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Header(title: LocaleKeys.myFavourite.tr()),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Column(
                children: [
                  state.isLoading || state.unitsList == null
                      ? Expanded(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: const Center(child: LoadingWidget())),
                        )
                      : Expanded(
                          child: state.unitsList!.isEmpty
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.thereIsNoCurrentFavourites.tr(),
                                      style:
                                          circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 15),
                                    ),
                                  ))
                              : Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 20, top: 8),
                                  child: PaginationList<Unit>(
                                    divider: const Divider(indent: 20),
                                    isLoading: false,
                                    hasMore: state.hasMore,
                                    list: state.unitsList!,
                                    loadMore: () {
                                      favouriteBloc.add(LoadMoreFavouriteUnits());
                                    },
                                    builder: (Unit unit) {
                                      return FavouriteCard(
                                        unit: unit,
                                        removeUnFavouriteUnit: (unit) {
                                          favouriteBloc.add(RemoveUnFavouriteUnitEvent(unit));
                                        },
                                        reloadFavouriteList: () {
                                          favouriteBloc.add(GetFavouriteUnits());
                                        },
                                      );
                                    },
                                    onRefresh: () {},
                                    loadingWidget: const LoadingWidget(),
                                  )),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
