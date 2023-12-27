import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({
    Key? key,
    required this.lat,
    required this.lng,
  }) : super(key: key);
  final double lat;
  final double lng;

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor? customIcon;

  @override
  initState() {
    MarkerId markerId = const MarkerId("1");
    markers[markerId] = Marker(
        markerId: markerId,
        position: LatLng(widget.lat, widget.lng),
        icon: customIcon ?? BitmapDescriptor.defaultMarker);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition kGooglePlex = CameraPosition(
      // target: LatLng(widget.lat, widget.lng),
      target: LatLng(widget.lat, widget.lng),
      zoom: 14.4746,
    );
    return GoogleMap(
      mapType: MapType.hybrid,
      markers: Set<Marker>.of(markers.values),
      initialCameraPosition: kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      zoomGesturesEnabled: false,
      scrollGesturesEnabled: false,
      tiltGesturesEnabled: false,
      rotateGesturesEnabled: false,
      zoomControlsEnabled: false,
    );
  }
}