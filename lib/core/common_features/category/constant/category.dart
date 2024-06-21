import 'package:flutter/material.dart';
import 'package:locate_me/core/resources/icons.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../dto/category_dto.dart';

List<CategoryItem> category = [
  CategoryItem(
      translationKey: LocaleKeys.all,
      icon: MyIcons.location,
      name: LocaleKeys.all,
      color: Colors.teal),
  CategoryItem(
      translationKey: LocaleKeys.travel,
      icon: MyIcons.travel,
      name: LocaleKeys.travel,
      color: Colors.teal),
  CategoryItem(
      translationKey: LocaleKeys.home,
      icon: MyIcons.home,
      name: LocaleKeys.home,
      color: Colors.blue),
  CategoryItem(
      translationKey: LocaleKeys.cafe,
      icon: MyIcons.cafe,
      name: LocaleKeys.cafe,
      color: Colors.brown),
  CategoryItem(
      translationKey: LocaleKeys.street,
      icon: MyIcons.street,
      name: LocaleKeys.street,
      color: Colors.grey),
  CategoryItem(
      translationKey: LocaleKeys.store,
      icon: MyIcons.store,
      name: LocaleKeys.store,
      color: Colors.redAccent),
  CategoryItem(
      translationKey: LocaleKeys.hospital,
      icon: MyIcons.hospital,
      name: LocaleKeys.hospital,
      color: Colors.red),
  CategoryItem(
      translationKey: LocaleKeys.office,
      icon: MyIcons.office,
      name: LocaleKeys.office,
      color: Colors.indigo),
  CategoryItem(
      translationKey: LocaleKeys.gym,
      icon: MyIcons.gym,
      name: LocaleKeys.gym,
      color: Colors.green),
  CategoryItem(
      translationKey: LocaleKeys.restaurant,
      icon: MyIcons.restaurant,
      name: LocaleKeys.restaurant,
      color: Colors.deepOrange),
  CategoryItem(
      translationKey: LocaleKeys.beach,
      icon: MyIcons.beach,
      name: LocaleKeys.beach,
      color: Colors.lightBlue),
  CategoryItem(
      translationKey: LocaleKeys.school,
      icon: MyIcons.school,
      name: LocaleKeys.school,
      color: Colors.yellow),
  CategoryItem(
      translationKey: LocaleKeys.college,
      icon: MyIcons.college,
      name: LocaleKeys.college,
      color: Colors.purple),
  CategoryItem(
      translationKey: LocaleKeys.airport,
      icon: MyIcons.airport,
      name: LocaleKeys.airport,
      color: Colors.blue),
  CategoryItem(
      translationKey: LocaleKeys.metro,
      icon: MyIcons.metro,
      name: LocaleKeys.metro,
      color: Colors.yellowAccent),
];

Map<String, CategoryItem> categoryMap = {
  for (var item in category) item.name: item
};
