import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/region/i_region_repository.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_thrid/add_camp_third_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/utils.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_second_screen/bloc/edit_unit_second_state.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/utils.dart';
import 'add_camp_second_event.dart';
import 'add_camp_second_state.dart';

class AddCampSecondBloc extends BaseBloc<AddCampSecondEvent, AddCampSecondState> {
  AddCampSecondBloc(this.regionsRepository, this.unitRepository) : super(AddCampSecondEmptyState()) {
    on<AddCheckInTime>(_addCheckInTime);
    on<AddCheckOutTime>(_addCheckOutTime);
    on<GetRegionsWithSubRegion>(_getRegions);
    on<AddCampSecondSetRegion>(_setRegion);
    on<AddCampSecondSetSubRegion>(_setSubRegion);
    on<MoveToFourthScreenEvent>(_moveToFourthScreen);
    on<AddCampSecondScreenAddFilesToListEvent>(_addFilesToFilesList);
    on<DeleteImageLocallyEvent>(_deleteImage);
    on<LoadingMediaEvent>(_loadingMediaEvent);
    on<ChangeIsPublishedEvent>(_changeIsPublishedState);
    on<AddCampSecondGetRegionById>(_getRegionById);
  }

  final IRegionRepository regionsRepository;
  final IUnitRepository unitRepository;

  static final formKey = GlobalKey<FormState>();

  final FocusNode checkInTimeFocus = FocusNode();
  final FocusNode checkOutTimeFocus = FocusNode();
  final TextEditingController checkInTimeController = TextEditingController();
  final TextEditingController checkOutTimeController = TextEditingController();
  final TextEditingController subRegionController = TextEditingController();
  final TextEditingController regionController = TextEditingController();

  _changeIsPublishedState(ChangeIsPublishedEvent event, Emitter<AddCampSecondState> emit) {
    emit(state.copyWith(isPublished: !state.isPublished));
  }

  _addCheckInTime(AddCheckInTime event, Emitter<AddCampSecondState> emit) {
    emit(state.copyWith(checkIn: event.checkInTime));
    checkInTimeController.text = event.checkInString;
  }

  _addCheckOutTime(AddCheckOutTime event, Emitter<AddCampSecondState> emit) {
    emit(state.copyWith(checkOut: event.checkOutTime));
    checkOutTimeController.text = event.checkOutString;
  }

  _setRegion(AddCampSecondSetRegion event, Emitter<AddCampSecondState> emit) {
    List<Region>? subRegions = event.region.subRegions;
    regionController.text = event.region.name ?? "";
    subRegionController.text = "";
    emit(state.copyWith(
      selectedRegion: event.region,
      subRegions: subRegions,
    )..selectedSubRegion = null);
  }

  _setSubRegion(AddCampSecondSetSubRegion event, Emitter<AddCampSecondState> emit) {
    subRegionController.text = event.selectedSubRegion.name ?? "";
    emit(state.copyWith(selectedSubRegion: event.selectedSubRegion));
  }

  FutureOr<void> _getRegions(GetRegionsWithSubRegion event, Emitter<AddCampSecondState> emit) async {
    ApiResponse apiResponse = await regionsRepository.getRegions(withSubRegion);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> regions = apiResponse.data.data;
            emit(state.copyWith(regions: regions, isSubRegionsLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isGetRegionsAndSubRegionsApiError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _getRegionById(AddCampSecondGetRegionById event, Emitter<AddCampSecondState> emit) async {
    emit(state.copyWith(isSubRegionsLoading: true));
    ApiResponse apiResponse = await regionsRepository.getRegionById(int.parse(event.regionId));

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Region subregion = apiResponse.data.data;
            subRegionController.text = subregion.name ?? "";
            emit(state.copyWith(isSubRegionsLoading: false, selectedSubRegion: subregion));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isGetRegionsAndSubRegionsApiError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
          }
        });
  }

  _moveToFourthScreen(MoveToFourthScreenEvent event, Emitter<AddCampSecondState> emit) {
    if (state.files == null || state.files!.isEmpty || assertAllImagesAreUploaded(state.files!)) {
      emit(state.copyWith(imageError: getImageErrorMessage()));
    } else {
      emit(state.copyWith(imageError: ImageError("", isError: false)));
      event.unit.checkIn = timeToString(state.checkIn!);
      event.unit.checkOut = timeToString(state.checkOut!);
      event.unit.imagesIds = state.files?.map((e) => e.id!).toList();
      event.unit.isVisible = state.isPublished ? 1 : 0;
      event.unit.regionId = (state.selectedSubRegion != null)
          ? state.selectedSubRegion?.id.toString()
          : state.selectedRegion?.id.toString();
      navigationKey.currentState?.pushNamed(AddCampThirdScreen.tag, arguments: event.unit);
    }
  }

  _deleteImage(DeleteImageLocallyEvent event, Emitter<AddCampSecondState> emit) {
    List<MediaFile> newFilesList = MediaFile.createNewFilesList(state.files);
    MediaFile? deletedElement;
    deletedElement = newFilesList.firstWhere((element) => element.path == event.file.path);
    newFilesList.removeWhere((element) => element.path == deletedElement!.path);
    emit(state.copyWith(files: newFilesList));
  }

  _loadingMediaEvent(LoadingMediaEvent event, Emitter<AddCampSecondState> emit) {
    state.files?.firstWhere((element) => element.path == event.path).status = uploadingLoadingStatus;
    List<MediaFile> newFilesList = MediaFile.createNewFilesList(state.files);
    emit(state.copyWith(files: newFilesList));
  }

  _addFilesToFilesList(AddCampSecondScreenAddFilesToListEvent event, Emitter<AddCampSecondState> emit) async {
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

  ImageError? getImageErrorMessage() {
    if (state.files == null || state.files!.isEmpty) {
      return ImageError(LocaleKeys.validationInsertData.tr());
    }
    if (assertAllImagesAreUploaded(state.files!)) {
      return ImageError(LocaleKeys.waitUploadingImagesMessage.tr());
    }
    return null;
  }
}
