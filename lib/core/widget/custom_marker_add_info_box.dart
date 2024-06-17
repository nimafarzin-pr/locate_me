// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../sizing/app_sizing.dart';

class CustomMarkerAddInfoBox extends StatefulWidget {
  final LatLng position;
  final bool showCard;
  final Color? markerColor;
  final PlaceItemModel? placeItemModel;
  const CustomMarkerAddInfoBox({
    super.key,
    required this.position,
    this.showCard = false,
    this.markerColor,
    this.placeItemModel,
  });

  @override
  State<CustomMarkerAddInfoBox> createState() => _CustomMarkerAddInfoBoxState();
}

class _CustomMarkerAddInfoBoxState extends State<CustomMarkerAddInfoBox> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.showCard
                  ? Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                                  widget.showCard ? widget.markerColor : null,
                              borderRadius: BorderRadius.circular(
                                  AppSizes.verySmallBorderRadius)),
                          // width: 260,
                          height: 36,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: widget.showCard
                                ? CustomText.bodyLarge(
                                    '${widget.placeItemModel?.title}',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    customStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        overflow: TextOverflow.ellipsis),
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Icon(Icons.location_on,
                  size: 50,
                  color: widget.markerColor ??
                      Theme.of(context).colorScheme.primary)
            ],
          );
        },
      ),
    );
  }
}
