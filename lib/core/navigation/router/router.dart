import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/widget/background_wrapper.dart';
import 'package:locate_me/core/widget/navigation_scafold.dart';
import 'package:locate_me/features/home/view/home_tab.dart';
import 'package:locate_me/features/setting/view/setting_tab.dart';
import 'package:locate_me/features/setting/view/widgets/items/category/category_list.dart';

import '../../../features/add/view/add_tab.dart';
import '../../../features/home/model/place_item_model.dart';
import '../../../features/home/view/widgets/details_view.dart';
import '../../../features/home/view/widgets/edit/edit_view.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorAddKey = GlobalKey<NavigatorState>(debugLabel: 'add');
final _shellNavigatorSettingKey =
    GlobalKey<NavigatorState>(debugLabel: 'settings');

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
                child: const BackgroundWrapper(child: HomeTab()),
              ),
              routes: [
                // child route
                GoRoute(
                  path: Routes.editLocation,
                  name: Routes.editLocation,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: const BackgroundWrapper(child: EditView()),
                    );
                  },
                ),
                GoRoute(
                  path: Routes.locationDetail,
                  name: Routes.locationDetail,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      key: state.pageKey,
                      child:
                          const BackgroundWrapper(child: ShowDetailsScreen()),
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
                child: const BackgroundWrapper(child: AddTab()),
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
                child: const BackgroundWrapper(child: SettingsTab()),
              ),
              routes: [
                // child route
                GoRoute(
                  path: Routes.categoryList,
                  name: Routes.categoryList,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: const BackgroundWrapper(child: CategoryList()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
