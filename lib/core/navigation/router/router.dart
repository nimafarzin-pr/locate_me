import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/widget/navigation_scafold.dart';
import 'package:locate_me/features/add/view/add_tab.dart';
import 'package:locate_me/features/home/view/home_tab.dart';
import 'package:locate_me/features/setting/view/setting_tab.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorAddKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorSettingKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellC');

final router = GoRouter(
  initialLocation: Routes.root,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        // first branch (A)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: Routes.root,
              name: Routes.root,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const HomeTab(),
              ),
              routes: [
                // child route
                GoRoute(
                  path: Routes.editLocation,
                  name: Routes.editLocation,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: const AddTab(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        // second branch (B)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAddKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: Routes.add,
              name: Routes.add,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const AddTab(),
              ),
            ),
          ],
        ),
        // second branch (C)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSettingKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: Routes.settings,
              name: Routes.settings,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const SettingsTab(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
