import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/resources/icons.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../../../core/widget/custom_accept_button.dart';

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
                width: 400,
                height: 500,
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
                              hintText: 'title', controller: _titleController),
                          CustomTextField(
                              hintText: 'address',
                              controller: _addressController),
                          CustomTextField(
                              hintText: 'description',
                              controller: _descriptionController),
                          CustomTextField(
                              hintText: 'category',
                              controller: _categoryController),
                        ],
                      ),
                      Center(
                        child: AcceptButton(
                          buttonText: 'Accept',
                          onPressed: () async {
                            final lat = double.parse(_latitudeController.text);
                            final lng = double.parse(_longitudeController.text);
                            final data = PlaceItemModel(
                                icon: MyIcons.location,
                                title: _titleController.text,
                                address: _addressController.text,
                                distance: "",
                                date: DateTime.now().toIso8601String(),
                                category: "",
                                latlng: LatLong(latitude: lat, longitude: lng),
                                rate: 2,
                                isSaved: false);
                            await widget.onAccept(data as T);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.greenAccent,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.greenAccent,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.lightGreen,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 2.0,
            ),
          ),
        ),
        cursorColor: Colors.blueAccent,
      ),
    );
  }
}
