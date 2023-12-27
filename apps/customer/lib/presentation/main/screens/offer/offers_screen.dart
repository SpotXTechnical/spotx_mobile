import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/unit/model/offer_entity.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/offer/widget/offer_card_widget.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/error_widget.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';
import 'package:spotx/utils/widgets/pagination/pagination_list.dart';

import 'bloc/offers_bloc.dart';
import 'bloc/offers_event.dart';
import 'bloc/offers_state.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "OffersScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OffersBloc>(
      create: (ctx) => OffersBloc(UnitRepository())..add(GetOffersUnits()),
      child: BlocBuilder<OffersBloc, OffersState>(
        builder: (context, state) {
          OffersBloc offersBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Header(
                  title: LocaleKeys.offers.tr(),
                  showBackIcon: false,
                ),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: state.offersList == null
                  ? state.isLoading
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: const Center(child: LoadingWidget()))
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: AppErrorWidget(action: () {
                            offersBloc.add(GetOffersUnits());
                          }))
                  : Column(
                      children: [
                        Expanded(
                          child: state.offersList!.isEmpty
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.thereIsNoCurrentOffers.tr(),
                                      style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 15),
                                    ),
                                  ))
                              : Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 20, top: 8),
                                  child: PaginationList<OfferEntity>(
                                    divider: const Divider(indent: 20),
                                    isLoading: state.isLoading,
                                    scrollPhysics: const AlwaysScrollableScrollPhysics(),
                                    hasMore: false,
                                    list: state.offersList!,
                                    loadMore: () {
                                      offersBloc.add(LoadMoreOffersUnits());
                                    },
                                    builder: (OfferEntity offer) {
                                      return OfferCardWidget(offer: offer);
                                    },
                                    onRefresh: () {
                                      offersBloc.add(GetOffersUnits());
                                    },
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