import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/image_entity.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/utils.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_third_screen/edit_unit_third_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';

import 'edit_unit_second_event.dart';
import 'edit_unit_second_state.dart';

class EditUnitSecondBloc extends BaseBloc<EditUnitSecondEvent, EditUnitSecondState> {
  EditUnitSecondBloc(this.unitRepository) : super(EditUnitSecondEmptyState()) {
    on<EditUnitSecondScreenAddFilesToList>(_addFilesToFilesList);
    on<MoveToThirdScreen>(_moveToThirdScreen);
    on<ChangeIsPublishedEvent>(_changeIsPublishedState);
    on<AddSpecialPriceRangesEvent>(_addSpecialPriceRanges);
    on<InitEditUnitSecondScreen>(_init);
    on<ChangeIsOnlyFamiliesEvent>(_chaneIsOnlyFamiliesState);
    on<DeleteImageLocallyEvent>(_deleteImage);
    on<LoadingMediaEvent>(_loadingMediaEvent);
    on<SecondScreenUpdateUnit>(_updateUnit);
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

  _init(InitEditUnitSecondScreen event, Emitter<EditUnitSecondState> emit) async {
    addressEnController.text = event.unit.addressEn ?? "";
    addressArController.text = event.unit.addressAr ?? "";
    defaultPriceController.text = event.unit.defaultPrice ?? "";

    //move the cursor to the end of edit text manually
    addressEnController.selection = TextSelection.fromPosition(TextPosition(offset: addressEnController.text.length));

    List<MediaFile>? files = event.unit.images
        ?.map((e) => MediaFile(
              fileType: e.type,
              path: e.url,
              id: e.id,
              status: uploadingSuccessStatus,
            ))
        .toList();
    if (files != null) {
      for (var element in files) {
        if (element.fileType == videoType && element.path != null) {
          element.thumbnailString = await getVideoThumbnailFromNetwork(element.path);
        }
      }
    }
    emit(
      state.copyWith(
        files: files,
        unit: event.unit,
        selectedPriceRanges: event.unit.ranges,
        isPublished: event.unit.isVisible == 0 ? false : true,
        isOnlyFamilies: event.unit.isFamiliesOnly == 0 ? false : true
      )
    );
  }

  _deleteImage(DeleteImageLocallyEvent event, Emitter<EditUnitSecondState> emit) {
    List<MediaFile> newFilesList = MediaFile.createNewFilesList(state.files);
    MediaFile? deletedElement;
    deletedElement = newFilesList.firstWhere((element) => element.path == event.file.path);
    newFilesList.removeWhere((element) => element.path == deletedElement!.path);
    emit(state.copyWith(files: newFilesList));
  }

  _loadingMediaEvent(LoadingMediaEvent event, Emitter<EditUnitSecondState> emit) {
    state.files?.firstWhere((element) => element.path == event.path).status = uploadingLoadingStatus;
    List<MediaFile> newFilesList = MediaFile.createNewFilesList(state.files);
    emit(state.copyWith(files: newFilesList));
  }

  _addFilesToFilesList(EditUnitSecondScreenAddFilesToList event, Emitter<EditUnitSecondState> emit) async {
    List<MediaFile> newFilesList = MediaFile.createNewFilesList(state.files);
    List<MediaFile> addedFilesList = List.empty(growable: true);

    //update old files after add image api
    for (var newElement in event.files) {
      for (var oldElement in newFilesList) {
        if (newElement.status != uploadingLoadingStatus) {
          if (newElement.path == oldElement.path) {
            oldElement.id = newElement.id;
            oldElement.status = newElement.status;
            oldElement.netWorkUrl = newElement.netWorkUrl;
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

  _moveToThirdScreen(MoveToThirdScreen event, Emitter<EditUnitSecondState> emit) async {
    if (state.files == null || state.files!.isEmpty || assertAllImagesAreUploaded(state.files!)) {
      emit(state.copyWith(imageError: getImageErrorMessage(), isPriceRangesEmpty: false));
    } else {
      emit(state.copyWith(isPriceRangesEmpty: false, imageError: ImageError("", isError: false)));
      //update this screen unit
      var result = await navigationKey.currentState?.pushNamed(EditUnitThirdScreen.tag, arguments: state.unit) as Unit;
      emit(state.copyWith(unit: result));
    }
  }

  _changeIsPublishedState(ChangeIsPublishedEvent event, Emitter<EditUnitSecondState> emit) {
    emit(state.copyWith(isPublished: !state.isPublished));
  }

  _addSpecialPriceRanges(AddSpecialPriceRangesEvent event, Emitter<EditUnitSecondState> emit) {
    Unit? unit = state.unit?.clone();
    unit?.ranges = event.priceRanges;
    emit(state.copyWith(unit: unit));
  }

  _updateUnit(SecondScreenUpdateUnit event, Emitter<EditUnitSecondState> emit) async {
    if (state.files == null || state.files!.isEmpty || assertAllImagesAreUploaded(state.files!)) {
      emit(state.copyWith(imageError: getImageErrorMessage(), isPriceRangesEmpty: false));
    } else {
      emit(state.copyWith(isLoading: true, imageError: ImageError("", isError: false)));
      ApiResponse apiResponse = await unitRepository.updateUnit(getUnitWithChangedData());
      await handleResponse(
          result: apiResponse,
          onSuccess: () {
            emit(state.copyWith(isLoading: false));
            updateUnitReference(state.unit);
            Fluttertoast.showToast(
                msg: LocaleKeys.unitUpdatedSuccessfully.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: pacificBlue,
                textColor: kWhite);
          },
          onFailed: () {
            if (apiResponse.error != null) {
              emit(state.copyWith(isLoading: false));
              showErrorMsg(apiResponse.error?.errorMsg ?? "Some thing Error has been happened");
            }
          });
    }
  }

  void updateUnitReference(Unit? referenceUnit) {
    referenceUnit?.addressAr = addressArController.text.trim();
    referenceUnit?.addressEn = addressEnController.text.trim();
    referenceUnit?.defaultPrice = defaultPriceController.text.trim();
    referenceUnit?.isVisible = state.isPublished ? 1 : 0;
    referenceUnit?.isFamiliesOnly = state.isOnlyFamilies ? 1 : 0;
    referenceUnit?.imagesIds = state.files?.map((e) => e.id!).toList();
    referenceUnit?.images = state.files
        ?.map((e) => ImageEntity(
              type: e.fileType,
              url: e.netWorkUrl ?? e.path,
              id: e.id,
            ))
        .toList();
    referenceUnit?.address = isArabic ? addressArController.text.trim() : addressEnController.text.trim();
  }

  Unit getUnitWithChangedData() {
    Unit unit = Unit(id: state.unit!.id);
    if (addressEnController.text.trim() != state.unit?.addressEn?.trim()) {
      unit.addressEn = addressEnController.text.tr();
    }
    if (addressArController.text.trim() != state.unit?.addressAr?.trim()) {
      unit.addressAr = addressArController.text.trim();
    }
    if (defaultPriceController.text.trim() != state.unit?.defaultPrice?.trim()) {
      unit.defaultPrice = defaultPriceController.text.trim();
    }
    if (state.isPublished != (state.unit?.isVisible == 0 ? false : true)) {
      unit.isVisible = state.isPublished ? 1 : 0;
    }
    if (state.isOnlyFamilies != (state.unit?.isFamiliesOnly == 0 ? false : true)) {
      unit.isFamiliesOnly = state.isOnlyFamilies ? 1 : 0;
    }
    if (isMediaChanged()) {
      unit.imagesIds = state.files?.map((e) => e.id!).toList();
    }
    return unit;
  }

  bool isMediaChanged() {
    if (state.unit?.imagesIds?.length != state.files?.length) {
      return true;
    }
    bool isContentChanged = false;
    state.unit?.imagesIds?.asMap().forEach((key, value) {
      isContentChanged = value != state.files?.elementAt(key).id;
    });
    return isContentChanged;
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

  FutureOr<void> _chaneIsOnlyFamiliesState(ChangeIsOnlyFamiliesEvent event, Emitter<EditUnitSecondState> emit) {
    emit(state.copyWith(isOnlyFamilies: !state.isOnlyFamilies));
  }
}