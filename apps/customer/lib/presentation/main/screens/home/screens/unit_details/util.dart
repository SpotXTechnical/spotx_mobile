import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotx/data/local/MediaIPagerEntity.dart';
import 'package:spotx/data/remote/unit/model/CalenderUnit.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/presentation/common/media_pager/media_pager_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/calender_screen.dart';
import 'package:spotx/utils/date_formats.dart';
import 'package:spotx/utils/extensions/string_extensions.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';

List<Widget> createImageList(List<ImageEntity> images) {
  List<Widget> widgets = List.empty(growable: true);
  for (var element in images) {
    debugPrint("element.type ${element.type}");
    switch (element.type) {
      case imageType:
        widgets.add(GestureDetector(
            onTap: () {
              navigationKey.currentState?.pushNamed(MediaPagerScreen.tag, arguments: MediaPagerEntity(images, element));
            },
            child: FadeInImage(
              image: CachedNetworkImageProvider(element.url.replaceHttps()),
              fit: BoxFit.cover,
              placeholder: const AssetImage(placeHolder),
          ),
        ));
        break;
      case videoType:
        widgets.add(GestureDetector(
          onTap: () {
            navigationKey.currentState?.pushNamed(MediaPagerScreen.tag, arguments: MediaPagerEntity(images, element));
          },
          child: Stack(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: FadeInImage(
                    image: FileImage(File(element.thumbnail!)),
                    placeholder: const AssetImage(placeHolder),
                    fit: BoxFit.cover,
                  )),
              const Center(
                  child: Icon(
                CupertinoIcons.play_circle_fill,
                size: 50,
              ))
            ],
          ),
        ));
        break;

      default:
        {
          widgets.add(GestureDetector(
              onTap: () {
                navigationKey.currentState
                    ?.pushNamed(MediaPagerScreen.tag, arguments: MediaPagerEntity(images, element));
              },
              child: FadeInImage(
                image: CachedNetworkImageProvider(element.url.replaceHttps()),
                placeholder: const AssetImage(placeHolder),
                fit: BoxFit.cover,
              )));
        }
        break;
    }
  }
  return widgets;
}

void navigateToCalender(Unit unit) {
  navigationKey.currentState?.pushNamed(CalenderScreen.tag,
      arguments: CalenderUnit(
          unit.id!,
          unit.defaultPrice!,
          unit.type!,
          unit.activeRanges,
          adjustReservationDays(unit.activeReservations ?? []),
          unit.rooms,
          "",
          unit: unit));
}


List<ActiveReservation> adjustReservationDays(
  List<ActiveReservation> reservations,
) {
  final originalList = List<ActiveReservation>.from(
    reservations.map(
      (res) => res.copyWith(startDay: res.startDay, endDay: res.endDay),
    ),
  );
  // originalList.removeWhere(
  //   (reservation) =>
  //       reservation.startDay?.day == (reservation.endDay?.day ?? 0) - 1 &&
  //       reservation.endDay?.month == reservation.startDay?.month &&
  //       reservation.endDay?.year == reservation.startDay?.year,
  // );
  final originalListToCompare = List<ActiveReservation>.from(
    originalList.map(
      (res) => res.copyWith(startDay: res.startDay, endDay: res.endDay),
    ),
  );
  for (var reservation in originalList) {
    /*final isSharedDay = originalListToCompare.firstWhereOrNull(
        (ActiveReservation res) =>
            res.endDay?.compareTo(reservation.startDay ?? defaultDateTime) ==
            0);*/
    /*if (isSharedDay == null) {
      reservation.startDay = reservation.startDay?.add(const Duration(days: 1));
    }*/
    reservation.endDay = reservation.endDay?.subtract(const Duration(days: 1));
  }

  return originalList;
}