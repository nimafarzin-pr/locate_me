import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

class CustomMarkerAddInfoBox extends StatefulWidget {
  final LatLng position;
  final bool showCard;
  final PlaceItemModel? placeItemModel;
  const CustomMarkerAddInfoBox({
    super.key,
    required this.position,
    this.placeItemModel,
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
                    // width: 260,
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          showCardStat
                              ? Expanded(
                                  child: CustomText.bodyLarge(
                                    '${widget.placeItemModel?.title}',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    customStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
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
