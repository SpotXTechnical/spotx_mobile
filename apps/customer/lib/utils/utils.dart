import 'package:device_info/device_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spotx/data/local/shared_prefs_manager.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/auth/login/login_screen.dart';
import 'package:spotx/utils/extensions/build_context_extensions.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> isHuaweiDevice() async {
  GooglePlayServicesAvailability availability =
      await GoogleApiAvailability.instance.checkGooglePlayServicesAvailability();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.manufacturer == "HUAWEI" &&
      (availability == GooglePlayServicesAvailability.serviceInvalid ||
          availability == GooglePlayServicesAvailability.serviceMissing);
}

bool get isArabic => Localizations.localeOf(navigationKey.currentContext!).languageCode == 'ar';

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
          navigationKey.currentState?.pushNamed(LoginScreen.tag, arguments: true);
        }
      },
      onCancel: () {
        onCancel?.call();
      });
}

const List months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

String calculateTimeDifferenceFromNow(DateTime date) {
  var duration = DateTime.now().difference(date);
  if (duration.inSeconds >= 60) {
    if (duration.inMinutes >= 60) {
      if (duration.inHours >= 24) {
        if (duration.inDays >= 30) {
          if (duration.inDays >= 365) {
            var years = duration.inDays ~/ 365;
            var text = "";
            if (years == 1) {
              text = LocaleKeys.year.tr();
            } else {
              text = LocaleKeys.years.tr();
            }
            return "$years $text ${LocaleKeys.ago.tr()}";
          } else {
            var months = duration.inDays ~/ 30.417;
            var text = "";
            if (months == 1) {
              text = LocaleKeys.month.tr();
            } else {
              text = LocaleKeys.months.tr();
            }
            return "$months $text ${LocaleKeys.ago.tr()}";
          }
        } else {
          var days = duration.inDays;
          var text = "";
          if (days == 1) {
            text = LocaleKeys.day.tr();
          } else {
            text = LocaleKeys.days.tr();
          }
          return "$days $text ${LocaleKeys.ago.tr()}";
        }
      } else {
        var hours = duration.inHours;
        var text = "";
        if (hours == 1) {
          text = LocaleKeys.hour.tr();
        } else {
          text = LocaleKeys.hours.tr();
        }
        return "$hours $text ${LocaleKeys.ago.tr()}";
      }
    } else {
      var minutes = duration.inMinutes;
      var text = "";
      if (minutes == 1) {
        text = LocaleKeys.minute.tr();
      } else {
        text = LocaleKeys.minutes.tr();
      }
      return "$minutes $text ${LocaleKeys.ago.tr()}";
    }
  } else {
    var seconds = duration.inSeconds;
    var text = "";
    if (seconds == 1) {
      text = LocaleKeys.second.tr();
    } else if (seconds == 0) {
      return LocaleKeys.justNow.tr();
    } else {
      text = LocaleKeys.seconds.tr();
    }
    return "$seconds $text ${LocaleKeys.ago.tr()}";
  }
}

String getConcatenatedRegionAndSubRegion({String? regionName, String? subRegionName}) {
  if (regionName == null && subRegionName == null) {
    return "";
  }
  if (subRegionName == null) {
    return regionName!;
  }
  return "$regionName/$subRegionName";
}

String checkPhoneNumber(String phone) {
  if (phone.startsWith("+2")) {
    return phone;
  } else {
    return "+2$phone";
  }
}

void showExitWarningDialog({required BuildContext context}) {
  context.showConfirmationAlert(
    title: LocaleKeys.warning.tr(),
    body: LocaleKeys.thereAreSomeChangesThatWillBeDiscardedMessage.tr(),
    confirmButtonTitle: LocaleKeys.discard.tr(),
    cancelButtonTitle: LocaleKeys.cancel.tr(),
    onConfirm: () {
      navigationKey.currentState?.pop();
    },
  );
}

TimeOfDay parseTime(String? time) {
  if (time != null) {
    return TimeOfDay(hour: int.parse(time.split(":")[0]), minute: int.parse(time.split(":")[1]));
  } else {
    return TimeOfDay.now();
  }
}

launchURLInAppBrowser(String url) async {
  Uri uri = Uri.parse(url);
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch(e) {
    throw 'Could not launch $url';
  }
}

showErrorMessage({required String message, Toast? toastLength = Toast.LENGTH_LONG}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: pacificBlue,
      textColor: kWhite
  );
}

bool isStartByCountryCode(String value) {
  return value.length == 13 && value.startsWith("+2");
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
        backgroundColor: Colors.red,
        textColor: kWhite);
  } else {
    Fluttertoast.showToast(
        msg: LocaleKeys.error.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).primaryColorLight,
        textColor: kWhite);
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
        backgroundColor: Theme.of(context).primaryColorLight,
        textColor: kWhite);
  }
}