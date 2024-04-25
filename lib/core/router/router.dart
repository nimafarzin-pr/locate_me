import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/widget/navigation_scafold.dart';
import 'package:locate_me/features/add/view/add_tab.dart';
import 'package:locate_me/features/home/view/home_tab.dart';
import 'package:locate_me/features/setting/view/setting_tab.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');

final router = GoRouter(
  initialLocation: '/',
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
          navigatorKey: _shellNavigatorAKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const HomeTab(),
              ),
              // routes: [
              //   // child route
              //   GoRoute(
              //     path: Routes.home,
              //     name: Routes.home,
              //     pageBuilder: (context, state) {
              //       // final Map<String, dynamic> param =
              //       //     state.extra as Map<String, dynamic>;
              //       // final symbol = param['symbolId']!;
              //       return NoTransitionPage(
              //         key: state.pageKey,
              //         child: const AddTab(),
              //       );
              //     },
              //   ),
              // ],
            ),
          ],
        ),
        // second branch (B)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
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
          navigatorKey: _shellNavigatorCKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: Routes.settings,
              name: Routes.settings,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const SettingTab(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
