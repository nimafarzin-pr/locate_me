import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/login_register/view/local_screen/view_model/login_view_model.dart';
import 'package:locate_me/features/login_register/view/local_screen/view_model/set_password_view_model.dart';
import 'package:locate_me/features/login_register/view/local_screen/view_model/splash_view_model.dart';

final splashNotifierProvider =
    AsyncNotifierProvider<SplashNotifier, bool>(SplashNotifier.new);

final setPasswordNotifierProvider =
    AsyncNotifierProvider<SetPasswordNotifier, bool?>(SetPasswordNotifier.new);

final loginNotifierProvider =
    AsyncNotifierProvider<LoginNotifier, bool?>(LoginNotifier.new);
