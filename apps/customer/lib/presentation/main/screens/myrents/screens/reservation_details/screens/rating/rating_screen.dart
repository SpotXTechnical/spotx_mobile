import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomRoundedTextFormField.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/header.dart';

import 'bloc/rating_bloc.dart';
import 'bloc/rating_event.dart';
import 'bloc/rating_state.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "RatingScreen";
  @override
  Widget build(BuildContext context) {
    String reservationId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider<RatingBloc>(
      create: (ctx) => RatingBloc(UnitRepository()),
      child: BlocBuilder<RatingBloc, RatingState>(
        builder: (context, state) {
          RatingBloc ratingBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              resizeToAvoidBottomInset: true,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Header(title: LocaleKeys.rating.tr()),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                            key: RatingBloc.formKey,
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
                                    controller: ratingBloc.messageController,
                                    focusNode: ratingBloc.messageFocus,
                                    minLines: 6,
                                    maxLines: 6,
                                    hasBorder: true,
                                    hintText: LocaleKeys.writeYourComment.tr(),
                                    fillColor: Theme.of(context).backgroundColor,
                                    cursorColor: kWhite,
                                    autoFocus: true,
                                    style: TextStyle(color: kWhite),
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
                          ratingBloc.add(HideError());
                          await Future.delayed(const Duration(milliseconds: 100));
                          if (RatingBloc.formKey.currentState?.validate() ?? false) {
                            FocusScope.of(context).unfocus();
                            ratingBloc.add(PostRating(reservationId));
                          } else {
                            ratingBloc.add(HideError());
                          }
                        },
                      ),
                    ),
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