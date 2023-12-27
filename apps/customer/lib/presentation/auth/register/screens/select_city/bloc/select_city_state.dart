import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';

class SelectCityState extends Equatable {
  const SelectCityState({this.cities, this.isLoading = false});
  final List<City>? cities;
  final bool isLoading;

  @override
  List<Object?> get props => [cities, isLoading];
}

class Cities extends SelectCityState {
  const Cities(List<City> cities) : super(cities: cities);
}

class SelectCitiesLoading extends SelectCityState {
  const SelectCitiesLoading(bool isLoading) : super(isLoading: isLoading);
}
