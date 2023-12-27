import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:spotx/data/remote/regions/regions_repository.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/widgets/slider_shimmer_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/widgets/sub_region_details_loading_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/widgets/sub_region_unit_card.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/unit_details_slider_widget.dart';
import 'package:spotx/utils/deep_link_utils.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/error_widget.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';
import 'package:spotx/utils/widgets/pagination/pagination_list.dart';
import 'package:spotx/utils/widgets/shimmer_skeleton.dart';

import 'bloc/sub_region_bloc.dart';
import 'bloc/sub_region_event.dart';
import 'bloc/sub_region_state.dart';

class SubRegionDetailsScreen extends StatelessWidget {
  const SubRegionDetailsScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "SubRegionDetailsScreen";

  @override
  Widget build(BuildContext context) {
    final subRegionId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider<SubRegionBloc>(
      create: (ctx) => SubRegionBloc(UnitRepository(), RegionsRepository())
        ..add(GetSubRegionEvent(subRegionId))
        ..add(SubRegionGetUnitsEvent(subRegionId)),
      child: BlocBuilder<SubRegionBloc, SubRegionState>(
        builder: (context, state) {
          SubRegionBloc bloc = BlocProvider.of<SubRegionBloc>(context);
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Header(
                  title: state.subRegion?.name ?? "",
                  endIconPath: shareIconPath,
                  endIconAction: (state.subRegion?.id != null)
                      ? () {
                          createDynamicLink(
                            state.subRegion!.id!.toString(),
                            DynamicLinksTargets.subRegion,
                          );
                        }
                      : null,
                ),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SingleChildScrollView(
                controller: bloc.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.isSubRegionLoading
                        ? const SliderShimmerWidget()
                        : state.subRegion != null
                            ? UnitDetailsSliderWidget(
                                unitType: state.subRegion?.name ?? "",
                                showRate: false,
                                images: state.subRegion?.images ?? [],
                              )
                            : const SizedBox(),
                    state.isSubRegionLoading
                        ? ShimmerSkeleton(
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(
                                  top: 19, start: 24, end: 24, bottom: 19),
                              width: 100,
                              height: 25,
                              color: Theme.of(context).hoverColor,
                            ),
                          )
                        : state.subRegion != null
                            ? Container(
                                margin: const EdgeInsetsDirectional.only(
                                    top: 20,
                                    end: 22,
                                    start: 22,
                                    bottom: 15),
                                width: MediaQuery.of(context).size.width,
                                child: ReadMoreText(
                                  "${state.subRegion?.description}",
                                  trimLines: 3,
                                  style: circularBook(
                                      color: Theme.of(context)
                                          .dialogBackgroundColor,
                                      fontSize: 14),
                                  colorClickableText:
                                      Theme.of(context).primaryColorLight,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText:
                                      LocaleKeys.readMore.tr(),
                                  trimExpandedText:
                                      LocaleKeys.readLess.tr(),
                                  lessStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .primaryColorLight),
                                  moreStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .primaryColorLight),
                                ),
                              )
                            : const SizedBox(),
                    state.units == null
                        ? state.isUnitsLoading
                            ? const SubRegionDetailsLoadingWidget()
                            : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: AppErrorWidget(
                                  action: () {
                                    navigationKey.currentState
                                        ?.pushReplacementNamed(
                                            SubRegionDetailsScreen.tag,
                                            arguments: subRegionId);
                                  },
                                ),
                              )
                        : state.units!.isEmpty
                            ? SizedBox(
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 30, bottom: 30),
                                    child: Text(
                                      LocaleKeys.noUnitsInRegionMessage.tr(),
                                      style: circularMedium(
                                          color: Theme.of(context)
                                              .dialogBackgroundColor,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 24, end: 24, bottom: 20, top: 8),
                                child: PaginationList<Unit>(
                                  divider: Divider(
                                    indent: 20,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  isLoading: false,
                                  hasMore: state.hasMore,
                                  list: state.units!,
                                  loadMore: () {},
                                  builder: (Unit unit) {
                                    return SubRegionUnitCard(
                                      unit: unit,
                                      showTitle: true,
                                    );
                                  },
                                  onRefresh: () {},
                                  loadingWidget: const LoadingWidget(),
                                ),
                              )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}