// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:locate_me/core/extension/screen_size_extension.dart';
import 'package:locate_me/core/utils/icon_picker_utils.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/setting/model/category_model.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../../core/common_features/category/provider/category_provider.dart';
import '../../../../../core/widget/accept_button/custom_accept_button.dart';
import '../../../../../core/widget/custom_dropdwon_button.dart';
import '../../../../../core/widget/custom_textfeild.dart';
import '../../../../../core/widget/dialogs/status_widget.dart';
import '../../../../../core/widget/animation/fade_in_scale_animation.dart';

class AddLocationFormView<T> extends ConsumerStatefulWidget {
  final LatLng latLng;
  final String? title;
  final String? address;
  final String? description;
  final String? category;

  final Future<void> Function(PlaceItemModel item) onAccept;

  const AddLocationFormView({
    super.key,
    required this.latLng,
    this.title,
    this.address,
    this.description,
    this.category,
    required this.onAccept,
  });

  @override
  ConsumerState<AddLocationFormView> createState() =>
      _AddLocationViewState<T>();
}

class _AddLocationViewState<T> extends ConsumerState<AddLocationFormView> {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CategoryModel? selectedCategory;
  double rate = 5;
  String? date;
  bool isFavorite = false;
  Uint8List? selectedImage;

  @override
  void initState() {
    _latitudeController.text = widget.latLng.latitude.toString();
    _longitudeController.text = widget.latLng.longitude.toString();
    super.initState();
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

    return BackButtonListener(
      onBackButtonPressed: () async {
        if (mounted) {
          Navigator.pop(context);
        }
        return true;
      },
      child: FadeInScaleAnimation(
        child: Scaffold(
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
                    width: width / 1.1,
                    height: width / 0.62,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText.bodyLarge(
                              LocaleKeys.add_new_location.tr(),
                              customStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () async {
                                    final ImagePicker picker = ImagePicker();
                                    final XFile? image = await picker.pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 50);
                                    if (image != null) {
                                      final File imageFile = File(image.path);
                                      final bytes =
                                          await File(image.path).readAsBytes();
                                      setState(() {
                                        selectedImage = bytes;
                                      });
                                      // Now you can use the imageFile for further processing or display
                                    }
                                  },
                                  child: Material(
                                    shape: const CircleBorder(
                                      side: BorderSide(
                                          color: Colors.transparent,
                                          width: 0.6),
                                    ),
                                    elevation: 3,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: selectedImage == null
                                          ? null
                                          : Image.memory(selectedImage!).image,
                                      radius: 36,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .surface,
                                                radius: 10,
                                                child: Icon(
                                                  Icons.add,
                                                  size: 20,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                              )),
                                          selectedImage != null
                                              ? Container()
                                              : Positioned(
                                                  child: Center(
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      radius: 14,
                                                      child: Icon(
                                                        Icons
                                                            .local_see_outlined,
                                                        size: 26,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.4),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
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
                                      hintText: LocaleKeys.title.tr(),
                                      controller: _titleController,
                                    ),
                                    CustomTextField(
                                        hintText: LocaleKeys.address.tr(),
                                        controller: _addressController),
                                    CustomTextField(
                                      hintText: LocaleKeys.description.tr(),
                                      controller: _descriptionController,
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                    ref.watch(categoryNotifierProvider).when(
                                      data: (category) {
                                        return CustomDropdownField<
                                                CategoryModel>(
                                            hintText:
                                                LocaleKeys.select_category.tr(),
                                            items: category,
                                            value: selectedCategory,
                                            onChanged:
                                                (CategoryModel? newValue) {
                                              setState(() {
                                                selectedCategory = newValue;
                                              });
                                            },
                                            itemAsString:
                                                (CategoryModel item) =>
                                                    item.name,
                                            itemAsWidget: (CategoryModel item) {
                                              final icon = IconPickerUtils
                                                  .iconPickerDeserializer(
                                                      item.iconString);
                                              return Row(
                                                children: [
                                                  Icon(icon?.data),
                                                  const SizedBox(width: 8),
                                                  CustomText.bodyLarge(
                                                      item.name),
                                                ],
                                              );
                                            });
                                      },
                                      error: (error, stackTrace) {
                                        return StatusWidget(
                                          title: LocaleKeys.error.tr(),
                                          content: '$error',
                                          disableButtons: true,
                                        );
                                      },
                                      loading: () {
                                        return const Center(child: MyLoading());
                                      },
                                    ),
                                    RatingBar.builder(
                                      initialRating: rate,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
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
                                    buttonText: LocaleKeys.add.tr(),
                                    onPressed: () async {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }

                                      final lat = double.parse(
                                          _latitudeController.text);
                                      final lng = double.parse(
                                          _longitudeController.text);
                                      final iconData = IconPickerUtils
                                          .iconPickerDeserializer(
                                              selectedCategory!.iconString);
                                      final PlaceItemModel data =
                                          PlaceItemModel(
                                              picture: selectedImage != null
                                                  ? base64Encode(selectedImage!)
                                                  : "",
                                              title: _titleController.text,
                                              address: _addressController.text,
                                              description:
                                                  _descriptionController.text,
                                              date: date ??
                                                  DateTime.now()
                                                      .toIso8601String(),
                                              categoryIcon:
                                                  selectedCategory != null
                                                      ? IconPickerUtils
                                                          .iconPickerSerializer(
                                                              iconData!)
                                                      : "",
                                              categoryName:
                                                  selectedCategory != null
                                                      ? selectedCategory!.name
                                                      : "",
                                              latlng: LatLong(
                                                  latitude: lat,
                                                  longitude: lng),
                                              rate: rate,
                                              isFavorite: isFavorite);
                                      widget.onAccept(data);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
