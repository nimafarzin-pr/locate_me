import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLngTwo;

import 'package:locate_me/core/widget/custom_location_button.dart';
import 'package:locate_me/features/add/provider/osm_location_provider.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../../core/widget/dialogs/custom_map_options.dart';
import '../../../../core/widget/loading.dart';
import '../../provider/google_map_provider.dart';
import 'dialog/add_location_dialog.dart';

class GoogleMapAddView extends ConsumerStatefulWidget {
  const GoogleMapAddView({super.key});

  @override
  ConsumerState<GoogleMapAddView> createState() => _GoogleMapAddViewState();
}

class _GoogleMapAddViewState extends ConsumerState<GoogleMapAddView> {
  late Completer<GoogleMapController> _mapController;

  @override
  void initState() {
    _mapController = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pos = ref.watch(currentPositionProvider);
    if (pos.hasError) {
      return const Center(
        child: Text('Some error occurred!'),
      );
    }

    if (pos.value == null) {
      return const MyLoading();
    }

    final result = pos.value!;
    final latLong = result.location;
    final position = LatLng(latLong.lat, latLong.lng);
    return Stack(children: [
      GoogleMap(
        onCameraMove: (cameraPosition) {
          final latlng2 = latLngTwo.LatLng(
              cameraPosition.target.latitude, cameraPosition.target.longitude);
          ref.read(addLocationProvider.notifier).updateLocation(latlng2);
        },
        markers: {
          Marker(
              icon: result.marker.first.icon,
              markerId: MarkerId(latLong.lat.toString()),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const Text('data ');
                  },
                );
              },
              position: position)
        },
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          ref.refresh(addLocationProvider);
          _mapController = Completer();
          _mapController.complete(controller);
        },
        compassEnabled: false,
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 14.4746,
        ),
      ),
      Positioned(
        bottom: 20,
        right: 20,
        child: CustomLocationButton(onPressed: () async {
          ref
              .read(addLocationProvider.notifier)
              .animateToMyLocationOnGoogleMap(mapController: _mapController);
        }),
      ),
      Positioned(
        top: 20,
        right: 20,
        child: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () async {
            await showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return CustomMapOptionsDialog(
                  options: const ['position'],
                  onOptionSelected: (p0) {},
                );
              },
            );
          },
          child: const FaIcon(
            FontAwesomeIcons.ellipsis,
            color: Colors.black,
          ),
        ),
      ),
      Positioned(
        bottom: 90,
        right: 20,
        child: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () async {
            await showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return AddLocationView<PlaceItemModel>(
                  latLng: position,
                  onAccept: (location) async {
                    await ref
                        .read(addLocationProvider.notifier)
                        .addLocation(location);
                  },
                );
              },
            );
          },
          child: const FaIcon(
            FontAwesomeIcons.floppyDisk,
            color: Colors.black,
          ),
        ),
      ),
    ]);
  }
}
