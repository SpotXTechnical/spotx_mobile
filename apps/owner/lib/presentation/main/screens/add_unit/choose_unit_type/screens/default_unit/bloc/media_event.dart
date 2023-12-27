import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';

abstract class MediaEvent extends Equatable {
  const MediaEvent();
}

class HideError extends MediaEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class UploadMediaEvent extends MediaEvent {
  final List<MediaFile>? files;
  const UploadMediaEvent(this.files);
  @override
  List<Object?> get props => [files];
}

class DeleteMediaEvent extends MediaEvent {
  final MediaFile mediaFile;
  const DeleteMediaEvent(this.mediaFile);
  @override
  List<Object?> get props => [mediaFile];
}

class FreeFilesListEvent extends MediaEvent {
  const FreeFilesListEvent();
  @override
  List<Object?> get props => [];
}
