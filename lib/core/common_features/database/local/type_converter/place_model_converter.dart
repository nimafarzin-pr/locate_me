// stores preferences as strings
import 'package:drift/drift.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../db/db.dart';

class DbPlaceModelConverter extends TypeConverter<PlaceItemModel, Location> {
  const DbPlaceModelConverter();

  @override
  PlaceItemModel fromSql(Location fromDb) {
    return PlaceItemModel(
      // You need to adjust the initialization if the Location has more fields.
      title: fromDb.title,
      id: fromDb.id,
      address: fromDb.address ?? '',
      description: fromDb.description ?? '',
      categoryIcon: fromDb.categoryIcon,
      categoryName: fromDb.categoryName,
      latlng: LatLong(latitude: fromDb.latitude, longitude: fromDb.longitude),
      distance: '', // Provide default value
      date: fromDb.timestamp.toIso8601String(), // Provide default value
      rate: fromDb.rate, // Provide default value
      isFavorite: fromDb.isFavorite,
      picture: fromDb.picture, // Provide default value
    );
  }

  @override
  Location toSql(PlaceItemModel value) {
    return Location(
      categoryName: value.categoryName,
      isFavorite: value.isFavorite,
      picture: value.picture,
      title: value.title,
      timestamp: DateTime.parse(value.date),
      address: value.address,
      description: value.description,
      categoryIcon: value.categoryIcon,
      rate: value.rate,
      latitude: value.latlng.latitude,
      longitude: value.latlng.longitude,
    );
  }
}
