import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/widgets/sub_region_unit_card.dart';
import 'package:spotx/presentation/owner_profile/widgets/owner_details.dart';
import 'package:spotx/presentation/owner_profile/widgets/owner_details_loading_widget.dart';
import 'package:spotx/presentation/owner_profile/widgets/owner_units_loading_widget.dart';
import 'package:spotx/utils/deep_link_utils.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/error_widget.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/pagination/pagination_list.dart';

import 'bloc/owner_profile_bloc.dart';
import 'bloc/owner_profile_event.dart';
import 'bloc/owner_profile_state.dart';

class OwnerProfileScreen extends StatelessWidget {
  const OwnerProfileScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "OwnerProfileScreen";

  @override
  Widget build(BuildContext context) {
    List<dynamic> args =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final String ownerId = args[0] as String;
    return BlocProvider<OwnerProfileBloc>(
      create: (ctx) => OwnerProfileBloc(UnitRepository())
        ..add(GetOwnerProfileOwner(ownerId))
        ..add(GetOwnerUnits(ownerId)),
      child: BlocBuilder<OwnerProfileBloc, OwnerProfileState>(
        builder: (context, state) {
          OwnerProfileBloc ownerProfileBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Header(
                  endIconPath: shareIconPath,
                  endIconAction: () {
                    if (state.owner?.id != null) {
                      createDynamicLink(state.owner!.id.toString(),
                          DynamicLinksTargets.owner);
                    }
                  },
                ),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SingleChildScrollView(
                controller: ownerProfileBloc.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    state.owner == null
                        ? state.isLoading
                            ? const OwnerDetailsLoadingWidget()
                            : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: AppErrorWidget(action: () {
                                  navigationKey.currentState
                                      ?.pushReplacementNamed(
                                          OwnerProfileScreen.tag,
                                          arguments: 1);
                                }))
                        : OwnerDetails(owner: state.owner!),
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          top: 20, start: 24, end: 24, bottom: 10),
                      child: Text(
                        LocaleKeys.otherUnits.tr(),
                        style: circularMedium(color: kWhite, fontSize: 19),
                      ),
                    ),
                    state.isUnitsLoading
                        ? const OwnerUnitesLoadingWidget()
                        : Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 24, end: 24, bottom: 20, top: 8),
                            child: PaginationList<Unit>(
                              divider: const Divider(indent: 20),
                              hasMore: state.hasMore,
                              isLoading: false,
                              list: state.units ?? [],
                              loadMore: () {},
                              builder: (Unit unit) {
                                return SubRegionUnitCard(
                                  unit: unit,
                                  showTitle: true,
                                );
                              },
                              onRefresh: () {},
                              loadingWidget: const OwnerUnitesLoadingWidget(),
                            ))
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