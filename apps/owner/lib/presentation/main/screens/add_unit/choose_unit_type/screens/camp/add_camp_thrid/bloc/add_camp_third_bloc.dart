import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_thrid/bloc/add_camp_third_state.dart';

import 'add_camp_third_event.dart';

class AddCampThirdBloc extends BaseBloc<AddCampThirdEvent, AddCampThirdState> {
  AddCampThirdBloc() : super(const AddCampThirdInitialRoomsState()) {
    on<AddCampThirdDeleteRoomsEvent>(_deleteRoom);
    on<AddCampThirdAddRoomEvent>(_addRoom);
  }

  FutureOr<void> _addRoom(AddCampThirdAddRoomEvent event, Emitter<AddCampThirdState> emit) {
    List<Room>? newList = Room.createNewList(state.rooms);
    Room? editedRoom;
    int? index;
    newList?.asMap().forEach((key, value) {
      if (event.room.id == value.id) {
        editedRoom = value;
        index = key;
      }
    });
    if (editedRoom != null && index != null) {
      newList?.replaceRange(index!, index! + 1, [editedRoom!]);
    } else {
      newList?.add(event.room);
    }
    emit(AddCampThirdSelectedRoomsState(newList));
  }

  FutureOr<void> _deleteRoom(AddCampThirdDeleteRoomsEvent event, Emitter<AddCampThirdState> emit) {
    List<Room>? oldList = state.rooms;
    List<Room>? newList = Room.createNewList(oldList);
    newList?.removeWhere((element) => element.id.toString() == event.room.id.toString());
    emit(AddCampThirdSelectedRoomsState(newList));
  }
}
