import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/media_picker_manager.dart';
import 'package:owner/utils/style/theme.dart';

class ShowResourceTypeBottomSheet {
  Future<ImageSource?> showImageSource(BuildContext context, Function(List<MediaFile>)? addMultiple, int imagesCount, int videosCount) async {
    showIOSBottomSheet(context, addMultiple, imagesCount, videosCount);
  }

  void showIOSBottomSheet(BuildContext context, Function(List<MediaFile>)? addMultiple, int imagesCount, int videosCount) {
    showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (imagesCount < 10) {
                        MediaPickerManager.showImageSource(
                            context: context,
                            addFiles: addMultiple,
                            resourceType: ResourceType.multiImage,
                            imagesCount: imagesCount
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: LocaleKeys.youCannotUploadMoreThan10Images.tr(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: kWhite);
                      }
                    },
                    child: Text(LocaleKeys.image.tr())),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (videosCount < 1) {
                        MediaPickerManager.showImageSource(
                            context: context, addFiles: addMultiple, resourceType: ResourceType.video, imagesCount: imagesCount);
                      } else {
                        Fluttertoast.showToast(
                            msg: LocaleKeys.youCannotUploadMoreThanOneVideo.tr(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: kWhite);
                      }
                    },
                    child: Text(LocaleKeys.video.tr()))
              ],
            ));
  }

  void showAndroidBottomSheet(BuildContext context, Function(MediaFile file)? addSingle, Function(List<MediaFile>)? addMultiple) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.image),
                  title: Text(
                    "Image",
                    style: TextStyle(color: kWhite),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    // MediaPickerManager.showImageSource(
                    //     context: context, addMultiple: addMultiple, resourceType: ResourceType.multiImage);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text("Video", style: TextStyle(color: kWhite)),
                  onTap: () {
                    Navigator.of(context).pop();
                    // MediaPickerManager.showImageSource(
                    //     context: context, addSingle: addSingle, resourceType: ResourceType.video);
                  },
                )
              ],
            ));
  }
}