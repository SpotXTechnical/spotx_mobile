import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/auth/models/login_errors_entity.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({this.generalErrorMessage, required this.isLoading});
  final String? generalErrorMessage;
  final bool isLoading;
  @override
  List<Object?> get props => [isLoading, generalErrorMessage];
}

class ResetPasswordLoading extends ResetPasswordState {
  const ResetPasswordLoading() : super(isLoading: true);
}

class ResetPasswordError extends ResetPasswordState {
  const ResetPasswordError(String? generalErrorsState)
      : super(isLoading: false, generalErrorMessage: generalErrorsState);
}

class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess() : super(isLoading: false);
}

class ResetPasswordEmptyState extends ResetPasswordState {
  const ResetPasswordEmptyState() : super(isLoading: false);
}
