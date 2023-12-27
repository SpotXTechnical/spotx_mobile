import 'dart:typed_data';

class MediaFile {
  String? fileType;
  String? path;
  MediaFile({this.fileType, this.status, this.thumbnail, this.id, this.path, this.thumbnailString, this.netWorkUrl});
  String? status;
  Uint8List? thumbnail;
  String? thumbnailString;
  int? id;
  String? netWorkUrl;

  static List<MediaFile> createNewFilesList(List<MediaFile>? files) {
    List<MediaFile> newFilesList = List.empty(growable: true);
    files?.forEach((element) {
      newFilesList.add(MediaFile(
          fileType: element.fileType,
          status: element.status,
          thumbnail: element.thumbnail,
          id: element.id,
          path: element.path,
          thumbnailString: element.thumbnailString,
          netWorkUrl: element.netWorkUrl));
    });
    return newFilesList;
  }
}

const imageType = "image";
const videoType = "video";

const uploadingSuccessStatus = "uploadingSuccessStatus";
const uploadingLoadingStatus = "uploadingLoadingStatus";
const uploadingFailedStatus = "uploadingFailedStatus";
const deletingFailedStatus = "deletingFailedStatus";
