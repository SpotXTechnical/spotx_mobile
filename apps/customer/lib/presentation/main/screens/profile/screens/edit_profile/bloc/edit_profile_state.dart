import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';
import 'package:spotx/data/remote/auth/models/register_error_entity.dart';

class EditProfileState extends Equatable {
  const EditProfileState(
      {this.generalErrorMessage,
      this.errors,
      this.isLoading = false,
      this.city,
      this.citiesLoading = false,
      this.image,
      this.networkImage});
  final RegisterErrorsEntity? errors;
  final String? generalErrorMessage;
  final bool isLoading;
  final City? city;
  final bool citiesLoading;
  final File? image;
  final String? networkImage;
  @override
  List<Object?> get props => [isLoading, errors, city, image];
  EditProfileState copyWith(
      {bool? citiesLoading,
      City? city,
      RegisterErrorsEntity? errors,
      String? generalErrorMessage,
      bool? isLoading,
      File? image,
      String? networkImage}) {
    return EditProfileState(
        citiesLoading: citiesLoading ?? this.citiesLoading,
        city: city ?? this.city,
        errors: errors ?? this.errors,
        generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
        isLoading: isLoading ?? this.isLoading,
        image: image ?? this.image,
        networkImage: networkImage ?? this.networkImage);
  }
}

class EmptyState extends EditProfileState {
  const EmptyState() : super(isLoading: false, errors: null, generalErrorMessage: null);
}

class CityState extends EditProfileState {
  const CityState(City city) : super(isLoading: false, errors: null, generalErrorMessage: null, city: city);
}
