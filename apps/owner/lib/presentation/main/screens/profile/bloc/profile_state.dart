import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';

class ProfileState extends Equatable {
  const ProfileState({this.isProfileLoading = false, this.user, this.isAuthorized = true, this.isError = false});
  final bool isProfileLoading;
  final User? user;
  final bool isAuthorized;
  final bool isError;
  @override
  List<Object?> get props => [isProfileLoading, user, isAuthorized, isError];

  ProfileState copyWith({bool? isProfileLoading, bool? isAuthorized, bool? isError, User? user}) {
    return ProfileState(
        isProfileLoading: isProfileLoading ?? this.isProfileLoading,
        isAuthorized: isAuthorized ?? this.isAuthorized,
        isError: isError ?? this.isError,
        user: user ?? this.user);
  }
}
