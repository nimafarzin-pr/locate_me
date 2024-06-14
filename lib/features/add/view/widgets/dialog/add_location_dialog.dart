// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/resources/icons.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../../../core/constant/category.dart';
import '../../../../../core/dto/category_dto.dart';
import '../../../../../core/widget/custom_accept_button.dart';
import '../../../../../core/widget/custom_dropdwon_button.dart';
import '../../../../../core/widget/custom_textfeild.dart';
import '../../../../home/provider/edit_item_provider.dart';

class AddOrUpdateLocationDialogView<T> extends ConsumerStatefulWidget {
  final LatLng latLng;
  final String? title;
  final String? address;
  final String? description;
  final String? category;

  final Future<void> Function(PlaceItemModel item) onAccept;

  const AddOrUpdateLocationDialogView({
    super.key,
    required this.latLng,
    this.title,
    this.address,
    this.description,
    this.category,
    required this.onAccept,
  });

  @override
  ConsumerState<AddOrUpdateLocationDialogView> createState() =>
      _AddLocationViewState<T>();
}

class _AddLocationViewState<T>
    extends ConsumerState<AddOrUpdateLocationDialogView> {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CategoryItem? selectedCategory;
  double rate = 5;
  String? date;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then(
      (value) async {
        final edit = ref.watch(editItemProvider);
        log('>>>>> $edit');
        if (edit != null) {
          setState(() {
            // _latitudeController.text = edit.latlng.latitude.toString();
            // _longitudeController.text = edit.latlng.longitude.toString();
            _titleController.text = edit.title;
            _addressController.text = edit.address;
            _descriptionController.text = edit.description;
            _categoryController.text = edit.category;
            selectedCategory = categoryMap[edit.category];
            rate = edit.rate;
            date = edit.date;
            isFavorite = edit.isFavorite;
          });
        }
      },
    );

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
    final editState = ref.watch(editItemProvider);
    final isEditMode = ref.watch(isEditModeProvider);

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: width / 1.1,
                height: width / 0.6,
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
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
                        CustomText.bodyLarge(
                          'Save you location',
                          customStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  readOnly: true,
                                  hintText: 'latitude',
                                  controller: _latitudeController),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomTextField(
                                  readOnly: true,
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
                                    width: 30,
                                    height: 30,
                                    image: AssetImage(item.icon),
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                  const SizedBox(width: 8),
                                  CustomText.bodyLarge(item.name),
                                ],
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: rate,
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
                                  icon: isEditMode
                                      ? editState!.icon
                                      : MyIcons.location,
                                  id: ref.watch(editItemProvider)?.id,
                                  title: _titleController.text,
                                  address: _addressController.text,
                                  description: _descriptionController.text,
                                  date:
                                      date ?? DateTime.now().toIso8601String(),
                                  category: selectedCategory != null
                                      ? selectedCategory!.name
                                      : "",
                                  latlng:
                                      LatLong(latitude: lat, longitude: lng),
                                  rate: rate,
                                  isFavorite: isFavorite);
                              await widget.onAccept(data);
                              Navigator.pop(context);
                              if (isEditMode) {
                                ref
                                    .read(editItemProvider.notifier)
                                    .updatePlaceItem(null);
                                context.pop();
                              }
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
