import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/remote_screen/view_model/auth_view_model.dart';
import '../view/remote_screen/view_model/auth_state.dart';

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, AuthenticateState>(AuthNotifier.new);
