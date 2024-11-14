import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/features/intro/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/widget/background_wrapper.dart';
import 'package:locate_me/core/widget/navigation_scafold.dart';
import 'package:locate_me/features/home/view/screen/home_tab.dart';
import 'package:locate_me/features/setting/view/screen/setting_tab.dart';
import 'package:locate_me/features/setting/view/widgets/items/category/category_list.dart';
import '../../../features/add/view/screen/add_tab.dart';
import '../../../features/home/view/widgets/details_view.dart';
import '../../../features/home/view/widgets/edit/edit_view.dart';

// Private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorAddKey = GlobalKey<NavigatorState>(debugLabel: 'add');
final _shellNavigatorSettingKey =
    GlobalKey<NavigatorState>(debugLabel: 'settings');

// Helper function to check Supabase session state
bool isUserLoggedIn() {
  return Supabase.instance.client.auth.currentSession != null;
}

final router = GoRouter(
  initialLocation: Routes.splash,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.splash,
      name: Routes.splash,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const BackgroundWrapper(child: SplashScreen()),
      ),
    ),

    // The rest of your routes with Shell Navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        // Home Branch (A)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: Routes.root,
              name: Routes.root,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const BackgroundWrapper(child: HomeTab()),
              ),
              routes: [
                GoRoute(
                  path: Routes.editLocation,
                  name: Routes.editLocation,
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: const BackgroundWrapper(child: EditView()),
                  ),
                ),
                GoRoute(
                  path: Routes.locationDetail,
                  name: Routes.locationDetail,
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: const BackgroundWrapper(child: ShowDetailsScreen()),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Add Branch (B)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAddKey,
          routes: [
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
        // Settings Branch (C)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSettingKey,
          routes: [
            GoRoute(
              path: Routes.settings,
              name: Routes.settings,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const BackgroundWrapper(child: SettingsTab()),
              ),
              routes: [
                GoRoute(
                  path: Routes.categoryList,
                  name: Routes.categoryList,
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: const BackgroundWrapper(child: CategoryList()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
