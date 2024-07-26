import 'package:flutter/widgets.dart';

extension ScreenSizeExtension on num {
  int cachedSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}
