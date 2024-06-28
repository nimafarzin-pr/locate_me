// // PaginationStateNotifier.dart

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../model/place_item_model.dart';
// import '../provider/filter_provider.dart';

// const itemsPerPage = 10;

// class PaginationState {
//   final List<PlaceItemModel> data;
//   final bool isLoading;
//   final int currentPage;

//   PaginationState({
//     required this.data,
//     required this.isLoading,
//     required this.currentPage,
//   });

//   PaginationState copyWith({
//     List<PlaceItemModel>? data,
//     bool? isLoading,
//     int? currentPage,
//   }) {
//     return PaginationState(
//       data: data ?? this.data,
//       isLoading: isLoading ?? this.isLoading,
//       currentPage: currentPage ?? this.currentPage,
//     );
//   }
// }

// class PaginationStateNotifier extends Notifier {
//   final PaginationState _state =
//       PaginationState(data: [], isLoading: false, currentPage: 0);

//   @override
//   PaginationState get state => _state;

//   Future<void> loadMoreItems() async {
//     if (_state.isLoading) return;

//     state = _state.copyWith(isLoading: true);

//     // Access filtered items (modify based on your implementation)
//     final filteredItems = ref.read(filteredItemsProvider);

//     final startIndex = _state.currentPage * itemsPerPage;
//     final endIndex = startIndex + itemsPerPage;
//     final nextPageItems = filteredItems.sublist(
//       startIndex,
//       endIndex > filteredItems.length ? filteredItems.length : endIndex,
//     );

//     state = state.copyWith(
//       data: [...state.data, ...nextPageItems],
//       isLoading: false,
//       currentPage: state.currentPage + 1,
//     );
//   }

//   void resetPagination() {
//     state = state.copyWith(data: [], isLoading: false, currentPage: 0);
//     loadMoreItems();
//   }

//   @override
//   build() => _state;
// }

// final pagingItemsProvider =
//     Provider<PaginationStateNotifier>((ref) => PaginationStateNotifier());
