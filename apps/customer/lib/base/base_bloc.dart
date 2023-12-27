import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/utils/force_update.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/application_error.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(initialState) : super(initialState);

  Future<void> handleResponse({required ApiResponse result, Function? onSuccess, Function? onFailed}) async {
    if (result.status == Status.OK) {
      await onSuccess?.call();
    } else if (result.status == Status.FAILED) {
      if (result.error?.type is Unauthorized) {
        logOut();
      } else if(result.error?.type is UpdateRequired) {
        showVersionDialog();
      }
      // analytics.logEvent(name: debugBaseControllerOnFailed, parameters: {debugErrorMessage:result.error.errorMsg});
      onFailed?.call();
    }
    return Future.value();
  }

  Future<void> handleMultipleResponse(
      {required List<ApiResponse> result, Function? onSuccess, Function? onFailed}) async {
    if (result[0].status == Status.OK && result[1].status == Status.OK) {
      await onSuccess?.call();
    } else if (result[0].status == Status.FAILED || result[1].status == Status.FAILED) {
      if (result[0].error?.type is Unauthorized || result[1].error?.type is Unauthorized) {
        logOut();
      }
      // analytics.logEvent(name: debugBaseControllerOnFailed, parameters: {debugErrorMessage:result.error.errorMsg});
      onFailed?.call();
    }
    return Future.value();
  }

  void logOut() {
    // todo to be implemented
  }

  showErrorMsg(String errorMsg) {
    debugPrint("error: $errorMsg");
    Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

enum RequestStatus { failure, success, loading }