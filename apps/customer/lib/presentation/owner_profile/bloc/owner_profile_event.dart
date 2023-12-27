import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

abstract class OwnerProfileEvent extends Equatable {}

class GetOwnerProfileOwner extends OwnerProfileEvent {
  final String ownerId;
  GetOwnerProfileOwner(this.ownerId);
  @override
  List<Object?> get props => [ownerId];
}

class GetOwnerUnits extends OwnerProfileEvent {
  final String ownerId;
  GetOwnerUnits(this.ownerId);
  @override
  List<Object?> get props => [ownerId];
}

class OwnerMoreUnitsEvent extends OwnerProfileEvent {
  OwnerMoreUnitsEvent();

  @override
  List<Object?> get props => [];
}

class UpdateOwnerUnitsEvent extends OwnerProfileEvent {
  final List<Unit> units;
  UpdateOwnerUnitsEvent(this.units);
  @override
  List<Object?> get props => [units];
}
