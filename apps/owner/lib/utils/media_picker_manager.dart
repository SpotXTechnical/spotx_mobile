import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/style/theme.dart';

class MediaPickerManager {
  static Future<ImageSource?> showImageSource({
    required BuildContext context,
    Function(List<MediaFile>)? addFiles,
    required ResourceType resourceType,
    required int imagesCount,
  }) async {
    _onImageButtonPressed(source: ImageSource.gallery, resourceType: resourceType, addFiles: addFiles, imageCount: imagesCount);
  }

  static void showIOSBottomSheet(BuildContext context, ResourceType resourceType, Function(List<MediaFile>)? addFiles, int imagesCount) {
    showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      _onImageButtonPressed(source: ImageSource.camera, resourceType: resourceType, addFiles: addFiles, imageCount: imagesCount);
                      Navigator.of(context).pop();
                    },
                    child: Text(LocaleKeys.camera.tr())),
                CupertinoActionSheetAction(
                    onPressed: () {
                      _onImageButtonPressed(source: ImageSource.gallery, resourceType: resourceType, addFiles: addFiles, imageCount: imagesCount);
                      Navigator.of(context).pop();
                    },
                    child: Text(LocaleKeys.gallery.tr()))
              ],
            ));
  }

  static void showAndroidBottomSheet(BuildContext context, ResourceType resourceType, Function(List<MediaFile>)? addMultiple) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: kWhite,
                  ),
                  title: Text(
                    "Camera",
                    style: TextStyle(color: kWhite),
                  ),
                  onTap: () {
                    // _onImageButtonPressed(
                    //     source: ImageSource.camera,
                    //     addSingle: addSingle,
                    //     resourceType: resourceType,
                    //     addMultiple: addMultiple);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image, color: kWhite),
                  title: Text(
                    "Gallery",
                    style: TextStyle(color: kWhite),
                  ),
                  onTap: () {
                    // _onImageButtonPressed(
                    //     source: ImageSource.gallery,
                    //     addSingle: addSingle,
                    //     resourceType: resourceType,
                    //     addMultiple: addMultiple);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  static void _onImageButtonPressed({
    required ImageSource source,
    required ResourceType resourceType,
    Function(List<MediaFile>)? addFiles,
    required int imageCount,
  }) async {
    try {
      switch (resourceType) {
        case ResourceType.multiImage:
          final pickedXFiles = await ImagePicker().pickMultiImage();
          if (pickedXFiles != null) {
            if (pickedXFiles.length + imageCount <= 10) {
              var pickedFiles = List<MediaFile>.empty(growable: true);
              for (var element in pickedXFiles) {
                pickedFiles.add(MediaFile(path: element.path, fileType: imageType, status: uploadingLoadingStatus));
              }
              addFiles!(pickedFiles);
            } else {
              showImageErrorToast();
            }
          }
          break;
        case ResourceType.singleImage:
          final pickedFile = await ImagePicker().pickImage(source: source);
          if (pickedFile != null) {
            addFiles!([MediaFile(path: pickedFile.path, fileType: imageType, status: uploadingLoadingStatus)]);
          }
          break;
        case ResourceType.video:
          final pickedFile = await ImagePicker().pickVideo(source: source);
          if (pickedFile != null) {
            addFiles!([MediaFile(path: pickedFile.path, fileType: videoType, status: uploadingLoadingStatus)]);
          }
          break;
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

  static void showImageErrorToast() {
    Fluttertoast.showToast(
        msg: LocaleKeys.youCannotUploadMoreThan10Images.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: kWhite);
  }
}

enum ResourceType { singleImage, multiImage, video }