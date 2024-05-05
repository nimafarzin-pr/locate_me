// // ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:locate_me/core/resources/icons.dart';
// import 'package:locate_me/core/widget/loading.dart';

// import 'package:locate_me/features/home/model/place_item_model.dart';
// import 'package:locate_me/features/map/view_model/marker_controller.dart';

// class MapView extends StatefulWidget {
//   final List<Place> locations;
//   final bool polyLineFromPoint;
//   final bool enableLocationIcon;
//   final Completer<GoogleMapController> controller;
//   final Function()? onMarkerTap;
//   final void Function(LatLng)? onMapTap;
//   final void Function()? onGoToPosition;
//   final Function(GoogleMapController)? onMapCreated;
//   final Function(LatLng location)? onLocationChange;

//   const MapView({
//     super.key,
//     required this.locations,
//     this.polyLineFromPoint = false,
//     this.enableLocationIcon = false,
//     required this.controller,
//     this.onMarkerTap,
//     this.onMapTap,
//     this.onGoToPosition,
//     required this.onMapCreated,
//     this.onLocationChange,
//   });

//   @override
//   State<MapView> createState() => _MapViewState();
// }

// class _MapViewState extends State<MapView> {
//   late Set<Marker> markers = {};
//   late Set<Polyline> polylineData = {};

//   @override
//   void initState() {
//     // _setMarkers();
//     super.initState();
//   }



//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
