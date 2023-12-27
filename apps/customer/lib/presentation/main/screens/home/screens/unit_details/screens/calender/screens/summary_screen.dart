import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/reservation/reservation_repository.dart';
import 'package:spotx/data/remote/unit/model/CalenderUnit.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/screens/bloc/summary_bloc.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/screens/bloc/summary_event.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/screens/bloc/summary_state.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/new_reservation_details_info.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/reservation_details_slider.dart';
import 'package:spotx/utils/date_formats.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "SummaryScreen";
  @override
  Widget build(BuildContext context) {
    final calenderUnit = ModalRoute.of(context)?.settings.arguments as CalenderUnit;
    return BlocProvider<SummaryBloc>(
      create: (ctx) => SummaryBloc(ReservationRepository())
        ..add(
          ReservationSummary(
            calenderUnit.startDate.toString(),
            calenderUnit.endDate.toString(),
            calenderUnit.unit?.id ?? 0,
            calenderUnit.unit?.type ?? "",
          ),
        ),
      child: BlocBuilder<SummaryBloc, SummaryState>(
        builder: (context, state) {
          SummaryBloc summaryBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Header(),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Stack(
                children: [
                 state.summaryLoading ?  const Center(
                   child: LoadingWidget(),
                 ):  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ReservationDetailsSliderWidget(
                              showRate: calenderUnit.unit?.rate != null,
                              rate: calenderUnit.unit?.rate,
                              images: calenderUnit.unit?.images ?? [],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsetsDirectional.only(top: 19, start: 24, end: 24),
                              child: Text(
                                calenderUnit.unit?.title ?? "",
                                style: circularBook(color: Theme.of(context).hintColor, fontSize: 17),
                              ),
                            ),
                           if (state.reservationSummary != null) Container(
                              margin: const EdgeInsets.only(bottom: 23),
                              child:  NewReservationDetailsInfoWidget(
                                toDate: calenderUnit.endDate ?? defaultDateTime,
                                fromDate: calenderUnit.startDate ?? defaultDateTime,
                                checkIn: calenderUnit.unit?.checkIn ?? "",
                                checkOut: calenderUnit.unit?.checkOut ?? "",
                                daysCount: calenderUnit.endDate?.difference(calenderUnit.startDate ?? defaultDateTime).inDays ?? 0,
                                reservationSummary: state.reservationSummary!
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Container(
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
                                      LocaleKeys.submit.tr(),
                                      style: circularMedium(color: kWhite, fontSize: 20),
                                    ))),
                                action: () {
                                  summaryBloc.add(PostReservation(
                                      calenderUnit.startDate.toString(),
                                      calenderUnit.endDate.toString(),
                                      calenderUnit.unit?.id ?? 0,
                                      calenderUnit.unit?.type ?? ""));
                                },
                              ),
                            )),
                      )
                    ],
                  ),
                  if (state.isLoading)
                    Container(
                      color: Colors.black45,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: LoadingWidget(),
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