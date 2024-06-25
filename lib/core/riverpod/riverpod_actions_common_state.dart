class RiverpodActionsCommonState {
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;
  final bool? isCancel;

  RiverpodActionsCommonState(
      {this.isLoading = false,
      this.successMessage,
      this.errorMessage,
      this.isCancel});

  RiverpodActionsCommonState copyWith(
      {bool? isLoading,
      String? successMessage,
      String? errorMessage,
      bool? isCancel}) {
    return RiverpodActionsCommonState(
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      isCancel: isCancel ?? this.isCancel,
    );
  }
}
