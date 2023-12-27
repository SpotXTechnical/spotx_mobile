import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

abstract class EditUnitSecondEvent extends Equatable {
  const EditUnitSecondEvent();
}

class HideError extends EditUnitSecondEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class EditUnitSecondScreenAddFilesToList extends EditUnitSecondEvent {
  final List<MediaFile> files;
  const EditUnitSecondScreenAddFilesToList(this.files);
  @override
  List<Object?> get props => [files];
}

class MoveToThirdScreen extends EditUnitSecondEvent {
  const MoveToThirdScreen();
  @override
  List<Object?> get props => [];
}

class ChangeIsPublishedEvent extends EditUnitSecondEvent {
  final bool isPublished;
  const ChangeIsPublishedEvent(this.isPublished);
  @override
  List<Object?> get props => [isPublished];
}
class ChangeIsOnlyFamiliesEvent extends EditUnitSecondEvent {
  final bool isOnlyFamilies;
  const ChangeIsOnlyFamiliesEvent(this.isOnlyFamilies);
  @override
  List<Object?> get props => [isOnlyFamilies];
}
class AddSpecialPriceRangesEvent extends EditUnitSecondEvent {
  final List<PriceRange>? priceRanges;
  const AddSpecialPriceRangesEvent(this.priceRanges);
  @override
  List<Object?> get props => [priceRanges];
}

class InitEditUnitSecondScreen extends EditUnitSecondEvent {
  final Unit unit;
  const InitEditUnitSecondScreen(this.unit);
  @override
  List<Object?> get props => [unit];
}

class LoadingMediaEvent extends EditUnitSecondEvent {
  final String path;
  const LoadingMediaEvent(this.path);
  @override
  List<Object?> get props => [path];
}

class DeleteImageLocallyEvent extends EditUnitSecondEvent {
  final MediaFile file;
  const DeleteImageLocallyEvent(this.file);
  @override
  List<Object?> get props => [file];
}

class SecondScreenUpdateUnit extends EditUnitSecondEvent {
  const SecondScreenUpdateUnit();
  @override
  List<Object?> get props => [];
}
