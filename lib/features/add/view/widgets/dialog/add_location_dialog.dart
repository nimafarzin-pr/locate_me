import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/resources/icons.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../../../core/constant/category.dart';
import '../../../../../core/dto/category_dto.dart';

import '../../../../../core/widget/custom_accept_button.dart';
import '../../../../../core/widget/custom_dropdwon_button.dart';
import '../../../../../core/widget/custom_textfeild.dart';

class AddLocationView<T> extends StatefulWidget {
  final LatLng latLng;
  final Future<void> Function(T item) onAccept;

  const AddLocationView({
    super.key,
    required this.onAccept,
    required this.latLng,
  });

  @override
  State<AddLocationView<T>> createState() => _AddLocationViewState<T>();
}

class _AddLocationViewState<T> extends State<AddLocationView<T>> {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CategoryItem? selectedCategory;
  double rate = 5;

  @override
  void initState() {
    super.initState();
    _latitudeController.text = widget.latLng.latitude.toString();
    _longitudeController.text = widget.latLng.longitude.toString();
  }

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    _titleController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = context.screenWidth;
    double height = context.screenHeight;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            InkWell(
              onTap: () {
                context.pop();
              },
            ),
            Center(
              child: Container(
                width: width / 1.1,
                height: height / 1.2,
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Save you location',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  hintText: 'latitude',
                                  controller: _latitudeController),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomTextField(
                                  hintText: 'longitude',
                                  controller: _longitudeController),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomTextField(
                              hintText: 'title',
                              controller: _titleController,
                            ),
                            CustomTextField(
                                hintText: 'address',
                                controller: _addressController),
                            CustomTextField(
                              hintText: 'description',
                              controller: _descriptionController,
                              validator: (value) {
                                return null;
                              },
                            ),
                            CustomDropdownField<CategoryItem>(
                              hintText: 'Select a category',
                              items: category,
                              value: selectedCategory,
                              onChanged: (CategoryItem? newValue) {
                                setState(() {
                                  selectedCategory = newValue;
                                });
                              },
                              itemAsString: (CategoryItem item) => item.name,
                              itemAsWidget: (CategoryItem item) => Row(
                                children: [
                                  Image(
                                    width: 40,
                                    height: 40,
                                    image: AssetImage(item.icon),
                                    color: item.color,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(item.name),
                                ],
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const FaIcon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                log('$rating');
                                setState(() {
                                  rate = rating;
                                });
                                log('$rate');
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            )
                          ],
                        ),
                        Center(
                          child: AcceptButton(
                            buttonText: 'Accept',
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;
                              final lat =
                                  double.parse(_latitudeController.text);
                              final lng =
                                  double.parse(_longitudeController.text);
                              final data = PlaceItemModel(
                                  icon: MyIcons.location,
                                  title: _titleController.text,
                                  address: _addressController.text,
                                  distance: "",
                                  date: DateTime.now().toIso8601String(),
                                  category: selectedCategory != null
                                      ? selectedCategory!.name
                                      : "",
                                  latlng:
                                      LatLong(latitude: lat, longitude: lng),
                                  rate: rate,
                                  isFavorite: false);
                              await widget.onAccept(data as T);
                              context.pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
