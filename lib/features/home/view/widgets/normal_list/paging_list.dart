// // PagingList.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:locate_me/core/widget/fade_in_scale_animation.dart';
// import 'package:locate_me/features/home/view/widgets/location_item.dart';

// import '../../../view_model/pagination_notifier.dart';

// class PagingList extends HookConsumerWidget {
//   const PagingList({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final scrollController = useScrollController();
//     final state = ref.watch(pagingItemsProvider).state;

//     useEffect(() {
//       void onScroll() {
//         if (scrollController.position.atEdge &&
//             scrollController.position.pixels != 0) {
//           ref.read(pagingItemsProvider).loadMoreItems();
//         }
//       }

//       scrollController.addListener(onScroll);
//       return () => scrollController.removeListener(onScroll);
//     }, [scrollController]);

//     return ListView.builder(
//       controller: scrollController,
//       itemCount: state.data.length + (state.isLoading ? 1 : 0),
//       itemBuilder: (context, index) {
//         if (index == state.data.length) {
//           return state.isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : buildError(context);
//         }
//         final item = state.data[index];
//         return FadeInScaleAnimation(
//           key: ValueKey(item.id),
//           beginScale: 0.5,
//           duration: const Duration(milliseconds: 300),
//           child: LocationItem(item: item, index: index),
//         );
//       },
//     );
//   }

//   // Add a method to handle potential errors (optional)
//   Widget buildError(BuildContext context) {
//     // Handle errors based on your implementation
//     return const Center(child: Text("Error fetching data"));
//   }
// }
