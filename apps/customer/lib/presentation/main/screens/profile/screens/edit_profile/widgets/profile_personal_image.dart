import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';

import '../../../../../../../utils/media_picker_manager.dart';

class ProfilePersonalImage extends StatelessWidget {
  const ProfilePersonalImage({
    Key? key,
    this.imageFile,
    required this.addSingleImage,
    this.networkImage,
  }) : super(key: key);
  final File? imageFile;
  final Function(File) addSingleImage;
  final String? networkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 13),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        child: imageFile == null && networkImage == null
                            ? const ErrorCard()
                            : imageFile == null
                                ? Image.network(
                                    networkImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(File(imageFile!.path), fit: BoxFit.cover)),
                  ),
                  Container(
                    height: 85,
                    width: 85,
                    alignment: Alignment.bottomRight,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500), color: Theme.of(context).scaffoldBackgroundColor),
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
                addMedia: (image) {
                  addSingleImage(image);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}