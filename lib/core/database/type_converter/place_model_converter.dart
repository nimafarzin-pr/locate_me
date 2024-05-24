// stores preferences as strings
import 'package:drift/drift.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../location/location_database_impl.dart';

class DbPlaceModelConverter extends TypeConverter<PlaceItemModel, Location> {
  const DbPlaceModelConverter();

  @override
  PlaceItemModel fromSql(Location fromDb) {
    return PlaceItemModel(
      // You need to adjust the initialization if the Location has more fields.
      title: fromDb.title,
      address: fromDb.address ?? '',
      description: fromDb.description ?? '',
      category: fromDb.category ?? '',
      latlng: LatLong(latitude: fromDb.latitude, longitude: fromDb.longitude),
      distance: '', // Provide default value
      date: DateTime.now().toIso8601String(), // Provide default value
      rate: 0.0, // Provide default value
      isSaved: false, icon: fromDb.icon ?? '', // Provide default value
    );
  }

  @override
  Location toSql(PlaceItemModel value) {
    return Location(
      icon: value.icon,
      title: value.title,
      address: value.address,
      description: value.description,
      category: value.category,
      latitude: value.latlng.latitude,
      longitude: value.latlng.longitude,
    );
  }
}
