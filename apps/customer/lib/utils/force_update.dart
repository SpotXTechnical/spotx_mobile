//Show Dialog to force user to update
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spotx/utils/extensions/extensions.dart';

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
        _launchURL(APP_STORE_URL);
      } else {
        if(await isHuaweiDevice()) {
          _launchURL(HUAWEI_STORE_URL);
        } else {
          _launchURL(PLAY_STORE_URL);
        }
      }
    },
  );
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// todo update app url after uploading to store
const APP_STORE_URL = 'https://apps.apple.com/app/bars/id6444921625';

//https://apps.apple.com/ph/app/omniful-inventory/id1548141152
//https://apps.apple.com/app/bars/id1548141152

const PLAY_STORE_URL = 'https://play.google.com/store/apps/details?id=com.spotx.customer';

const HUAWEI_STORE_URL = 'https://appgallery.huawei.com/#/app/C6444921625';