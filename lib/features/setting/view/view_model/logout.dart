import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogoutNotifier extends AsyncNotifier<bool?> {
  @override
  Future<bool>? build() => null;

  Future<bool> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
