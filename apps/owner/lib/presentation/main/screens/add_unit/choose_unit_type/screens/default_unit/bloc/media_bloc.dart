import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/image_entity.dart';
import 'package:owner/utils/network/api_response.dart';

import 'media_event.dart';
import 'media_state.dart';

class MediaBloc extends BaseBloc<MediaEvent, MediaState> {
  MediaBloc(this.unitRepository) : super(const MediaState()) {
    on<UploadMediaEvent>(_uploadMedia);
    on<FreeFilesListEvent>(_freeList);
    on<DeleteMediaEvent>(_deleteMedia);
  }

  final IUnitRepository unitRepository;
  _uploadMedia(UploadMediaEvent event, Emitter<MediaState> emit) async {
    if (event.files != null) {
      for (var element in event.files!) {
        await uploadFile(element, emit);
      }
    }
  }

  _deleteMedia(DeleteMediaEvent event, Emitter<MediaState> emit) async {
    ApiResponse apiResponse = await unitRepository.deleteMedia(event.mediaFile.id.toString());
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          Set<int> newDeletedFilesIdsList = {};
          state.deletedFilesIds?.forEach((element) {
            newDeletedFilesIdsList.add(element);
          });
          newDeletedFilesIdsList.add(event.mediaFile.id!);
          emit(state.copyWith(deletedFilesIds: newDeletedFilesIdsList));
        },
        onFailed: () {
          Set<int> newDeletedFilesIdsList = {};
          state.deletedFilesIds?.forEach((element) {
            newDeletedFilesIdsList.add(element);
          });
          newDeletedFilesIdsList.add(event.mediaFile.id!);
          emit(state.copyWith(deletedFilesIds: newDeletedFilesIdsList));
        });
  }

  Future<void> uploadFile(MediaFile element, Emitter<MediaState> emit) async {
    ApiResponse apiResponse = await unitRepository.postMedia(element);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          element.status = uploadingSuccessStatus;
          MediaFile newFile = MediaFile(
              fileType: element.fileType,
              status: element.status,
              thumbnail: element.thumbnail,
              id: element.id,
              path: element.path);
          if (newFile.path == element.path) {
            newFile.status = uploadingSuccessStatus;
            ImageEntity imageEntity = apiResponse.data.data;
            newFile.id = imageEntity.id;
            newFile.netWorkUrl = imageEntity.url;
          }

          emit(state.copyWith(files: [newFile]));
        },
        onFailed: () {
          MediaFile newFile = MediaFile(
              fileType: element.fileType, status: element.status, thumbnail: element.thumbnail, id: element.id);
          if (newFile.path == element.path) {
            newFile.status = uploadingFailedStatus;
          }
          emit(state.copyWith(files: [newFile]));
        });
  }

  _freeList(FreeFilesListEvent event, Emitter<MediaState> emit) async {
    emit(state.copyWith(files: List.empty(growable: true)));
  }
}
