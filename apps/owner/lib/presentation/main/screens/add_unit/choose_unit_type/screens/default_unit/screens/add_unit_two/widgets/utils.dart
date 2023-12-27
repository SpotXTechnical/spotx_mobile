import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

List<Widget> createListOfImages(List<MediaFile>? files, Function(MediaFile) deleteImageEvent,
    Function(MediaFile) retryEvent, BuildContext context) {
  List<Widget> widgetList = List.empty(growable: true);
  files?.forEach((element) {
    widgetList.add(Container(
        margin: const EdgeInsetsDirectional.only(start: 10),
        width: 72,
        height: 72,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.5)),
                  child: element.fileType == imageType
                      ? element.path!.startsWith("http")
                          ? Image.network(
                              element.path!,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(element.path!),
                              fit: BoxFit.cover,
                            )
                      : element.thumbnail != null // local video
                          ? Image.memory(
                              element.thumbnail!,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              // network vidoe url
                              File(element.thumbnailString!),
                              fit: BoxFit.cover,
                            ),
                ),
                GestureDetector(
                  child: Container(
                      color: Colors.transparent,
                      width: 72,
                      height: 72,
                      alignment: Alignment.topRight,
                      child: Image.asset(closeImageIconPath, color: kWhite)),
                  onTap: () {
                    if (element.status != uploadingLoadingStatus) {
                      deleteImageEvent.call(element);
                    }
                  },
                )
              ],
            ),
            element.status == uploadingLoadingStatus
                ? Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      color: const Color.fromRGBO(0, 0, 0, 0.3),
                      child: const LoadingWidget(
                        strokeWith: 3.0,
                      ),
                    ),
                  )
                : Container(),
            element.status == uploadingFailedStatus
                ? Center(
                    child: GestureDetector(
                      child: Container(
                        width: 72,
                        height: 72,
                        child: Center(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: kWhite, borderRadius: BorderRadius.all(Radius.circular(5))),
                            width: 25,
                            height: 25,
                            child: Image.asset(reUploadIconPath, color: kWhite),
                          ),
                        ),
                      ),
                      onTap: () {
                        retryEvent.call(element);
                      },
                    ),
                  )
                : Container()
          ],
        )));
  });
  return widgetList;
}

Future<Uint8List?> getVideoThumbnailFromLocalPath(MediaFile image) async {
  Uint8List? thumbnail = await VideoThumbnail.thumbnailData(
    video: image.path!,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 128,
    // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
    quality: 25,
  );
  return thumbnail;
}

Future<String?> getVideoThumbnailFromNetwork(videoUrl) async {
  final fileName = await VideoThumbnail.thumbnailFile(
    video: videoUrl,
    thumbnailPath: (await getApplicationDocumentsDirectory()).path,
    imageFormat: ImageFormat.WEBP,
    maxHeight: 64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
    quality: 75,
  );
  return fileName;
}

bool assertAllImagesAreUploaded(List<MediaFile> files) {
  for (var element in files) {
    if (element.id == null) {
      return true;
    }
  }
  return false;
}