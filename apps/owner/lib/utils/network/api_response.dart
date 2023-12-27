import 'package:owner/utils/network/application_error.dart';

class ApiResponse {
  dynamic data;
  late Status status;
  ApplicationError? error;

  ApiResponse.success(data) {
    this.data = data;
    status = Status.OK;
  }

  ApiResponse.failed(ApplicationError error) {
    this.error = error;
    status = Status.FAILED;
  }
}

enum Status {
  OK, FAILED
}