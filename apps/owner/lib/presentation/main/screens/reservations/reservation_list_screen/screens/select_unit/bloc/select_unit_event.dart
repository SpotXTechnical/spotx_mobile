import 'package:equatable/equatable.dart';

abstract class SelectUnitEvent extends Equatable {
  const SelectUnitEvent();
}

class GetCities extends SelectUnitEvent {
  const GetCities();
  @override
  List<Object?> get props => [];
}
