// PaginationStateNotifier.dart

import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/place_item_model.dart';
import '../provider/filter_provider.dart';

const itemsPerPage = 10;

class PaginationState {
  final List<PlaceItemModel> data;
  final bool isLoading;
  final int currentPage;

  PaginationState({
    required this.data,
    required this.isLoading,
    required this.currentPage,
  });

  PaginationState copyWith({
    List<PlaceItemModel>? data,
    bool? isLoading,
    int? currentPage,
  }) {
    return PaginationState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class PaginationStateNotifier extends Notifier<PaginationState> {
  PaginationState loadMoreItems() {
    if (state.isLoading) {
      return PaginationState(isLoading: false, data: [], currentPage: 0);
    }

    state = PaginationState(isLoading: true, data: [], currentPage: 0);

    // Access filtered items (modify based on your implementation)
    final filteredItems = ref.read(filteredItemsProvider);
    log('${filteredItems.length}');

    final startIndex = state.currentPage * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    final nextPageItems = filteredItems.sublist(
      startIndex,
      endIndex > filteredItems.length ? filteredItems.length : endIndex,
    );
    final data = [...state.data, ...nextPageItems];
    state = state.copyWith(
      data: data,
      isLoading: false,
      currentPage: state.currentPage + 1,
    );

    log('====00 > $data');

    return PaginationState(
        isLoading: false, data: data, currentPage: state.currentPage + 1);
  }

  void resetPagination() {
    state = state.copyWith(data: [], isLoading: false, currentPage: 0);
    loadMoreItems();
  }

  @override
  PaginationState build() {
    final data = resetPagination();

    // log('######### $data');
    return loadMoreItems();
  }
}

final pagingItemsProvider =
    NotifierProvider<PaginationStateNotifier, PaginationState>(
        PaginationStateNotifier.new);
