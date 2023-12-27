import 'dart:io';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/media_picker_manager.dart';
import 'package:owner/utils/style/theme.dart';

class RegisterNationalIdImage extends StatelessWidget {
  const RegisterNationalIdImage({
    Key? key,
    this.nationalIdImageFile,
    required this.addSingleImage,
    required this.removeImage,
  }) : super(key: key);

  final File? nationalIdImageFile;
  final Function(MediaFile) addSingleImage;
  final Function removeImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsetsDirectional.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.uploadNationalIdPhoto.tr(),
            style: circularMedium(color: Theme.of(context).hintColor, fontSize: 14),
          ),
          const SizedBox(
            height: 12,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                    child: Container(
                        width: 72,
                        height: 72,
                        decoration:
                            BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(8.5))),
                        child: Image.asset(addImageIconPath, color: kWhite)
                    ),
                    onTap: () {
                      MediaPickerManager.showImageSource(
                          context: context,
                          addFiles: (files) {
                            if (files != null && files.isNotEmpty) {
                              addSingleImage(files[0]);
                            }
                          },
                          resourceType: ResourceType.singleImage,
                          imagesCount: 0
                      );
                    }
                ),
                if(nationalIdImageFile != null )Container(
                    margin: const EdgeInsetsDirectional.only(start: 10),
                    width: 72,
                    height: 72,
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Image.file(File(nationalIdImageFile!.path), fit: BoxFit.cover, width: 72,)
                        ),
                        Transform.translate(
                          offset: const Offset(10, -10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                removeImage.call();
                              },
                              child: const Icon(Icons.clear,),
                            )
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}