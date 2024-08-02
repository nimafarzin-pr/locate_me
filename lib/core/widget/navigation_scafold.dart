import 'dart:developer';

// import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/navigation/router/router.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../navigation/routes.dart';

// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
    log('R++++ ${router.routerDelegate.currentConfiguration.uri}');
  }

  @override
  Widget build(BuildContext context) {
    log('NAV++++ ${router.routerDelegate.currentConfiguration.uri}');

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: navigationShell,
        bottomNavigationBar: router.routerDelegate.currentConfiguration.uri
                        .toString() ==
                    '/${Routes.editLocation}' ||
                router.routerDelegate.currentConfiguration.uri.toString() ==
                    '/${Routes.locationDetail}'
            ? null
            : Directionality(
                textDirection: TextDirection.ltr,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,

                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainer,
                  unselectedItemColor: Theme.of(context).colorScheme.onSurface,
                  selectedItemColor: Theme.of(context).colorScheme.primary,
                  unselectedIconTheme: IconThemeData(size: 20.w),
                  selectedIconTheme: IconThemeData(size: 22.w),
                  // selectedItemColor: Colors.blueGrey,
                  currentIndex: navigationShell.currentIndex,
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
              ),
      ),
    );
  }
}
