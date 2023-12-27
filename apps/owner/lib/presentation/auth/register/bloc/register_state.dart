import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/auth/models/register_error_entity.dart';
import 'package:owner/data/remote/auth/models/register_request_entity.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.imageFile,
    this.nationalIdImageFile,
    this.generalErrorMessage,
    this.errors,
    this.isLoading = false,
    this.userType = UserType.owner,
    this.nationalIdErrorMessage,
    this.personalImageErrorMessage,
    this.isTermsSelected = false
  });
  final RegisterErrorsEntity? errors;
  final String? generalErrorMessage;
  final bool isLoading;
  final File? imageFile;
  final UserType userType;
  final File? nationalIdImageFile;
  final String? personalImageErrorMessage;
  final String? nationalIdErrorMessage;
  final bool isTermsSelected;

  @override
  List<Object?> get props => [
    isLoading,
    errors,
    generalErrorMessage,
    imageFile,
    userType,
    nationalIdImageFile,
    nationalIdErrorMessage,
    personalImageErrorMessage,
    isTermsSelected
  ];

  RegisterState copyWith({
    RegisterErrorsEntity? errors,
    String? generalErrorMessage,
    File? imageFile,
    bool? isLoading,
    UserType? userType,
    File? nationalIdImageFile,
    String? personalImageErrorMessage,
    String? nationalIdErrorMessage,
    bool? isTermsSelected
  }) {
    return RegisterState(
      errors: errors ?? this.errors,
      generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
      imageFile: imageFile ?? this.imageFile,
      isLoading: isLoading ?? this.isLoading,
      userType: userType ?? this.userType,
      nationalIdImageFile: nationalIdImageFile ?? this.nationalIdImageFile,
      nationalIdErrorMessage: nationalIdErrorMessage ?? this.nationalIdErrorMessage,
      personalImageErrorMessage: personalImageErrorMessage ?? this.personalImageErrorMessage,
      isTermsSelected: isTermsSelected ?? this.isTermsSelected
    );
  }
}

class EmptyState extends RegisterState {
  const EmptyState() : super(isLoading: false, errors: null, generalErrorMessage: null);
}
