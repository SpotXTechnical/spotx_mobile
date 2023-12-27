import 'dart:io';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/media_picker_manager.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

class RegisterPersonalImage extends StatelessWidget {
  const RegisterPersonalImage({
    Key? key,
    this.imageFile,
    required this.addSingleImage,
  }) : super(key: key);
  final File? imageFile;
  final Function(MediaFile) addSingleImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 13),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.uploadPersonalImage.tr(),
            style: circularMedium(color: Theme.of(context).hintColor, fontSize: 14),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            child: Container(
              height: 85,
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  SizedBox(
                      width: 85,
                      height: 85,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: imageFile == null
                              ? const ErrorCard()
                              : FadeInImage(
                                      placeholder: const AssetImage(placeHolder),
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(imageFile!.path),
                                      )
                          )
                      )
                  ),
                  Container(
                    height: 85,
                    width: 85,
                    alignment: Alignment.bottomRight,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500), color: Theme.of(context).dividerColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(cameraIconPath, color: kWhite),
                        )),
                  )
                ],
              ),
            ),
            onTap: () {
              MediaPickerManager.showImageSource(
                  context: context,
                  addFiles: (images) {
                    if (images.isNotEmpty) {
                      addSingleImage(images[0]);
                    }
                  },
                  resourceType: ResourceType.singleImage,
                  imagesCount: 0);
            },
          ),
        ],
      ),
    );
  }
}