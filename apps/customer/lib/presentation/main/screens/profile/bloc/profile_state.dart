import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';

class ProfileState extends Equatable {
  const ProfileState({this.isProfileLoading = true, this.user, this.isAuthorized = true, this.isError = false, this.isCodeLoading = false,
  });
  final bool isProfileLoading;
  final bool isCodeLoading;
  final User? user;
  final bool isAuthorized;
  final bool isError;

  @override
  List<Object?> get props => [isProfileLoading, user, isAuthorized, isError, isCodeLoading];

  ProfileState copyWith({
    bool? isProfileLoading,
    bool? isAuthorized,
    bool? isError,
    User? user,
    bool? isCodeLoading,
  }) {
    return ProfileState(
      isProfileLoading: isProfileLoading ?? this.isProfileLoading,
      isAuthorized: isAuthorized ?? this.isAuthorized,
      isCodeLoading: isCodeLoading ?? this.isCodeLoading,
      isError: isError ?? this.isError,
      user: user ?? this.user,
    );
  }
}