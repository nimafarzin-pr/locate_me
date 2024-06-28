import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/widget/accept_button/view_model.dart';

final loadingProvider =
    AutoDisposeNotifierProvider<ButtonLoadingNotifier, bool>(
        ButtonLoadingNotifier.new);
