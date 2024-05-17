// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_marker_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMultipleMarkerHash() => r'311d8701e0d1e45b1fd3315a357bea66f8a307fa';

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
class GetMultipleMarkerFamily extends Family<AsyncValue<MarkersData>> {
  /// See also [getMultipleMarker].
  const GetMultipleMarkerFamily();

  /// See also [getMultipleMarker].
  GetMultipleMarkerProvider call(
    List<Place> data,
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
class GetMultipleMarkerProvider extends AutoDisposeFutureProvider<MarkersData> {
  /// See also [getMultipleMarker].
  GetMultipleMarkerProvider(
    List<Place> data,
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

  final List<Place> data;

  @override
  Override overrideWith(
    FutureOr<MarkersData> Function(GetMultipleMarkerRef provider) create,
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
  AutoDisposeFutureProviderElement<MarkersData> createElement() {
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

mixin GetMultipleMarkerRef on AutoDisposeFutureProviderRef<MarkersData> {
  /// The parameter `data` of this provider.
  List<Place> get data;
}

class _GetMultipleMarkerProviderElement
    extends AutoDisposeFutureProviderElement<MarkersData>
    with GetMultipleMarkerRef {
  _GetMultipleMarkerProviderElement(super.provider);

  @override
  List<Place> get data => (origin as GetMultipleMarkerProvider).data;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
