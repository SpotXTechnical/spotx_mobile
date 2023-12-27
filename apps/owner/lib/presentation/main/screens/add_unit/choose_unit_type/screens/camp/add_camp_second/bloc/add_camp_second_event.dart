import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

abstract class AddCampSecondEvent extends Equatable {
  const AddCampSecondEvent();
}

class AddUnitThirdHideError extends AddCampSecondEvent {
  const AddUnitThirdHideError();
  @override
  List<Object?> get props => [];
}

class AddCheckInTime extends AddCampSecondEvent {
  final TimeOfDay checkInTime;
  final String checkInString;
  const AddCheckInTime(this.checkInTime, this.checkInString);
  @override
  List<Object?> get props => [checkInTime, checkInString];
}

class AddCheckOutTime extends AddCampSecondEvent {
  final TimeOfDay checkOutTime;
  final String checkOutString;
  const AddCheckOutTime(this.checkOutTime, this.checkOutString);
  @override
  List<Object?> get props => [checkOutTime, checkOutString];
}

class GetRegionsWithSubRegion extends AddCampSecondEvent {
  const GetRegionsWithSubRegion();

  @override
  List<Object?> get props => [];
}

class AddCampSecondSetRegion extends AddCampSecondEvent {
  final Region region;

  const AddCampSecondSetRegion(this.region);

  @override
  List<Object?> get props => [region];
}

class AddCampSecondSetSubRegion extends AddCampSecondEvent {
  final Region selectedSubRegion;

  const AddCampSecondSetSubRegion(this.selectedSubRegion);

  @override
  List<Object?> get props => [selectedSubRegion];
}

class MoveToFourthScreenEvent extends AddCampSecondEvent {
  final Unit unit;
  const MoveToFourthScreenEvent(this.unit);

  @override
  List<Object?> get props => [unit];
}

class AddCampSecondScreenAddFilesToListEvent extends AddCampSecondEvent {
  final List<MediaFile> files;
  const AddCampSecondScreenAddFilesToListEvent(this.files);
  @override
  List<Object?> get props => [files];
}

class LoadingMediaEvent extends AddCampSecondEvent {
  final String path;
  const LoadingMediaEvent(this.path);
  @override
  List<Object?> get props => [path];
}

class DeleteImageLocallyEvent extends AddCampSecondEvent {
  final MediaFile file;
  const DeleteImageLocallyEvent(this.file);
  @override
  List<Object?> get props => [file];
}

class ChangeIsPublishedEvent extends AddCampSecondEvent {
  final bool isPublished;
  const ChangeIsPublishedEvent(this.isPublished);
  @override
  List<Object?> get props => [isPublished];
}

class AddCampSecondGetRegionById extends AddCampSecondEvent {
  final String regionId;

  const AddCampSecondGetRegionById({required this.regionId});

  @override
  List<Object?> get props => [regionId];
}
