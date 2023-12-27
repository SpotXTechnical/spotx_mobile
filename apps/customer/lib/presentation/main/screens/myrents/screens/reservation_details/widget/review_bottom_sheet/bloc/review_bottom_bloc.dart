import 'dart:async';
import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/review_bottom_sheet/bloc/review_bottom_sheet_event.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/review_bottom_sheet/bloc/review_bottom_sheet_state.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/style/theme.dart';

class ReviewBottomSheetBloc extends BaseBloc<ReviewBottomSheetEvent, ReviewBottomSheetState> {
  ReviewBottomSheetBloc(this.unitRepository) : super(const ReviewBottomSheetState()) {
    on<ReviewBottomSheetPostRating>(_postRating);
    on<HideError>(_hideError);
  }

  final IUnitRepository unitRepository;
  final TextEditingController messageController = TextEditingController();
  final FocusNode messageFocus = FocusNode();

  static final formKey = GlobalKey<FormState>();

  FutureOr<void> _postRating(ReviewBottomSheetPostRating event, Emitter<ReviewBottomSheetState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse =
        await unitRepository.postRating(event.reservationId, state.ownerRate, state.unitRate, messageController.text);
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
          event.afterRatingAction.call();
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isLoading: false));
            try {
              LinkedHashMap<String, dynamic> errorMessage = apiResponse.error?.extra as LinkedHashMap<String, dynamic>;
              var range = errorMessage["message"] as List<dynamic>;
              showErrorMsg(range.first);
            } catch (r) {
              showErrorMsg(LocaleKeys.error.tr());
            }
          }
        });
  }

  _hideError(HideError event, Emitter<ReviewBottomSheetState> emit) {}
}