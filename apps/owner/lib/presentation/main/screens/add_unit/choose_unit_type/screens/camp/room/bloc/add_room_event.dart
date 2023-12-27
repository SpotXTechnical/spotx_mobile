import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

abstract class AddRoomEvent extends Equatable {
  const AddRoomEvent();
}

class HideError extends AddRoomEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class IncrementRoomNumberEvent extends AddRoomEvent {
  const IncrementRoomNumberEvent();

  @override
  List<Object?> get props => [];
}

class IncrementBedNumberEvent extends AddRoomEvent {
  const IncrementBedNumberEvent();

  @override
  List<Object?> get props => [];
}

class DecrementRoomNumberEvent extends AddRoomEvent {
  const DecrementRoomNumberEvent();

  @override
  List<Object?> get props => [];
}

class DecrementBedNumberEvent extends AddRoomEvent {
  const DecrementBedNumberEvent();

  @override
  List<Object?> get props => [];
}

class AddRoomAddFilesToList extends AddRoomEvent {
  final List<MediaFile> files;
  const AddRoomAddFilesToList(this.files);
  @override
  List<Object?> get props => [files];
}

class LoadingMediaEvent extends AddRoomEvent {
  final String path;
  const LoadingMediaEvent(this.path);
  @override
  List<Object?> get props => [path];
}

class DeleteImageLocallyEvent extends AddRoomEvent {
  final MediaFile file;
  const DeleteImageLocallyEvent(this.file);
  @override
  List<Object?> get props => [file];
}

class AddSpecialPriceRangesEvent extends AddRoomEvent {
  final List<PriceRange>? priceRanges;
  const AddSpecialPriceRangesEvent(this.priceRanges);
  @override
  List<Object?> get props => [priceRanges];
}

class NavigateBack extends AddRoomEvent {
  final Room? room;
  const NavigateBack(this.room);
  @override
  List<Object?> get props => [room];
}

class InitRoomEvent extends AddRoomEvent {
  final Room? room;
  const InitRoomEvent(this.room);
  @override
  List<Object?> get props => [room];
}
