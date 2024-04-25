import 'package:flutter/material.dart';
import 'package:locate_me/core/router/router.dart';
import 'package:locate_me/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      darkTheme: GlobalThemeData.darkTheme,
      title: 'Flutter Demo',
      theme: GlobalThemeData.lightTheme,
    );
  }
}
