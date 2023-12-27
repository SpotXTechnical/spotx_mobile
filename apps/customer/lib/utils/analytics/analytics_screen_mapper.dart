import 'package:flutter/material.dart';

String analyticsScreenMapper(RouteSettings settings){
  switch(settings.name){

    /*case SplashWidget.tag:
    return splashScreen;

    case LoginWidget.tag:
    return loginScreen;

    case HomeWidget.tag:
    return homeScreen;

    case DispatchOrderScreen.tag:
    return dispatcherOrderDetailsScreen;

    case CreateShipmentScreen.tag:
    return createShipmentScreen;

    case ShipmentCreatedScreen.tag:
    return shipmentCreatedScreen;

    case ResetPasswordWidget.tag:
    return resetPasswordScreen;

    case ScanCartWidget.tag:
    return scanCartScreen;

    case PickingWidget.tag:
    return pickingScreen;

    case ProductDetailsWidget.tag:
    return productDetailsScreen;

    case ScanItemWidget.tag:
    return scanItemScreen;

    case ScanPinWidget.tag:
    return scanPinScreen;

    case WrongItem.tag:
    return wrongItem;

    case SettingsScreen.tag:
    return settingsScreen;*/

    default:
    return settings.name??'';
  }
}