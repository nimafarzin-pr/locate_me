// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../helper/map/enums/map_enum.dart';

class CustomSegmentedButton extends StatefulWidget {
  final HomeViewMode homeViewMode;
  final void Function(Set<HomeViewMode>)? onSelectionChanged;

  const CustomSegmentedButton({
    super.key,
    required this.homeViewMode,
    this.onSelectionChanged,
  });

  @override
  State<CustomSegmentedButton> createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<HomeViewMode>(
      style: SegmentedButton.styleFrom(
        alignment: Alignment.center,
        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: 2, vertical: 2),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        selectedForegroundColor: Theme.of(context).colorScheme.onSecondary,
        selectedBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      segments: const <ButtonSegment<HomeViewMode>>[
        ButtonSegment<HomeViewMode>(
          value: HomeViewMode.list,
          label: Text('List'),
          icon: Icon(Icons.list),
        ),
        ButtonSegment<HomeViewMode>(
            value: HomeViewMode.map,
            label: Text('Map'),
            icon: Icon(Icons.map_outlined)),
      ],
      onSelectionChanged: widget.onSelectionChanged,
      selected: <HomeViewMode>{widget.homeViewMode},
    );
  }
}
