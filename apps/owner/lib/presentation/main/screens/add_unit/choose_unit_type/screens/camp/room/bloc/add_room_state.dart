import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_second_screen/bloc/edit_unit_second_state.dart';

class AddRoomState extends Equatable {
  const AddRoomState(
      {this.bedNumbers = 1,
      this.roomNumbers = 1,
      this.files,
      this.imageError,
      this.selectedPriceRanges,
      this.minimumRoomNumber,
      this.isPriceRangesEmpty = false,
      this.isEdit = false});
  final int roomNumbers;
  final int bedNumbers;
  final List<MediaFile>? files;
  final ImageError? imageError;
  final bool isPriceRangesEmpty;
  final List<PriceRange>? selectedPriceRanges;
  final int? minimumRoomNumber;
  final bool isEdit;

  @override
  List<Object?> get props =>
      [roomNumbers, bedNumbers, files, imageError, selectedPriceRanges, isPriceRangesEmpty, minimumRoomNumber, isEdit];

  AddRoomState copyWith(
      {int? roomNumbers,
      int? bedNumbers,
      List<MediaFile>? files,
      ImageError? imageError,
      bool? isPriceRangesEmpty,
      List<PriceRange>? selectedPriceRanges,
      int? minimumRoomNumber,
      bool? isEdit}) {
    return AddRoomState(
        roomNumbers: roomNumbers ?? this.roomNumbers,
        bedNumbers: bedNumbers ?? this.bedNumbers,
        files: files ?? this.files,
        minimumRoomNumber: this.minimumRoomNumber,
        imageError: imageError ?? this.imageError,
        selectedPriceRanges: selectedPriceRanges ?? this.selectedPriceRanges,
        isPriceRangesEmpty: isPriceRangesEmpty ?? this.isPriceRangesEmpty,
        isEdit: isEdit ?? this.isEdit);
  }
}
