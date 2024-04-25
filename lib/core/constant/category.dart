import 'package:flutter/material.dart';
import 'package:locate_me/core/resources/icons.dart';
import 'package:locate_me/core/widget/category_item.dart';

List<CategoryItem> category = [
  CategoryItem(icon: MyIcons.home, name: 'Home', color: Colors.blue),
  CategoryItem(icon: MyIcons.cafe, name: 'Cafe', color: Colors.brown),
  CategoryItem(icon: MyIcons.street, name: 'Street', color: Colors.grey),
  CategoryItem(
    icon: MyIcons.store,
    name: 'Store',
  ),
  CategoryItem(icon: MyIcons.hospital, name: 'Hospital', color: Colors.red),
  CategoryItem(icon: MyIcons.location, name: 'Other', color: Colors.teal),
  CategoryItem(icon: MyIcons.office, name: 'Office', color: Colors.indigo),
  CategoryItem(icon: MyIcons.gym, name: 'Gym', color: Colors.green),
  CategoryItem(
      icon: MyIcons.restaurant, name: 'Restaurant', color: Colors.deepOrange),
  CategoryItem(icon: MyIcons.beach, name: 'Beach', color: Colors.lightBlue),
  CategoryItem(icon: MyIcons.school, name: 'School', color: Colors.yellow),
  CategoryItem(icon: MyIcons.college, name: 'College', color: Colors.purple),
  CategoryItem(icon: MyIcons.airport, name: 'Airport', color: Colors.blue),
  CategoryItem(icon: MyIcons.metro, name: 'Metro', color: Colors.yellowAccent),
];
