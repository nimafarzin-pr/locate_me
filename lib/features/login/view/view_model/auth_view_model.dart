import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/database/remote/provider/remote_provider.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../core/common_features/database/remote/repository/remote_db_repository.dart';
import 'auth_state.dart';

class AuthNotifier extends AsyncNotifier<AuthenticateState> {
  late final RemoteDbRepository _dbRepository;

  @override
  Future<AuthenticateState> build() async {
    _dbRepository = ref.watch(remoteDbRepositoryProvider);
    // Load the current session state when the provider is first initialized
    return getCurrentSession();
  }

  Future<AuthenticateState> getCurrentSession() async {
    state = const AsyncValue.loading();
    final result = await _dbRepository.getCurrentSession();
    return result.when(
      success: (session) {
        state = AsyncValue.data(
            AuthenticateState(isAuthenticated: true, session: session));
        return AuthenticateState(isAuthenticated: true, session: session);
      },
      failure: (error) {
        state = AsyncValue.data(
            AuthenticateState(isAuthenticated: false, message: error));
        return AuthenticateState(isAuthenticated: false, message: error);
      },
    );
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _dbRepository.signIn(email, password);
      return result.when(
        success: (response) => AuthenticateState(
          isAuthenticated: true,
          message: LocaleKeys.successFull_login.tr(),
          session: response.session,
        ),
        failure: (error) => AuthenticateState(
          isAuthenticated: false,
          message: error,
        ),
      );
    });
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _dbRepository.signUp(email, password);
      return result.when(
        success: (response) {
          state = AsyncValue.data(AuthenticateState(
              isAuthenticated: true, session: response.session));
          return AuthenticateState(
            isAuthenticated: true,
            message: LocaleKeys.successFull_signUp.tr(),
            session: response.session,
          );
        },
        failure: (error) => AuthenticateState(
          isAuthenticated: false,
          message: error,
        ),
      );
    });
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _dbRepository.signOut();
      return result.when(
        success: (_) => AuthenticateState(
          isAuthenticated: false,
          message: LocaleKeys.success_full_action.tr(),
        ),
        failure: (error) => AuthenticateState(
          isAuthenticated: false,
          message: error,
        ),
      );
    });
  }
}
