import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';

abstract class AddUnitSecondEvent extends Equatable {
  const AddUnitSecondEvent();
}

class HideError extends AddUnitSecondEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class AddUnitSecondScreenAddFilesToList extends AddUnitSecondEvent {
  final List<MediaFile> files;
  const AddUnitSecondScreenAddFilesToList(this.files);
  @override
  List<Object?> get props => [files];
}

class MoveToThirdScreen extends AddUnitSecondEvent {
  final Unit unit;
  const MoveToThirdScreen(this.unit);
  @override
  List<Object?> get props => [unit];
}

class ChangeIsPublishedEvent extends AddUnitSecondEvent {
  final bool isPublished;
  const ChangeIsPublishedEvent(this.isPublished);
  @override
  List<Object?> get props => [isPublished];
}

class ChangeIsOnlyFamiliesEvent extends AddUnitSecondEvent {
  final bool isOnlyFamilies;
  const ChangeIsOnlyFamiliesEvent(this.isOnlyFamilies);
  @override
  List<Object?> get props => [isOnlyFamilies];
}

class AddSpecialPriceRangesEvent extends AddUnitSecondEvent {
  final List<PriceRange>? priceRanges;
  const AddSpecialPriceRangesEvent(this.priceRanges);
  @override
  List<Object?> get props => [priceRanges];
}

class LoadingMediaEvent extends AddUnitSecondEvent {
  final String path;
  const LoadingMediaEvent(this.path);
  @override
  List<Object?> get props => [path];
}

class DeleteImageLocallyEvent extends AddUnitSecondEvent {
  final MediaFile file;
  const DeleteImageLocallyEvent(this.file);
  @override
  List<Object?> get props => [file];
}
