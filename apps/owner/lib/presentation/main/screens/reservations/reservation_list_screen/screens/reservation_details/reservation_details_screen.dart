import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/data/remote/reservation/reservation_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/widget/reservation_details_guest_info.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/widget/reservation_details_info.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/widget/reservation_details_customer_info.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/widget/reservation_details_slider.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/widget/reservation_details_view_details.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/app_button.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/error_widget.dart';
import 'package:owner/utils/widgets/header.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

import 'bloc/reservation_details_bloc.dart';
import 'bloc/reservation_details_event.dart';
import 'bloc/reservations_details_state.dart';

class ReservationDetailsScreen extends StatelessWidget {
  const ReservationDetailsScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "ReservationDetailsScreen";

  @override
  Widget build(BuildContext context) {
    final reservationId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider<ReservationDetailsBloc>(
      create: (ctx) => ReservationDetailsBloc(ReservationRepository())..add(GetReservation(reservationId)),
      child: BlocBuilder<ReservationDetailsBloc, ReservationDetailsState>(
        builder: (context, state) {
          ReservationDetailsBloc reservationDetailsBloc = BlocProvider.of(context);
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
                                ?.pushReplacementNamed(ReservationDetailsScreen.tag, arguments: reservationId);
                          }))
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              ReservationDetailsSliderWidget(
                                showRate: true,
                                rate: double.tryParse(state.reservation?.unit?.rate??'5')??5,
                                images: state.reservation?.unit?.images ?? [],
                              ),
                              if (state.reservation?.customer != null)
                                ReservationDetailsCustomerInfoWidget(
                                  owner: state.reservation?.customer,
                                ),
                              if (state.reservation?.guest != null)
                                ReservationDetailsGuestInfoWidget(owner: state.reservation?.guest),
                              ReservationDetailsViewDetailsWidget(
                                stateWidget: Text(
                                  state.reservation!.status!.toUpperCase(),
                                  style: circularMedium(color: Theme.of(context).selectedRowColor, fontSize: 14),
                                ),
                                description: state.reservation!.unit!.description ?? "back end empty data",
                              ),
                              ReservationDetailsInfoWidget(
                                reservation: state.reservation!,
                              ),
                            ],
                          ),
                        ),
                        if (state.reservation!.status == ReservationStatus.pending.name)
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Container(
                                margin: const EdgeInsetsDirectional.only(top: 17, start: 24, end: 24, bottom: 17),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: AppButton(
                                        height: 50,
                                        textWidget: Text(
                                          LocaleKeys.reject.tr(),
                                          style:
                                              circularBold800(color: Theme.of(context).primaryColorLight, fontSize: 17),
                                        ),
                                        backGround: Theme.of(context).scaffoldBackgroundColor,
                                        borderColor: Theme.of(context).primaryColorLight,
                                        title: LocaleKeys.reject.tr(),
                                        borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                                        action: () {
                                          reservationDetailsBloc.add(RejectReservationEvent());
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: AppButton(
                                        height: 50,
                                        title: LocaleKeys.accept.tr(),
                                        textWidget: Text(
                                          LocaleKeys.accept.tr(),
                                          style: circularBold800(color: kWhite, fontSize: 17),
                                        ),
                                        borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                                        action: () {
                                          reservationDetailsBloc.add(ApproveReservationEvent());
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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