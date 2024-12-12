import 'dart:developer';

import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/navigation/router/router.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../features/home/provider/home_screen_provider.dart';
import '../navigation/routes.dart';

class ScaffoldWithNestedNavigation extends ConsumerStatefulWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<ScaffoldWithNestedNavigation> createState() =>
      _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState
    extends ConsumerState<ScaffoldWithNestedNavigation> {
  void _goBranch(int index) {
    log('$index');
    if (index == 1) {
      // Assuming the "Add" tab is at index 2
      // Force a refresh of the Add screen by navigating explicitly
      context.pushReplacement(Routes
          .addLocationRouteForNavigator); // Replace with your Add screen's route
      ref.read(selectedEditStateProviderForEditView.notifier).clearEditItem();
    } else {
      // Standard goBranch behavior for other tabs
      widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex,
      );
    }

    log('R++++ ${router.routerDelegate.currentConfiguration.uri}');
  }

  @override
  Widget build(BuildContext context) {
    log('NAV++++ ${router.routerDelegate.currentConfiguration.uri}');

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: widget.navigationShell,
        bottomNavigationBar: router.routerDelegate.currentConfiguration.uri
                        .toString() ==
                    '/${Routes.editLocation}' ||
                router.routerDelegate.currentConfiguration.uri.toString() ==
                    '/${Routes.locationDetail}'
            ? null
            : Consumer(builder: (context, ref, child) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,

                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    unselectedItemColor:
                        Theme.of(context).colorScheme.onSurface,
                    selectedItemColor: Theme.of(context).colorScheme.primary,
                    unselectedIconTheme: IconThemeData(size: 20.w),
                    selectedIconTheme: IconThemeData(size: 22.w),
                    // selectedItemColor: Colors.blueGrey,
                    currentIndex: widget.navigationShell.currentIndex,
                    items: [
                      BottomNavigationBarItem(
                        icon: const FaIcon(
                          FontAwesomeIcons.listUl,
                          size: 20,
                        ),
                        label: LocaleKeys.home.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.add_location_alt_outlined,
                          size: 20,
                        ),
                        label: LocaleKeys.add.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.settings_suggest_outlined,
                          size: 20,
                        ),
                        label: LocaleKeys.settings.tr(),
                      ),
                    ],
                    onTap: (value) {
                      FocusScope.of(context).unfocus();
                      _goBranch(value);
                    },
                  ),
                );
              }),
      ),
    );
  }
}
