import 'dart:async';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/screens/rating/bloc/rating_event.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/screens/rating/bloc/rating_state.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/style/theme.dart';

class RatingBloc extends BaseBloc<RatingEvent, RatingState> {
  RatingBloc(this.unitRepository) : super(const RatingState()) {
    on<PostRating>(_postRating);
    on<HideError>(_hideError);
  }

  final IUnitRepository unitRepository;
  final TextEditingController messageController = TextEditingController();
  final FocusNode messageFocus = FocusNode();

  static final formKey = GlobalKey<FormState>();

  FutureOr<void> _postRating(PostRating event, Emitter<RatingState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await unitRepository.postRating(event.reservationId, state.ownerRate, state.unitRate, messageController.text);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          emit(state.copyWith(unitRate: "10", isLoading: true));
          Fluttertoast.showToast(
              msg: LocaleKeys.ratingAddedSuccessfully.tr(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: pacificBlue,
              textColor: kWhite);
          navigationKey.currentState?.pop();
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _hideError(HideError event, Emitter<RatingState> emit) {}
}