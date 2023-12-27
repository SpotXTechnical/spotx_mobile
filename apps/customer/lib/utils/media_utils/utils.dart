import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<File> compressAndGetFile(
  File file,
) async {
  final filePath = file.absolute.path;
  // Create output file path
  // eg:- "Volume/VM/abcd_out.jpeg"
  final lastIndex = filePath.lastIndexOf(".");
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  var result = await FlutterImageCompress.compressAndGetFile(file.absolute.path, outPath,
      quality: 50, format: getFileFormat(file.absolute.path));

  debugPrint("original file:  ${file.lengthSync()}");
  debugPrint("compressed file: ${result?.lengthSync()}");

  if (result != null) {
    return result;
  } else {
    return file;
  }
}

CompressFormat getFileFormat(String path) {
  if (path.endsWith(".jpeg") || path.endsWith(".jpg")) {
    return CompressFormat.jpeg;
  } else if (path.endsWith(".png")) {
    return CompressFormat.png;
  } else if (path.endsWith(".heic")) {
    return CompressFormat.heic;
  }
  return CompressFormat.webp;
}