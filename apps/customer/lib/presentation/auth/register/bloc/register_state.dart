import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';
import 'package:spotx/data/remote/auth/models/register_error_entity.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.generalErrorMessage,
    this.errors,
    this.isLoading = false,
    this.city,
    this.citiesLoading = false,
    this.isTermsSelected = false,
  });

  final RegisterErrorsEntity? errors;
  final String? generalErrorMessage;
  final bool isLoading;
  final City? city;
  final bool citiesLoading;
  final bool isTermsSelected;

  @override
  List<Object?> get props => [isLoading, errors, city, isTermsSelected];

  RegisterState copyWith({
    bool? citiesLoading,
    City? city,
    RegisterErrorsEntity? errors,
    String? generalErrorMessage,
    bool? isLoading,
    bool? isTermsSelected,
  }) {
    return RegisterState(
      citiesLoading: citiesLoading ?? this.citiesLoading,
      city: city ?? this.city,
      errors: errors ?? this.errors,
      generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
      isLoading: isLoading ?? this.isLoading,
      isTermsSelected: isTermsSelected ?? this.isTermsSelected
    );
  }
}

class EmptyState extends RegisterState {
  const EmptyState() : super(isLoading: false, errors: null, generalErrorMessage: null);
}

class CityState extends RegisterState {
  const CityState(City city) : super(isLoading: false, errors: null, generalErrorMessage: null, city: city);
}