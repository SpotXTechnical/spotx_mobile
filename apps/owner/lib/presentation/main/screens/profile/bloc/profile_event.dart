import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class GetProfileData extends ProfileEvent {
  GetProfileData();

  @override
  List<Object?> get props => [];
}

class LogOutUser extends ProfileEvent {
  LogOutUser();

  @override
  List<Object?> get props => [];
}

class DeleteAccount extends ProfileEvent {
  DeleteAccount();

  @override
  List<Object?> get props => [];
}

class ProfileCheckIfUserIsLoggedInEvent extends ProfileEvent {
  ProfileCheckIfUserIsLoggedInEvent();

  @override
  List<Object?> get props => [];
}
