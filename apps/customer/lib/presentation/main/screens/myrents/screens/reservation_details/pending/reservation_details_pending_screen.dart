import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/reservation/model/reservation_summary_entity.dart';
import 'package:spotx/data/remote/reservation/reservation_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/new_reservation_details_info.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/reservation_details_owner_info.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/reservation_details_slider.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/reservation_details_view_details.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/reservation_unAuthorized_widget.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/error_widget.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';

import 'bloc/reservation_details_pending_bloc.dart';
import 'bloc/reservation_details_pending_event.dart';
import 'bloc/reservations_details_pending_state.dart';

class ReservationDetailsPendingScreen extends StatelessWidget {
  const ReservationDetailsPendingScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "ReservationDetailsPendingScreen";

  @override
  Widget build(BuildContext context) {
    final reservationId = ModalRoute.of(context)!.settings.arguments as String?;
    return BlocProvider<ReservationDetailsPendingBloc>(
      create: (ctx) => ReservationDetailsPendingBloc(ReservationRepository())
        ..add(ReservationCheckIfUserIsLoggedInEvent(reservationId)),
      child: BlocBuilder<ReservationDetailsPendingBloc,
          ReservationDetailsPendingState>(
        builder: (context, state) {
          ReservationDetailsPendingBloc reservationDetailsBloc =
              BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
                appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: Header(),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: !state.isReservationDataValid
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                            child: Text(
                          LocaleKeys.noReservationDataMessage.tr(),
                          style: circularMedium(color: cadetGrey, fontSize: 17),
                        )))
                    : getDisplayWidget(
                        state, reservationDetailsBloc, context, reservationId)),
          );
        },
      ),
    );
  }

  Widget getDisplayWidget(
      ReservationDetailsPendingState state,
      ReservationDetailsPendingBloc reservationDetailsBloc,
      BuildContext context,
      String? reservationId) {
    print("state.reservation!.discount= ${state.reservation?.discount}");
    if (state.requestStatus == RequestStatus.loading) {
      if (state.showUnAuthorizedWidget) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ReservationAuthorizationWidget(
            getReservationData: () {
              reservationDetailsBloc
                  .add(ReservationCheckIfUserIsLoggedInEvent(reservationId));
            },
          ),
        );
      } else {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const LoadingWidget(),
        );
      }
    } else if (state.requestStatus == RequestStatus.failure) {
      return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AppErrorWidget(action: () {
            navigationKey.currentState?.pushReplacementNamed(
                ReservationDetailsPendingScreen.tag,
                arguments: reservationId);
          }));
    } else if (state.requestStatus == RequestStatus.success) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ReservationDetailsSliderWidget(
              showRate: state.reservation!.unit!.rate != null,
              rate: state.reservation!.unit!.rate,
              images: state.reservation!.unit!.images!,
            ),
            if (state.reservation?.unit?.id?.toString() != null)
              ReservationDetailsViewDetailsWidget(
                stateWidget: Text(
                  state.reservation!.status!,
                  style: circularMedium(
                      color: getColorByStatus(state.reservation!.status!), fontSize: 14),
                ),
                description: state.reservation!.unit!.description ??
                    "back end empty data",
                unitId: state.reservation!.unit!.id!.toString(),
              ),
            NewReservationDetailsInfoWidget(
              toDate: state.reservation!.to!,
              fromDate: state.reservation!.from!,
              daysCount: state.reservation!.days!,
              // price: state.reservation!.totalPrice!,
              reservationSummary: ReservationSummaryEntity()..totalPrice = state.reservation!.totalPrice
                ..discount= state.reservation!.discount
                ..subTotal = state.reservation!.subTotal,
              checkIn: state.reservation?.unit?.checkIn,
              checkOut: state.reservation?.unit?.checkOut,
            ),
            ReservationDetailsOwnerInfoWidget(
              owner: state.reservation!.unit!.owner!,
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(
                  start: 24, end: 24, top: 10, bottom: 5),
              height: 1,
              color: Theme.of(context).disabledColor,
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 17, bottom: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(22)),
                          border: Border.all(
                              color: Theme.of(context).dialogBackgroundColor,
                              width: .5)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 13),
                          child: Text(
                            LocaleKeys.cancelReservation.tr(),
                            style: circularMedium(color: kWhite, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      reservationDetailsBloc
                          .add(CancelReservation(reservationId!));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}