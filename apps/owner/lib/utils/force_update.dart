//Show Dialog to force user to update
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:owner/utils/extensions/extensions.dart';

bool updateVersionShown = false;

void showVersionDialog() async {
  if(updateVersionShown) return;
  updateVersionShown = true;
  BuildContext context = navigationKey.currentContext!;
  context.showNormalAlert(
    isDismissible: false,
    title: 'New Update Available',
    body: 'There is a newer version of app available please update it now.',
    buttonTitle: 'Update Now',
    onPressed: () async{
      if(Platform.isIOS){
        _launchURL(appStoreUrl);
      } else {
        _launchURL(playStoreUrl);
      }
    },
  );
}

_launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

const appStoreUrl = 'https://apps.apple.com/app/bars/id6444708326';

const playStoreUrl = 'https://play.google.com/store/apps/details?id=com.spotx.owner';

const huaweiStoreUrl = 'https://appgallery.huawei.com/#/app/C104307553';