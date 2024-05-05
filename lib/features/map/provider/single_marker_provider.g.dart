// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_marker_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSingleMarkerHash() => r'ae9039208f3d6a329fd0938cf15fe9ad05886e62';

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

/// See also [getSingleMarker].
@ProviderFor(getSingleMarker)
const getSingleMarkerProvider = GetSingleMarkerFamily();

/// See also [getSingleMarker].
class GetSingleMarkerFamily extends Family<AsyncValue<MarkersModeData>> {
  /// See also [getSingleMarker].
  const GetSingleMarkerFamily();

  /// See also [getSingleMarker].
  GetSingleMarkerProvider call(
    List<Place> data,
  ) {
    return GetSingleMarkerProvider(
      data,
    );
  }

  @override
  GetSingleMarkerProvider getProviderOverride(
    covariant GetSingleMarkerProvider provider,
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
  String? get name => r'getSingleMarkerProvider';
}

/// See also [getSingleMarker].
class GetSingleMarkerProvider
    extends AutoDisposeFutureProvider<MarkersModeData> {
  /// See also [getSingleMarker].
  GetSingleMarkerProvider(
    List<Place> data,
  ) : this._internal(
          (ref) => getSingleMarker(
            ref as GetSingleMarkerRef,
            data,
          ),
          from: getSingleMarkerProvider,
          name: r'getSingleMarkerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSingleMarkerHash,
          dependencies: GetSingleMarkerFamily._dependencies,
          allTransitiveDependencies:
              GetSingleMarkerFamily._allTransitiveDependencies,
          data: data,
        );

  GetSingleMarkerProvider._internal(
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
    FutureOr<MarkersModeData> Function(GetSingleMarkerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSingleMarkerProvider._internal(
        (ref) => create(ref as GetSingleMarkerRef),
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
  AutoDisposeFutureProviderElement<MarkersModeData> createElement() {
    return _GetSingleMarkerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSingleMarkerProvider && other.data == data;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, data.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSingleMarkerRef on AutoDisposeFutureProviderRef<MarkersModeData> {
  /// The parameter `data` of this provider.
  List<Place> get data;
}

class _GetSingleMarkerProviderElement
    extends AutoDisposeFutureProviderElement<MarkersModeData>
    with GetSingleMarkerRef {
  _GetSingleMarkerProviderElement(super.provider);

  @override
  List<Place> get data => (origin as GetSingleMarkerProvider).data;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
