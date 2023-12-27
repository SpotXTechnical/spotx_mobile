import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/data/local/shared_prefs_manager.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/auth/login/login_screen.dart';
import 'package:owner/presentation/auth/register/register_screen.dart';
import 'package:owner/utils/extensions/build_context_extensions.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:url_launcher/url_launcher.dart';

bool get isArabic => Localizations.localeOf(navigationKey.currentContext!).languageCode == 'ar';


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

void checkIfUserIsLoggedInBefore(BuildContext context, Function authorizedAction) async {
  if (await isLoggedInBefore()) {
    authorizedAction.call();
  } else {
    showAuthorizationDialog(context: context);
  }
}

void showAuthorizationDialog({required BuildContext context, Function? onCancel, Function? onConfirm}) {
  context.showConfirmationAlert(
      title: LocaleKeys.unAuthorized.tr(),
      body: LocaleKeys.itIsRequiredToLoginToPerformTheNextAction.tr(),
      confirmButtonTitle: LocaleKeys.login.tr(),
      cancelButtonTitle: LocaleKeys.cancel.tr(),
      onConfirm: () {
        if (onConfirm != null) {
          onConfirm.call();
        } else {
          navigationKey.currentState?.pushNamed(LoginScreen.tag);
        }
      },
      onCancel: () {
        onCancel?.call();
      });
}

void showMultiSelectDialog({required BuildContext context, required Map<String, VoidCallback> actions}) {
  context.showMultiSelectDialog(
      title: LocaleKeys.multiSelection.tr(), body: LocaleKeys.multiSelectionMessage.tr(), actions: actions);
}

void showConfirmationEditingDialog({required BuildContext context, Function? onCancel, Function? onConfirm}) {
  context.showConfirmationAlert(
      title: LocaleKeys.warning.tr(),
      body: LocaleKeys.areYouSureThatYouWantToEditUnit.tr(),
      confirmButtonTitle: LocaleKeys.yes.tr(),
      cancelButtonTitle: LocaleKeys.cancel.tr(),
      onConfirm: () {
        if (onConfirm != null) {
          onConfirm.call();
        } else {
          navigationKey.currentState?.pushNamed(LoginScreen.tag);
        }
      },
      onCancel: () {
        onCancel?.call();
      });
}

void showExitWarningDialog({required BuildContext context}) {
  context.showConfirmationAlert(
    title: LocaleKeys.warning.tr(),
    body: LocaleKeys.areYouSureMessageChangesDiscarded.tr(),
    confirmButtonTitle: LocaleKeys.discard.tr(),
    cancelButtonTitle: LocaleKeys.cancel.tr(),
    onConfirm: () {
      navigationKey.currentState?.pop();
    },
  );
}

void showDeleteWarningDialog({required BuildContext context, required Function onConfirm}) {
  context.showConfirmationAlert(
    title: LocaleKeys.warning.tr(),
    body: LocaleKeys.areYouSureDeleteMessage.tr(),
    confirmButtonTitle: LocaleKeys.yes.tr(),
    cancelButtonTitle: LocaleKeys.cancel.tr(),
    onConfirm: () {
      onConfirm.call();
    },
  );
}

int getFileCount(String fileType, List<MediaFile>? files) {
  if (files == null) {
    return 0;
  }
  int filesCount = 0;
  if (fileType == imageType) {
    filesCount = files.where((element) => element.fileType == imageType).length;
  } else {
    filesCount = files.where((element) => element.fileType == videoType).length;
  }

  return filesCount;
}

TimeOfDay parseTime(String? time) {
  if (time != null) {
    return TimeOfDay(hour: int.parse(time.split(":")[0]), minute: int.parse(time.split(":")[1]));
  } else {
    return TimeOfDay.now();
  }
}

String timeToString(TimeOfDay time) {
  return "${time.hour}:${time.minute}:00";
}

String? removeLeadingZeros(String? price) {
  String? withoutLeadingZeroPrice;
  bool isLeading = true;
  if (price != null) {
    withoutLeadingZeroPrice = "";
    for (var element in price.runes) {
      var character = String.fromCharCode(element);
      if (isLeading) {
        if (character != '0') {
          isLeading = false;
          withoutLeadingZeroPrice = withoutLeadingZeroPrice! + character;
        }
      } else {
        withoutLeadingZeroPrice = withoutLeadingZeroPrice! + character;
      }
    }
  }
  return withoutLeadingZeroPrice;
}

launchURLInAppBrowser(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.inAppWebView);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> messageOwner(String? phone, BuildContext context) async {
  if (phone != null) {
    final correctPhoneNumber = isStartByCountryCode(phone) ? phone : "+2$phone";
    final whatsAppUrl = "whatsapp://send?phone=$correctPhoneNumber";
    await canLaunchUrl(Uri.parse(whatsAppUrl))
        ? launchUrl(Uri.parse(whatsAppUrl))
        : Fluttertoast.showToast(
            msg: LocaleKeys.whatsAppIsNotInstalledMessage.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: kWhite,
          );
  } else {
    Fluttertoast.showToast(
      msg: LocaleKeys.error.tr(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Theme.of(context).primaryColorLight,
      textColor: kWhite,
    );
  }
}

Future<void> callOwner(String? phone, BuildContext context) async {
  if (phone != null) {
    launchUrl(Uri.parse("tel://$phone"));
  } else {
    Fluttertoast.showToast(
        msg: LocaleKeys.error.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColorLight,
        textColor: kWhite);
  }
}