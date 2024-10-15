import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/database/remote/repository/remote_db_repository.dart';

import '../supabase_service.dart';

// Create a provider for SupabaseService
final supabaseServiceProvider = Provider<SupabaseService>((ref) {
  return SupabaseService();
});
final remoteDbRepositoryProvider = Provider<RemoteDbRepository>((ref) {
  final supabaseService = ref.read(supabaseServiceProvider);
  return RemoteDbRepositoryImpl(service: supabaseService);
});
