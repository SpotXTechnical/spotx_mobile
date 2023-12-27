import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:owner/data/local/MediaIPagerEntity.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/image_entity.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/presentation/common/media_pager/media_pager_screen.dart';
import 'package:owner/utils/date_utils/date_formats.dart';
import 'package:owner/utils/extensions/string_extensions.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';

List<Widget> createImageList(List<ImageEntity> images) {
  List<Widget> widgets = List.empty(growable: true);
  for (var element in images) {
    switch (element.type) {
      case imageType:
        widgets.add(GestureDetector(
          onTap: () {
            navigationKey.currentState?.pushNamed(MediaPagerScreen.tag, arguments: MediaPagerEntity(images, element));
          },
          child: Image.network(
            element.url.replaceHttps(),
            fit: BoxFit.cover,
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
                child: Image.file(
                  File(element.thumbnail ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
              const Center(
                  child: Icon(
                CupertinoIcons.play_circle_fill,
                size: 50,
              ))
            ],
          ),
        ));
        break;
    }
  }
  return widgets;
}

Reservation? findReservationByDay(
  DateTime day,
  List<Reservation> reservations,
) {

  for (var reservation in reservations) {

    if (day.isAtSameMomentAs(reservation.from ?? defaultDateTime) ||
        day.isAtSameMomentAs(reservation.to ?? defaultDateTime) ||
        (day.isAfter(reservation.from ?? defaultDateTime) &&
            day.isBefore(reservation.to ?? defaultDateTime))) {
      return reservation;
    }
  }
  return null; // If no reservation found for the given day, return null
}