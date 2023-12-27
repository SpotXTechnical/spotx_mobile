import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

class AddCampThirdState extends Equatable {
  const AddCampThirdState({this.rooms});
  final List<Room>? rooms;
  @override
  List<Object?> get props => [rooms];
}

class AddCampThirdInitialRoomsState extends AddCampThirdState {
  const AddCampThirdInitialRoomsState() : super();
}

class AddCampThirdSelectedRoomsState extends AddCampThirdState {
  const AddCampThirdSelectedRoomsState(List<Room>? rooms) : super(rooms: rooms);
}
