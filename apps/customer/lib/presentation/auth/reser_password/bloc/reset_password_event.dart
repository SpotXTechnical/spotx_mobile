import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

class ResetPasswordUser extends ResetPasswordEvent {
  const ResetPasswordUser();

  @override
  List<Object?> get props => [];
}

class ResetPasswordHideError extends ResetPasswordEvent {
  const ResetPasswordHideError();
  @override
  List<Object?> get props => [];
}
