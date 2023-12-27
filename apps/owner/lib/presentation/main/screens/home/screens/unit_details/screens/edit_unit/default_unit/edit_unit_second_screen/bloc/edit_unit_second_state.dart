import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

class EditUnitSecondState extends Equatable {
  const EditUnitSecondState({
    this.isLoading = false,
    this.files,
    this.isPublished = true,
    this.imageError,
    this.isPriceRangesEmpty = false,
    this.unit,
    this.isOnlyFamilies = false
  });
  final bool isLoading;
  final List<MediaFile>? files;
  final bool isPublished;
  final bool isPriceRangesEmpty;
  final ImageError? imageError;
  final Unit? unit;
  final bool isOnlyFamilies;

  @override
  List<Object?> get props => [isLoading, files, isPublished, isPriceRangesEmpty, imageError, unit, isOnlyFamilies];

  EditUnitSecondState copyWith({
    List<MediaFile>? files,
    bool? isLoading,
    List<PriceRange>? selectedPriceRanges,
    bool? isPublished,
    bool? isPriceRangesEmpty,
    ImageError? imageError,
    Unit? unit,
    bool? isOnlyFamilies,
  }) {
    return EditUnitSecondState(
      files: files ?? this.files,
      isLoading: isLoading ?? this.isLoading,
      isPublished: isPublished ?? this.isPublished,
      imageError: imageError ?? this.imageError,
      isPriceRangesEmpty: isPriceRangesEmpty ?? this.isPriceRangesEmpty,
      unit: unit ?? this.unit,
      isOnlyFamilies: isOnlyFamilies ?? this.isOnlyFamilies
    );
  }
}

class AddUnitFirstLoading extends EditUnitSecondState {
  const AddUnitFirstLoading() : super(isLoading: true);
}

class EditUnitSecondEmptyState extends EditUnitSecondState {
  EditUnitSecondEmptyState() : super(files: List.empty(growable: true));
}

class AddUnitSecondFilesListState extends EditUnitSecondState {
  const AddUnitSecondFilesListState(List<MediaFile>? files) : super(files: files);
}

class ImageError {
  final String errorMessage;
  final bool isError;
  ImageError(this.errorMessage, {this.isError = true});
}
