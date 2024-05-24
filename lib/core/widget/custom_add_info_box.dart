import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class CustomMarkerAddInfoBox extends StatelessWidget {
  final LatLng position;
  const CustomMarkerAddInfoBox({
    super.key,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 12,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(6)),
              width: 250,
              height: 120,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'latitude: ${position.latitude} \n longitude ${position.longitude}',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Center(
          child: Icon(
            Icons.location_on,
            color: Colors.black,
            size: 30,
          ),
        )
      ],
    );
  }
}
