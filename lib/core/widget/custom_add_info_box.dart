import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:locate_me/core/widget/custom_text.dart';

class CustomMarkerAddInfoBox extends StatefulWidget {
  final LatLng position;
  final bool showCard;
  const CustomMarkerAddInfoBox({
    super.key,
    required this.position,
    this.showCard = false,
  });

  @override
  State<CustomMarkerAddInfoBox> createState() => _CustomMarkerAddInfoBoxState();
}

class _CustomMarkerAddInfoBoxState extends State<CustomMarkerAddInfoBox> {
  bool showCardStat = false;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          return Column(
            children: [
              Container(
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: showCardStat
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        borderRadius: BorderRadius.circular(6)),
                    width: 260,
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          showCardStat
                              ? CustomText.bodyLarge(
                                  'latitude: ${widget.position.latitude} \n longitude ${widget.position.longitude}',
                                  textAlign: TextAlign.center,
                                  customStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: IconButton(
                  icon: Icon(Icons.location_on,
                      size: 50, color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    setState(() {
                      showCardStat = !showCardStat;
                    });
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
