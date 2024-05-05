// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/resources/icons.dart';
import 'package:locate_me/core/widget/disabled_location_service_view.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/core/widget/permission_denied_screen.dart';

import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/add/viewmodel/location_provider.dart';
import 'package:locate_me/features/add/viewmodel/location_state.dart';
import 'package:locate_me/features/map/provider/single_marker_provider.dart';

class AddTab extends StatefulWidget {
  const AddTab({super.key});

  @override
  State<AddTab> createState() => _AddTabState();
}

class _AddTabState extends State<AddTab> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Future<void> _goToMyLocation(Position location) async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(location.latitude, location.longitude)));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentPosition = ref.watch(positionProvider);
        log('1111${currentPosition.value}');

        return currentPosition.when(
          data: (latlng) {
            final value = [
              Place(
                  title: latlng!.latitude.toString(),
                  address: latlng.latitude.toString(),
                  distance: latlng.latitude.toString(),
                  date: latlng.timestamp.toString(),
                  latlng: LatLong(
                      latitude: latlng.latitude, longitude: latlng.longitude),
                  icon: MyIcons.location,
                  rate: 0,
                  isSaved: false)
            ];
            final marker = ref.watch(getSingleMarkerProvider(value));
            log('2222${marker.isLoading}');
            return marker.when(
              data: (data) {
                return Stack(children: [
                  GoogleMap(
                    markers: {
                      Marker(
                        icon: marker.hasValue
                            ? marker.value!.customIcons.first
                            : BitmapDescriptor.defaultMarker,
                        markerId: MarkerId(latlng.toString()),
                        onTap: () {},
                        infoWindow: InfoWindow(
                            title: latlng.timestamp.toString(),
                            snippet: latlng.toString()),
                        position: LatLng(latlng.latitude, latlng.longitude),
                      )
                    },
                    zoomControlsEnabled: false,
                    onMapCreated: (controller) {
                      _mapController.complete(controller);
                      _goToMyLocation(latlng);
                    },
                    // onTap: (latlng) async {
                    //   log('****** $latlng');
                    //   final data = [
                    //     Place(
                    //         title: 'title',
                    //         address: '',
                    //         distance: '',
                    //         date: '',
                    //         latlng: LatLong(
                    //             latitude: latlng.latitude, longitude: latlng.longitude),
                    //         icon: MyIcons.location,
                    //         rate: 0.0,
                    //         isSaved: false)
                    //   ];

                    //   _goToMyLocation(data);
                    // },

                    initialCameraPosition: CameraPosition(
                      target: LatLng(latlng.latitude, latlng.longitude),
                      zoom: 14.4746,
                    ),
                    // onLocationChange: (location) {
                    //   _listenToChangeLocation(location);
                    // },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () async {
                          _goToMyLocation(latlng);
                        },
                        child: FaIcon(
                          size: 34,
                          FontAwesomeIcons.crosshairs,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  )
                ]);
              },
              error: (error, stackTrace) => const Center(
                child: Text('an Error occured!'),
              ),
              loading: () => const MyLoading(),
            );
          },
          error: (error, stackTrace) {
            if (LocationServiceState.disabled == error) {
              return DisabledLocationServiceView(onRecall: () async {
                final result = ref.refresh(positionProvider);
              });
            } else {
              return PermissionDeniedScreen(onRecall: () async {
                final result = ref.refresh(positionProvider);
              });
            }
          },
          loading: () => const MyLoading(),
        );
      },
    );
  }
}
