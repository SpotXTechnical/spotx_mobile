import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/auth/models/register_request_entity.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUser extends RegisterEvent {
  const RegisterUser();
  @override
  List<Object?> get props => [];
}

class RegisterAddImage extends RegisterEvent {
  final File? imageFile;
  const RegisterAddImage(this.imageFile);
  @override
  List<Object?> get props => [];
}

class RegisterAddNationalIdImage extends RegisterEvent {
  final File? imageFile;
  const RegisterAddNationalIdImage(this.imageFile);
  @override
  List<Object?> get props => [];
}

class RegisterRemoveNationalIdImage extends RegisterEvent {
  const RegisterRemoveNationalIdImage();
  @override
  List<Object?> get props => [];
}

class SelectUnSelectTerms extends RegisterEvent {
  const SelectUnSelectTerms(this.isSelected);
  final bool isSelected;
  @override
  List<Object?> get props => [isSelected];
}

class HideError extends RegisterEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class RegisterSelectUserTypeEvent extends RegisterEvent {
  final UserType userType;
  const RegisterSelectUserTypeEvent(this.userType);
  @override
  List<Object?> get props => [];
}

class ValidateImages extends RegisterEvent {
  const ValidateImages();
  @override
  List<Object?> get props => [];
}
