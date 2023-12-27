import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/data/remote/reservation/reservation_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/reservation_details_info.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/reservation_details_owner_info.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/reservation_details_slider.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/reservation_details_view_details.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/review_bottom_sheet/review_bottom_sheet.dart';
import 'package:spotx/utils/date_formats.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/error_widget.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';

import 'bloc/reservation_details_rented_bloc.dart';
import 'bloc/reservation_details_rented_event.dart';
import 'bloc/reservations_details_rented_state.dart';

class ReservationDetailsRentedScreen extends StatelessWidget {
  const ReservationDetailsRentedScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "ReservationDetailsRentedScreen";
  @override
  Widget build(BuildContext context) {
    final reservationId = ModalRoute.of(context)?.settings.arguments as String;
    return BlocProvider<ReservationDetailsRentedBloc>(
      create: (ctx) => ReservationDetailsRentedBloc(ReservationRepository())..add(GetReservation(reservationId)),
      child: BlocBuilder<ReservationDetailsRentedBloc, ReservationDetailsRentedState>(
        builder: (context, state) {
          ReservationDetailsRentedBloc reservationDetailsRentedBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Header(),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: state.reservation == null
                  ? state.isLoading
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                            child: LoadingWidget(),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: AppErrorWidget(action: () {
                            navigationKey.currentState
                                ?.pushReplacementNamed(ReservationDetailsRentedScreen.tag, arguments: reservationId);
                          }))
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ReservationDetailsSliderWidget(
                                showRate: state.reservation?.unit?.rate != null,
                                rate: state.reservation?.unit?.rate,
                                images: state.reservation?.unit?.images ?? [],
                              ),
                              if (state.reservation?.unit?.id?.toString() != null)
                                ReservationDetailsViewDetailsWidget(
                                  stateWidget: Text(
                                    state.reservation?.status ?? "",
                                    style: circularMedium(
                                        color: getColorByStatus(
                                            state.reservation?.status ?? ""),
                                        fontSize: 14),
                                  ),
                                  description:
                                      state.reservation?.unit?.description ?? "",
                                  unitId: state.reservation?.unit?.id.toString() ?? "",
                                ),
                              ReservationDetailsInfoWidget(
                                toDate: state.reservation?.to ?? defaultDateTime,
                                fromDate: state.reservation?.from ?? defaultDateTime ,
                                daysCount: state.reservation?.days ?? 0,
                                price: state.reservation?.totalPrice  ?? 0,
                              ),
                              if (state.reservation?.unit?.owner != null)
                                Container(
                                  margin: const EdgeInsets.only(bottom: 23),
                                  child: ReservationDetailsOwnerInfoWidget(
                                    owner: state.reservation!.unit!.owner!,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: state.reservation?.status == reservationApprovedStatus &&
                                      state.reservation?.isReviewed != null &&
                                      !state.reservation!.isReviewed!
                                  ? Container(
                                      margin: const EdgeInsets.only(bottom: 23, left: 23, right: 23),
                                      child: AppButton(
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
                                                child: Text(
                                              LocaleKeys.reviewThisRent.tr(),
                                              style: circularMedium(color: kWhite, fontSize: 20),
                                            ))),
                                        action: () {
                                          showReviewBottomSheet(context, reservationId, () {
                                            reservationDetailsRentedBloc.add(GetReservation(reservationId));
                                          });
                                          // navigationKey.currentState
                                          //     ?.pushNamed(RatingScreen.tag, arguments: reservationId);
                                        },
                                      ),
                                    )
                                  : Container()),
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