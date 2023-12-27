import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MediaPickerManager {
  static void showImageSource({
    required BuildContext context,
    Function(File)? addMedia,
  }) async {
    showIOSBottomSheet(context, addMedia);
  }

  static void showIOSBottomSheet(
    BuildContext context,
    Function(File)? addMedia,
  ) {
    showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      _onImageButtonPressed(source: ImageSource.camera, addMedia: addMedia);
                      Navigator.of(context).pop();
                    },
                    child: Text(LocaleKeys.camera.tr())),
                CupertinoActionSheetAction(
                    onPressed: () {
                      _onImageButtonPressed(
                        source: ImageSource.gallery,
                        addMedia: addMedia,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text(LocaleKeys.gallery.tr()))
              ],
            ));
  }

  static void _onImageButtonPressed({
    required ImageSource source,
    Function(File)? addMedia,
  }) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        addMedia?.call(File(pickedFile.path));
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error during select Image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: kWhite);
    }
  }
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