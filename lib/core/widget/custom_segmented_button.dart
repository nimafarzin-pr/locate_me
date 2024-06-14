// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/map/enums/map_enum.dart';
import 'custom_text.dart';

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
        visualDensity: VisualDensity(horizontal: 0.w, vertical: 0.w),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        selectedForegroundColor: Theme.of(context).colorScheme.surfaceContainer,
        selectedBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      segments: <ButtonSegment<HomeViewMode>>[
        ButtonSegment<HomeViewMode>(
          value: HomeViewMode.list,
          label: CustomText.bodyLarge('List'),
          icon: const Icon(Icons.list),
        ),
        ButtonSegment<HomeViewMode>(
            value: HomeViewMode.map,
            label: CustomText.bodyLarge('Map'),
            icon: const Icon(Icons.map_outlined)),
      ],
      onSelectionChanged: widget.onSelectionChanged,
      selected: <HomeViewMode>{widget.homeViewMode},
    );
  }
}
