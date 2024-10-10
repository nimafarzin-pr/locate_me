import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/setting/view/viewmodel/language_notifier.dart';

final languageNotifierProvider =
    AsyncNotifierProvider<LanguageNotifier, String>(LanguageNotifier.new);
