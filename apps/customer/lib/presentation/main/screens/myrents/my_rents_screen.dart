import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/data/remote/reservation/reservation_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/myrents/bloc/my_rents_bloc.dart';
import 'package:spotx/presentation/main/screens/myrents/bloc/my_rents_event.dart';
import 'package:spotx/presentation/main/screens/myrents/bloc/my_rents_state.dart';
import 'package:spotx/presentation/main/screens/myrents/widgets/reservation_card.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/error_widget.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';
import 'package:spotx/utils/widgets/pagination/pagination_list.dart';
import 'package:spotx/presentation/main/screens/myrents/widgets/unAuthorized_widget.dart';

import '../../../../base/base_bloc.dart';
import '../../../../utils/widgets/header.dart';

//Multiple Cases here. isAuthorized, Loading, Success, Failure
// The InitialState is Loading and not Authorized
// First call Async method to check if Authorized Or not and this method takes time
// While that continue the flow by check if(loading and !Authorized) to know to show the current and past buttons or not
// Continue And then check if Loading? ShowLoading Spin
// So the first view for user is loading
// In backGround the _checkIfLoggedIn method will finish so it will emit that the user is not Authorized and emit state to showUnAuthorizedWidget

class MyRentsScreen extends StatelessWidget {
  const MyRentsScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "MyRentsScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyRentsBloc>(
      create: (ctx) => MyRentsBloc(ReservationRepository())..add(MyRentCheckIfUserIsLoggedInEvent()),
      child: BlocBuilder<MyRentsBloc, MyRentsState>(
        builder: (context, state) {
          MyRentsBloc myRentsBloc = BlocProvider.of(context);
          return CustomSafeArea(
              child: CustomScaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: Header(
                      title: LocaleKeys.myRents.tr(),
                      showBackIcon: false,
                    ),
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: Column(
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(top: 21, start: 24, end: 24),
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: const BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: (state.selectedRentType == SelectedRentType.upComing)
                                            ? Theme.of(context).primaryColorLight
                                            : Theme.of(context).unselectedWidgetColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                                      child: Text(
                                        LocaleKeys.current.tr(),
                                        style: circularBook(color: kWhite, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (state.selectedRentType == SelectedRentType.past && state.isAuthorized) {
                                      myRentsBloc.add(SetSelectedRentType(SelectedRentType.upComing));
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: (state.selectedRentType == SelectedRentType.past)
                                            ? Theme.of(context).primaryColorLight
                                            : Theme.of(context).unselectedWidgetColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                                      child: Text(
                                        LocaleKeys.past.tr(),
                                        style: circularBook(color: kWhite, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (state.selectedRentType == SelectedRentType.upComing && state.isAuthorized) {
                                      myRentsBloc.add(SetSelectedRentType(SelectedRentType.past));
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      if (state.upComingRequestStatus == RequestStatus.loading ||
                          state.pastRequestStatus == RequestStatus.loading)
                        if (state.showUnAuthorizedWidget)
                          Expanded(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: MyRentsAuthorizationWidget(
                                getReservationsData: () {
                                  myRentsBloc.add(MyRentCheckIfUserIsLoggedInEvent());
                                },
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: const LoadingWidget(),
                            ),
                          )
                      else if (state.upComingRequestStatus == RequestStatus.failure ||
                          state.pastRequestStatus == RequestStatus.failure)
                        Expanded(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: AppErrorWidget(action: () {
                                myRentsBloc.add(GetReservations());
                              })),
                        )
                      else if (state.upComingRequestStatus == RequestStatus.success &&
                          state.pastRequestStatus == RequestStatus.success)
                        Expanded(
                          child: state.selectedRentType == SelectedRentType.upComing
                              ? (state.upComingReservationsList!.isEmpty)
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      child: Center(
                                        child: Text(
                                          LocaleKeys.thereIsNoCurrentReservations.tr(),
                                          style: circularMedium(
                                              color: Theme.of(context).dialogBackgroundColor, fontSize: 15),
                                        ),
                                      ))
                                  : Padding(
                                      padding: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 20),
                                      child: PaginationList<Reservation>(
                                        divider: Divider(
                                          indent: 20,
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                        ),
                                        isLoading: false,
                                        hasMore: state.upComingHasMore,
                                        list: state.upComingReservationsList!,
                                        loadMore: () {
                                          myRentsBloc.add(LoadMoreUpComingReservations());
                                        },
                                        builder: (Reservation reservation) {
                                          return ReservationCardWidget(
                                            reservation: reservation,
                                          );
                                        },
                                        onRefresh: () => myRentsBloc
                                            .add(GetUpcomingReservations()),
                                        loadingWidget: const LoadingWidget(),
                                      ))
                              : (state.pastReservationsList!.isEmpty)
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      child: Center(
                                        child: Text(
                                          LocaleKeys.thereIsNoCurrentReservations.tr(),
                                          style: circularMedium(
                                              color: Theme.of(context).dialogBackgroundColor, fontSize: 15),
                                        ),
                                      ))
                                  : Padding(
                                      padding: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 20),
                                      child: Container(
                                        color: Colors.transparent,
                                        child: PaginationList<Reservation>(
                                          divider: Divider(
                                            indent: 20,
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                          ),
                                          isLoading: false,
                                          hasMore: state.pastHasMore,
                                          list: state.pastReservationsList!,
                                          loadMore: () {
                                            myRentsBloc.add(LoadMorePastReservations());
                                          },
                                          builder: (Reservation reservation) {
                                            return ReservationCardWidget(
                                              reservation: reservation,
                                            );
                                          },
                                          onRefresh: () => myRentsBloc
                                              .add(GetPastReservations()),
                                          loadingWidget: const LoadingWidget(),
                                        ),
                                      )),
                        )
                    ],
                  )));
        },
      ),
    );
  }
}