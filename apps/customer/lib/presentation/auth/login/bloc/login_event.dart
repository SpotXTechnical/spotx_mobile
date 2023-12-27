import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUser extends LoginEvent {
  final bool? isShowingSkip;
  const LoginUser(this.isShowingSkip);

  @override
  List<Object?> get props => [];
}

class HideError extends LoginEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}
