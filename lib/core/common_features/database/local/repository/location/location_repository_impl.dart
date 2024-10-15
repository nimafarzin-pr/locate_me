import 'dart:developer';

import 'package:locate_me/core/common_features/database/local/type_converter/place_model_converter.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../category/enums/category.dart';
import '../../../../../utils/date_converter.dart';
import '../../provider/db_provider.dart';
import '../../service/location/location_service_impl.dart';
import 'location_repository.dart';

class LocationRepositoryImpl implements ILocationRepository {
  final LocationServiceImpl _databaseService;

  LocationRepositoryImpl(this._databaseService);

  @override
  Future<void> deleteAllLocations() async {
    try {
      await _databaseService.deleteAllLocations();
    } catch (e, stackTrace) {
      // Handle or log the error
      print('Error deleting all locations: $e');
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<int> deleteLocation(int id) async {
    try {
      return await _databaseService.delete(id);
    } catch (e, stackTrace) {
      // Handle or log the error
      print('Error deleting location with id $id: $e');
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<PlaceItemModel?> getLocation(int id) async {
    try {
      final data = await _databaseService.getById(id);
      if (data == null) return null;
      final toModel = const DbPlaceModelConverter().fromSql(data);
      return toModel;
    } catch (e, stackTrace) {
      // Handle or log the error
      print('Error getting location with id $id: $e');
      print(stackTrace);
      return null;
    }
  }

  @override
  Future<List<PlaceItemModel>> getLocations() async {
    try {
      final data = await _databaseService.getAll();
      final toModel = data
          .map(
            (e) => const DbPlaceModelConverter().fromSql(e),
          )
          .toList();

      return toModel;
    } catch (e, stackTrace) {
      // Handle or log the error
      print('Error getting locations: $e');
      print(stackTrace);
      return [];
    }
  }

  @override
  Future<int> insertLocation(PlaceItemModel location) async {
    try {
      final toDbModel =
          const DbPlaceModelConverter().toSql(location).toCompanion(true);
      return await _databaseService.insert(toDbModel);
    } catch (e, stackTrace) {
      // Handle or log the error
      print('Error inserting location: $e');
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<PlaceItemModel>> searchLocations(String query) async {
    try {
      final data = await _databaseService.searchLocations(query);
      final toModel = data
          .map(
            (e) => const DbPlaceModelConverter().fromSql(e),
          )
          .toList();
      return toModel;
    } catch (e, stackTrace) {
      // Handle or log the error
      print('Error searching locations with query $query: $e');
      print(stackTrace);
      return [];
    }
  }

  @override
  Future<void> updateLocation(int id, PlaceItemModel location) async {
    try {
      final toDbModel =
          const DbPlaceModelConverter().toSql(location).toCompanion(true);
      await _databaseService.update(id, toDbModel);
    } catch (e, stackTrace) {
      // Handle or log the error
      print('Error updating location with id $id: $e');
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Stream<List<PlaceItemModel>> watchLocations() {
    final dataStream = _databaseService.watchAll();
    return dataStream.map<List<PlaceItemModel>>((dataList) {
      try {
        return dataList
            .map((data) => const DbPlaceModelConverter().fromSql(data))
            .toList();
      } catch (e, stackTrace) {
        // Handle or log the error
        print('Error watching locations: $e');
        print(stackTrace);
        return [];
      }
    }).handleError((e, stackTrace) {
      // Handle or log the error in the stream
      print('Error in watchLocations stream: $e');
      print(stackTrace);
    });
  }

  @override
  Future<void> updateFavoriteStatus(int id) async {
    try {
      await _databaseService.updateFavoriteStatus(id);
    } catch (e, stackTrace) {
      // Handle or log the error
      print('Error updating location with id $id: $e');
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Stream<List<PlaceItemModel>> watchFavoriteLocations() {
    final dataStream = _databaseService.watchFavoriteLocations();
    return dataStream.map<List<PlaceItemModel>>((dataList) {
      try {
        return dataList
            .map((data) => const DbPlaceModelConverter().fromSql(data))
            .toList();
      } catch (e, stackTrace) {
        // Handle or log the error
        print('Error watching locations: $e');
        print(stackTrace);
        return [];
      }
    }).handleError((e, stackTrace) {
      // Handle or log the error in the stream
      print('Error in watchLocations stream: $e');
      print(stackTrace);
    });
  }

  @override
  Stream<List<PlaceItemModel>> watchLocationsByCategory(
      CategoryEnums category) {
    final dataStream = _databaseService.watchLocationsByCategory(category);
    return dataStream.map<List<PlaceItemModel>>((dataList) {
      try {
        return dataList
            .map((data) => const DbPlaceModelConverter().fromSql(data))
            .toList();
      } catch (e, stackTrace) {
        // Handle or log the error
        print('Error watching locations: $e');
        print(stackTrace);
        return [];
      }
    }).handleError((e, stackTrace) {
      // Handle or log the error in the stream
      print('Error in watchLocations stream: $e');
      print(stackTrace);
    });
  }

  @override
  Stream<List<PlaceItemModel>> watchLocationsWithLanguageProvider() async* {
    final container = ProviderContainer();
    final language = container.read(appDBSettingServiceProvider);
    final locale = await language.getLanguage();
    final dataStream = _databaseService.watchAll();
    yield* dataStream.map<List<PlaceItemModel>>((dataList) {
      try {
        final list = dataList.map((data) {
          final item = const DbPlaceModelConverter().fromSql(data);
          final shamsi = item.copyWith(
              date: locale == 'fa'
                  ? DateConverter.toShamsi(item.date)
                  : DateConverter.toGregorian(item.date));
          return shamsi;
        }).toList();
        return list;
      } catch (e, stackTrace) {
        // Handle or log the error
        print('Error watching locations: $e');
        print(stackTrace);
        return [];
      }
    }).handleError((e, stackTrace) {
      // Handle or log the error in the stream
      print('Error in watchLocations stream: $e');
      print(stackTrace);
    });
  }

  @override
  Future<void> importLocations(List<PlaceItemModel> data) async {
    try {
      final toDriftLocations = data.map(
        (e) {
          return const DbPlaceModelConverter().toSql(e).toCompanion(true);
        },
      ).toList();
      await _databaseService.importLocations(toDriftLocations);
    } catch (e) {
      print('Error in watchLocations stream: $e');
      rethrow;
    }
  }
}
