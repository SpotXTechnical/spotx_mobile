import 'package:equatable/equatable.dart';

abstract class SelectCityEvent extends Equatable {
  const SelectCityEvent();
}

class GetCities extends SelectCityEvent {
  const GetCities();
  @override
  List<Object?> get props => [];
}
