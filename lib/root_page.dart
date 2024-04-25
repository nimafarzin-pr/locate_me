// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:locate_me/features/add/view/add_tab.dart';
// import 'package:locate_me/features/home/view/home_tab.dart';
// import 'package:locate_me/features/setting/view/setting_tab.dart';

// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => RootPageState();
// }

// class RootPageState extends State<RootPage> {
//   int _currentIndex = 0;
//   final List<Widget> _pages = const [
//     HomeTab(),
//     AddTab(),
//     SettingTab(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: ConvexAppBar(
//         style: TabStyle.custom,
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         items: const [
//           TabItem(icon: Icons.home, title: 'Home'),
//           TabItem(icon: Icons.add, title: 'Add'),
//           TabItem(icon: Icons.settings, title: 'Setting'),
//         ],
//         onTap: (int index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//       body: SafeArea(child: _pages[_currentIndex]),
//     );
//   }
// }
