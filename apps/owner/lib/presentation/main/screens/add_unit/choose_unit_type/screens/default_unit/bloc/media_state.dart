import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';

class MediaState extends Equatable {
  const MediaState({this.files, this.deletedFilesIds});
  final List<MediaFile>? files;
  final Set<int>? deletedFilesIds;

  @override
  List<Object?> get props => [files, deletedFilesIds];

  MediaState copyWith({List<MediaFile>? files, Set<int>? deletedFilesIds}) {
    return MediaState(files: files ?? this.files, deletedFilesIds: deletedFilesIds ?? this.deletedFilesIds);
  }
}

class MediaFilesState extends MediaState {
  const MediaFilesState(List<MediaFile>? files) : super(files: files);
}
