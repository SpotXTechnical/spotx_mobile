import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUser extends RegisterEvent {
  const RegisterUser();
  @override
  List<Object?> get props => [];
}

class HideError extends RegisterEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class SetCity extends RegisterEvent {
  final City city;
  const SetCity(this.city);
  @override
  List<Object?> get props => [];
}

class SelectUnSelectTerms extends RegisterEvent {
  const SelectUnSelectTerms(this.isSelected);
  final bool isSelected;
  @override
  List<Object?> get props => [isSelected];
}