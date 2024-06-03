// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../helper/map/enums/map_enum.dart';

class SegmentedButtonExample extends StatefulWidget {
  final HomeListShowMode homeListShowMode;
  final void Function(Set<HomeListShowMode>)? onSelectionChanged;

  const SegmentedButtonExample({
    super.key,
    required this.homeListShowMode,
    this.onSelectionChanged,
  });

  @override
  State<SegmentedButtonExample> createState() => _SegmentedButtonExampleState();
}

class _SegmentedButtonExampleState extends State<SegmentedButtonExample> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<HomeListShowMode>(
      style: SegmentedButton.styleFrom(
        alignment: Alignment.center,
        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        selectedForegroundColor: Theme.of(context).colorScheme.onSecondary,
        selectedBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      segments: const <ButtonSegment<HomeListShowMode>>[
        ButtonSegment<HomeListShowMode>(
          value: HomeListShowMode.list,
          label: Text('List View'),
          icon: Icon(Icons.list),
        ),
        ButtonSegment<HomeListShowMode>(
            value: HomeListShowMode.map,
            label: Text('Map View'),
            icon: Icon(Icons.map_outlined)),
      ],
      onSelectionChanged: widget.onSelectionChanged,
      selected: <HomeListShowMode>{widget.homeListShowMode},
    );
  }
}
