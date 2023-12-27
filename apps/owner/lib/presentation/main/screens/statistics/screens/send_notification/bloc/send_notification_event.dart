import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

abstract class SendNotificationEvent extends Equatable {
  const SendNotificationEvent();
}

class GetRegions extends SendNotificationEvent {
  const GetRegions();

  @override
  List<Object?> get props => [];
}

class SetRegionEvent extends SendNotificationEvent {
  final int selectedRegionId;
  const SetRegionEvent(this.selectedRegionId);

  @override
  List<Object?> get props => [selectedRegionId];
}

class GetUnits extends SendNotificationEvent {
  const GetUnits();

  @override
  List<Object?> get props => [];
}

class SetUnitEvent extends SendNotificationEvent {
  final Unit selectedUnit;
  const SetUnitEvent(this.selectedUnit);

  @override
  List<Object?> get props => [selectedUnit];
}

class ToggleAllRegions extends SendNotificationEvent {
  const ToggleAllRegions();

  @override
  List<Object?> get props => [];
}

class PostNotificationsEvent extends SendNotificationEvent {
  const PostNotificationsEvent();
  @override
  List<Object?> get props => [];
}

class HideError extends SendNotificationEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}
