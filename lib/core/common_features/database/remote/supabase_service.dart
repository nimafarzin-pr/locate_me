import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // Private constructor
  SupabaseService._privateConstructor();

  // Static instance of the class
  static final SupabaseService _instance =
      SupabaseService._privateConstructor();

  // Public factory constructor
  factory SupabaseService() {
    return _instance;
  }

  // Supabase client instance
  late final SupabaseClient client;

  // Initialization function
  Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.get('supabase_url'),
      anonKey: dotenv.get('supabase_token'),
    );
    client = Supabase.instance.client;
  }

  Session? getCurrentSession() {
    return client.auth.currentSession;
  }

  // Example method to sign in a user
  Future<AuthResponse> signIn(String email, String password) async {
    final response =
        await client.auth.signInWithPassword(email: email, password: password);
    return response;
  }

  Future<AuthResponse> signUp(String email, String password) async {
    final response = await client.auth.signUp(email: email, password: password);
    return response;
  }

  // Example method to sign out
  Future<void> signOut() async {
    await client.auth.signOut();
  }
}
