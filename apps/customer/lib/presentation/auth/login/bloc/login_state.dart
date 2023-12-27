import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/auth/models/login_errors_entity.dart';

class LoginState extends Equatable {
  const LoginState({required this.generalErrorMessage, required this.isLoading, required this.errors});
  final LoginErrorsEntity? errors;
  final String? generalErrorMessage;
  final bool isLoading;
  @override
  List<Object?> get props => [isLoading, generalErrorMessage];
}

class LoginLoading extends LoginState {
  const LoginLoading() : super(isLoading: true, generalErrorMessage: '', errors: null);
}

class LoginError extends LoginState {
  const LoginError(LoginErrorsEntity? errors, String? generalErrorsState)
      : super(isLoading: false, errors: errors, generalErrorMessage: generalErrorsState);
}

class LoginSuccess extends LoginState {
  const LoginSuccess() : super(isLoading: false, generalErrorMessage: '', errors: null);
}

class EmptyState extends LoginState {
  const EmptyState() : super(isLoading: false, generalErrorMessage: '', errors: null);
}
