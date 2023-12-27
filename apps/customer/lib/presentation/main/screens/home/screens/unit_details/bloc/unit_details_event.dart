import 'package:equatable/equatable.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/model/unit_details_screen_nav_args.dart';

abstract class UnitDetailsEvent extends Equatable {}

class GetDetails extends UnitDetailsEvent {
  final UnitDetailsScreenNavArgs unitDetailsScreenNavArgs;
  GetDetails(this.unitDetailsScreenNavArgs);

  @override
  List<Object?> get props => [unitDetailsScreenNavArgs];
}

class UnitDetailsPostReservation extends UnitDetailsEvent {
  UnitDetailsPostReservation();

  @override
  List<Object?> get props => [];
}

class ChangeContentType extends UnitDetailsEvent {
  ChangeContentType();

  @override
  List<Object?> get props => [];
}
