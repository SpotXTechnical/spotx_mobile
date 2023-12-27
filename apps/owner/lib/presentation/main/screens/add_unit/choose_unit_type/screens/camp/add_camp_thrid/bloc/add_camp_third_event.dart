import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

abstract class AddCampThirdEvent extends Equatable {}

class AddCampThirdAddRoomEvent extends AddCampThirdEvent {
  final Room room;
  AddCampThirdAddRoomEvent(this.room);
  @override
  List<Object?> get props => [room];
}

class AddCampThirdDeleteRoomsEvent extends AddCampThirdEvent {
  final Room room;
  AddCampThirdDeleteRoomsEvent(this.room);
  @override
  List<Object?> get props => [room];
}
