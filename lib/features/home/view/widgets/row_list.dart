import 'package:flutter/material.dart';
import 'package:locate_me/core/widget/location_item.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

class RowList extends StatefulWidget {
  const RowList({
    super.key,
    required this.places,
  });

  final List<Place> places;

  @override
  State<RowList> createState() => _RowListState();
}

class _RowListState extends State<RowList> with AutomaticKeepAliveClientMixin {
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
