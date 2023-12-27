import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/review_bottom_sheet/bloc/review_bottom_sheet_event.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/review_bottom_sheet/bloc/review_bottom_sheet_state.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomRoundedTextFormField.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';

import 'bloc/review_bottom_bloc.dart';

void showReviewBottomSheet(BuildContext context, String reservationId, Function afterRatingAction) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider<ReviewBottomSheetBloc>(
            create: (ctx) => ReviewBottomSheetBloc(UnitRepository()),
            child: BlocBuilder<ReviewBottomSheetBloc, ReviewBottomSheetState>(builder: (context, state) {
              ReviewBottomSheetBloc reviewBottomSheetBloc = BlocProvider.of(context);
              return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: MediaQuery.of(context).copyWith().size.height * .9,
                child: CustomScaffold(
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(top: 32, start: 20, end: 20),
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: const BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                            child: Center(
                              child: Form(
                                key: ReviewBottomSheetBloc.formKey,
                                child: Column(
                                  children: [
                                    Image.asset(ratingIconPath),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(top: 28),
                                      child: Text(
                                        LocaleKeys.rateUnitMessage.tr(),
                                        style: circularBookBold(color: kWhite, fontSize: 24),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(top: 35),
                                      child: RatingBar.builder(
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 30,
                                        unratedColor: Theme.of(context).unselectedWidgetColor,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        itemBuilder: (context, _) =>
                                            Image.asset(starActiveIconPath, color: Theme.of(context).canvasColor),
                                        onRatingUpdate: (rating) {
                                          debugPrint("$rating");
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(top: 35),
                                      child: Text(
                                        LocaleKeys.rateOwnerMessage.tr(),
                                        style: circularBookBold(color: kWhite, fontSize: 24),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(top: 35),
                                      child: RatingBar.builder(
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 30,
                                        unratedColor: Theme.of(context).unselectedWidgetColor,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        itemBuilder: (context, _) =>
                                            Image.asset(starActiveIconPath, color: Theme.of(context).canvasColor),
                                        onRatingUpdate: (rating) {
                                          debugPrint("$rating");
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(top: 40),
                                      child: CustomRoundedTextFormField(
                                        keyboardType: TextInputType.multiline,
                                        controller: reviewBottomSheetBloc.messageController,
                                        focusNode: reviewBottomSheetBloc.messageFocus,
                                        minLines: 6,
                                        maxLines: 6,
                                        hasBorder: true,
                                        hintText: LocaleKeys.writeYourComment.tr(),
                                        fillColor: Theme.of(context).backgroundColor,
                                        cursorColor: kWhite,
                                        style: const TextStyle(color: kWhite),
                                        autoFocus: true,
                                        validator: (value) {
                                          if (value?.isEmpty ?? true) {
                                            return LocaleKeys.validationInsertData.tr();
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsetsDirectional.all(20),
                          child: AppButton(
                            title: LocaleKeys.submit.tr(),
                            height: 55,
                            borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                            isLoading: state.isLoading,
                            textWidget: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(28)),
                              ),
                              child: Center(
                                child: Text(
                                  LocaleKeys.rate.tr(),
                                  style: circularMedium(color: kWhite, fontSize: 17),
                                ),
                              ),
                            ),
                            action: () async {
                              reviewBottomSheetBloc.add(HideError());
                              await Future.delayed(const Duration(milliseconds: 100));
                              if (ReviewBottomSheetBloc.formKey.currentState?.validate() ?? false) {
                                FocusScope.of(context).unfocus();
                                reviewBottomSheetBloc
                                    .add(ReviewBottomSheetPostRating(reservationId, afterRatingAction));
                              } else {
                                reviewBottomSheetBloc.add(HideError());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor);
}