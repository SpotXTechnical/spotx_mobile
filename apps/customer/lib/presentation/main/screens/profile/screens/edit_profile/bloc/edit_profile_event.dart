import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';

import '../../../../../../../data/remote/auth/models/login_response_entity.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class UpdateProfile extends EditProfileEvent {
  const UpdateProfile();
  @override
  List<Object?> get props => [];
}

class HideError extends EditProfileEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class SetCity extends EditProfileEvent {
  final City city;
  const SetCity(this.city);
  @override
  List<Object?> get props => [];
}

class SetImage extends EditProfileEvent {
  final File image;
  const SetImage(this.image);
  @override
  List<Object?> get props => [];
}

class InitUser extends EditProfileEvent {
  final User user;
  const InitUser(this.user);
  @override
  List<Object?> get props => [user];
}
