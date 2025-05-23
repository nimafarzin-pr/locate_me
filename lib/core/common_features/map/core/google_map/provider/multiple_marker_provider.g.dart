// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_marker_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMultipleMarkerHash() => r'bf1834fe08d82f7d29b5370cf8a3d1767c5ab7d1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getMultipleMarker].
@ProviderFor(getMultipleMarker)
const getMultipleMarkerProvider = GetMultipleMarkerFamily();

/// See also [getMultipleMarker].
class GetMultipleMarkerFamily extends Family<AsyncValue<MultipleMarkerDto>> {
  /// See also [getMultipleMarker].
  const GetMultipleMarkerFamily();

  /// See also [getMultipleMarker].
  GetMultipleMarkerProvider call(
    List<PlaceItemModel> data,
  ) {
    return GetMultipleMarkerProvider(
      data,
    );
  }

  @override
  GetMultipleMarkerProvider getProviderOverride(
    covariant GetMultipleMarkerProvider provider,
  ) {
    return call(
      provider.data,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getMultipleMarkerProvider';
}

/// See also [getMultipleMarker].
class GetMultipleMarkerProvider
    extends AutoDisposeFutureProvider<MultipleMarkerDto> {
  /// See also [getMultipleMarker].
  GetMultipleMarkerProvider(
    List<PlaceItemModel> data,
  ) : this._internal(
          (ref) => getMultipleMarker(
            ref as GetMultipleMarkerRef,
            data,
          ),
          from: getMultipleMarkerProvider,
          name: r'getMultipleMarkerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMultipleMarkerHash,
          dependencies: GetMultipleMarkerFamily._dependencies,
          allTransitiveDependencies:
              GetMultipleMarkerFamily._allTransitiveDependencies,
          data: data,
        );

  GetMultipleMarkerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.data,
  }) : super.internal();

  final List<PlaceItemModel> data;

  @override
  Override overrideWith(
    FutureOr<MultipleMarkerDto> Function(GetMultipleMarkerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMultipleMarkerProvider._internal(
        (ref) => create(ref as GetMultipleMarkerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        data: data,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MultipleMarkerDto> createElement() {
    return _GetMultipleMarkerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMultipleMarkerProvider && other.data == data;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, data.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMultipleMarkerRef on AutoDisposeFutureProviderRef<MultipleMarkerDto> {
  /// The parameter `data` of this provider.
  List<PlaceItemModel> get data;
}

class _GetMultipleMarkerProviderElement
    extends AutoDisposeFutureProviderElement<MultipleMarkerDto>
    with GetMultipleMarkerRef {
  _GetMultipleMarkerProviderElement(super.provider);

  @override
  List<PlaceItemModel> get data => (origin as GetMultipleMarkerProvider).data;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
