// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:locate_me/core/common_features/database/remote/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../network/result.dart';

abstract class RemoteDbRepository {
  Future<Result<AuthResponse>> signIn(String email, String password);
  Future<Result<AuthResponse>> signUp(String email, String password);
  Future<Result<Session>> getCurrentSession();
  Future<Result<void>> signOut();
}

class RemoteDbRepositoryImpl implements RemoteDbRepository {
  final SupabaseService service;
  RemoteDbRepositoryImpl({
    required this.service,
  });

  @override
  Future<Result<AuthResponse>> signIn(String email, String password) async {
    try {
      final AuthResponse response = await service.signIn(
        email,
        password,
      );

      if (response.session != null) {
        // If success, return a success result
        return Success(response);
      } else {
        // If no session, treat it as failure
        return const Failure("Sign in failed: No active session.");
      }
    } catch (e) {
      // Catch and return the error
      return Failure("Error during sign-in: $e");
    }
  }

  @override
  Future<Result<AuthResponse>> signUp(String email, String password) async {
    try {
      final AuthResponse response = await service.signUp(
        email,
        password,
      );

      if (response.user != null) {
        // Success case
        return Success(response);
      } else {
        // Failure case
        return const Failure("Sign up failed: No user found.");
      }
    } catch (e) {
      // Catch and return the error
      return Failure("Error during sign-up: $e");
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await service.signOut();
      // If successful, return a success result with no data
      return const Success(null);
    } catch (e) {
      // Catch and return the error
      return Failure("Error during sign-out: $e");
    }
  }

  @override
  Future<Result<Session>> getCurrentSession() async {
    try {
      final session = service.getCurrentSession();

      if (session != null) {
        // Return a successful result with the session data
        return Success(session);
      } else {
        // No active session found
        return const Failure("No active session found.");
      }
    } catch (e) {
      // Handle any potential errors and return a failure result
      return Failure("Error retrieving session: $e");
    }
  }
}
