import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/add_unit_third_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/utils.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_second_screen/bloc/edit_unit_second_state.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';

import 'add_unit_second_event.dart';
import 'add_unit_second_state.dart';

class AddUnitSecondBloc extends BaseBloc<AddUnitSecondEvent, AddUnitSecondState> {
  AddUnitSecondBloc(this.unitRepository) : super(AddUnitSecondEmptyState()) {
    on<AddUnitSecondScreenAddFilesToList>(_addFilesToFilesList);
    on<MoveToThirdScreen>(_moveToThirdScreen);
    on<ChangeIsPublishedEvent>(_chaneIsPublishedState);
    on<ChangeIsOnlyFamiliesEvent>(_chaneIsOnlyFamiliesState);
    on<AddSpecialPriceRangesEvent>(_addSpecialPriceRanges);
    on<DeleteImageLocallyEvent>(_deleteImage);
    on<LoadingMediaEvent>(_loadingMediaEvent);
  }

  static final formKey = GlobalKey<FormState>();
  static final defaultPriceFromKey = GlobalKey<FormState>();
  final FocusNode addressArFocus = FocusNode();
  final FocusNode addressEnFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  final FocusNode defaultPriceFocus = FocusNode();
  final TextEditingController addressArController = TextEditingController();
  final TextEditingController addressEnController = TextEditingController();
  final TextEditingController defaultPriceController = TextEditingController();

  final IUnitRepository unitRepository;

  _deleteImage(DeleteImageLocallyEvent event, Emitter<AddUnitSecondState> emit) {
    List<MediaFile> newFilesList = MediaFile.createNewFilesList(state.files);
    MediaFile? deletedElement;
    deletedElement = newFilesList.firstWhere((element) => element.path == event.file.path);
    newFilesList.removeWhere((element) => element.path == deletedElement!.path);
    emit(state.copyWith(files: newFilesList));
  }

  _loadingMediaEvent(LoadingMediaEvent event, Emitter<AddUnitSecondState> emit) {
    state.files?.firstWhere((element) => element.path == event.path).status = uploadingLoadingStatus;
    List<MediaFile> newFilesList = MediaFile.createNewFilesList(state.files);
    emit(state.copyWith(files: newFilesList));
  }

  _addFilesToFilesList(AddUnitSecondScreenAddFilesToList event, Emitter<AddUnitSecondState> emit) async {
    List<MediaFile> newFilesList = MediaFile.createNewFilesList(state.files);
    List<MediaFile> addedFilesList = List.empty(growable: true);

    //update old files after add image api
    for (var newElement in event.files) {
      for (var oldElement in newFilesList) {
        if (newElement.status != uploadingLoadingStatus) {
          if (newElement.path == oldElement.path) {
            oldElement.id = newElement.id;
            oldElement.status = newElement.status;
          }
        }
      }
    }
    //add new files in case uploading for first time
    addedFilesList.addAll(event.files.where((element) => element.status == uploadingLoadingStatus));
    newFilesList.addAll(addedFilesList);

    for (var element in newFilesList) {
      if (element.fileType == videoType && element.thumbnail == null) {
        element.thumbnail = await getVideoThumbnailFromLocalPath(element);
      }
    }

    emit(state.copyWith(files: newFilesList));
  }

  _moveToThirdScreen(MoveToThirdScreen event, Emitter<AddUnitSecondState> emit) {
    if (state.files == null || state.files!.isEmpty || assertAllImagesAreUploaded(state.files!)) {
      emit(state.copyWith(imageError: getImageErrorMessage(), isPriceRangesEmpty: false));
    } else {
      emit(state.copyWith(isPriceRangesEmpty: false, imageError: ImageError("", isError: false)));
      event.unit.imagesIds = state.files!.map((e) => e.id!).toList();
      event.unit.addressAr = addressArController.text;
      event.unit.addressEn = addressEnController.text;
      event.unit.defaultPrice = defaultPriceController.text;
      event.unit.isVisible = state.isPublished ? 1 : 0;
      event.unit.isFamiliesOnly = state.isOnlyFamilies ? 1 : 0;
      event.unit.ranges = state.selectedPriceRanges;
      navigationKey.currentState?.pushNamed(AddUnitThirdScreen.tag, arguments: event.unit);
    }
  }

  _chaneIsPublishedState(ChangeIsPublishedEvent event, Emitter<AddUnitSecondState> emit) {
    emit(state.copyWith(isPublished: !state.isPublished));
  }

  _addSpecialPriceRanges(AddSpecialPriceRangesEvent event, Emitter<AddUnitSecondState> emit) {
    emit(state.copyWith(selectedPriceRanges: event.priceRanges));
  }

  ImageError? getImageErrorMessage() {
    if (state.files == null || state.files!.isEmpty) {
      return ImageError(LocaleKeys.validationInsertData.tr());
    }
    if (assertAllImagesAreUploaded(state.files!)) {
      return ImageError(LocaleKeys.waitUploadingImagesMessage.tr());
    }
    return null;
  }

  FutureOr<void> _chaneIsOnlyFamiliesState(ChangeIsOnlyFamiliesEvent event, Emitter<AddUnitSecondState> emit) {
    emit(state.copyWith(isOnlyFamilies: !state.isOnlyFamilies));
  }
}
