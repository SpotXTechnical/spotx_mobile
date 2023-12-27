import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_second_screen/bloc/edit_unit_second_state.dart';

class AddUnitSecondState extends Equatable {
  const AddUnitSecondState({
    this.isLoading = false,
    this.files,
    this.selectedPriceRanges,
    this.isPublished = true,
    this.imageError,
    this.isPriceRangesEmpty = false,
    this.isOnlyFamilies = false
  });
  final bool isLoading;
  final List<MediaFile>? files;
  final List<PriceRange>? selectedPriceRanges;
  final bool isPublished;
  final bool isOnlyFamilies;
  final bool isPriceRangesEmpty;
  final ImageError? imageError;

  @override
  List<Object?> get props => [isLoading, files, selectedPriceRanges,
    isPublished, isPriceRangesEmpty, imageError, isOnlyFamilies];

  AddUnitSecondState copyWith({
    List<MediaFile>? files,
    bool? isLoading,
    List<PriceRange>? selectedPriceRanges,
    bool? isPublished,
    bool? isPriceRangesEmpty,
    ImageError? imageError,
    bool? isOnlyFamilies,
  }) {
    return AddUnitSecondState(
      files: files ?? this.files,
      isLoading: isLoading ?? this.isLoading,
      selectedPriceRanges: selectedPriceRanges ?? this.selectedPriceRanges,
      isPublished: isPublished ?? this.isPublished,
      imageError: imageError ?? this.imageError,
      isPriceRangesEmpty: isPriceRangesEmpty ?? this.isPriceRangesEmpty,
      isOnlyFamilies: isOnlyFamilies ?? this.isOnlyFamilies
    );
  }
}

class AddUnitFirstLoading extends AddUnitSecondState {
  const AddUnitFirstLoading() : super(isLoading: true);
}

class AddUnitSecondEmptyState extends AddUnitSecondState {
  AddUnitSecondEmptyState() : super(files: List.empty(growable: true));
}

class AddUnitSecondFilesListState extends AddUnitSecondState {
  const AddUnitSecondFilesListState(List<MediaFile>? files) : super(files: files);
}
