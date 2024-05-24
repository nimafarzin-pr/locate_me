import 'package:flutter/material.dart';
import 'package:locate_me/core/widget/location_item.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

class NormalListView extends StatefulWidget {
  const NormalListView({
    super.key,
    required this.places,
  });

  final List<PlaceItemModel> places;

  @override
  State<NormalListView> createState() => _NormalListViewState();
}

class _NormalListViewState extends State<NormalListView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = widget.places[index];
        return LocationItem(item: item, index: index);
      },
      itemCount: widget.places.length,
    );
  }

  @override
  bool get wantKeepAlive => false;
}
