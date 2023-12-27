import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/utils/force_update.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/application_error.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State>{
  BaseBloc(initialState) : super(initialState);

  Future<void> handleResponse({required ApiResponse result, Function? onSuccess, Function? onFailed}) async{
    if(result.status == Status.OK){
      await onSuccess?.call();
    } else if(result.status == Status.FAILED){
      if(result.error?.type is Unauthorized){
        logOut();
      } else if(result.error?.type is UpdateRequired) {
        showVersionDialog();
      } else {
        // analytics.logEvent(name: debugBaseControllerOnFailed, parameters: {debugErrorMessage:result.error.errorMsg});
        onFailed?.call();
      }
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
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}