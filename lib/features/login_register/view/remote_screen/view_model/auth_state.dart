import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@immutable
class AuthenticateState {
  final String? message;
  final bool isAuthenticated;
  final Session? session;

  const AuthenticateState({
    required this.isAuthenticated,
    this.message,
    this.session,
  });

  AuthenticateState copyWith({
    bool? isAuthenticated,
    String? message,
    Session? session,
  }) {
    return AuthenticateState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      message: message ?? this.message,
      session: session ?? this.session,
    );
  }
}
