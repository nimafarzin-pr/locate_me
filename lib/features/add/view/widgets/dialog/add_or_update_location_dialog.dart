// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
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
import 'package:locate_me/features/home/view_model/edit_item_notifier.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../../core/common_features/category/constant/category.dart';
import '../../../../../core/common_features/category/dto/category_dto.dart';
import '../../../../../core/widget/custom_accept_button.dart';
import '../../../../../core/widget/custom_dropdwon_button.dart';
import '../../../../../core/widget/custom_textfeild.dart';

class AddOrUpdateLocationDialogView<T> extends ConsumerStatefulWidget {
  final LatLng latLng;
  final String? title;
  final String? address;
  final String? description;
  final String? category;
  final PlaceItemModel? editItem;

  final Future<void> Function(PlaceItemModel item) onAccept;

  const AddOrUpdateLocationDialogView({
    super.key,
    required this.latLng,
    this.title,
    this.address,
    this.description,
    this.category,
    required this.editItem,
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
        setState(() {
          if (widget.editItem != null) {
            _titleController.text = widget.editItem!.title;
            _addressController.text = widget.editItem!.address;
            _descriptionController.text = widget.editItem!.description;
            _categoryController.text = widget.editItem!.category;
            selectedCategory = categoryMap[widget.editItem!.category];
            rate = widget.editItem!.rate;
            date = widget.editItem!.date;
            isFavorite = widget.editItem!.isFavorite;
            _latitudeController.text =
                ref.read(editStateProvider)!.latlng.latitude.toString();
            _longitudeController.text =
                ref.read(editStateProvider)!.latlng.longitude.toString();
          } else {
            _latitudeController.text = widget.latLng.latitude.toString();
            _longitudeController.text = widget.latLng.longitude.toString();
          }
        });
      },
    );
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
                Navigator.pop(context);
              },
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: width / 1.1,
                height: width / 0.65,
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
                          ref.watch(editStateProvider) != null
                              ? LocaleKeys.edit_your_location.tr()
                              : LocaleKeys.add_new_location.tr(),
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
                            CustomDropdownField<CategoryItem>(
                              hintText: LocaleKeys.select_category.tr(),
                              items: category,
                              value: selectedCategory,
                              onChanged: (CategoryItem? newValue) {
                                setState(() {
                                  selectedCategory = newValue;
                                });
                              },
                              itemAsString: (CategoryItem item) =>
                                  item.name.tr(),
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
                                  CustomText.bodyLarge(item.name.tr()),
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
                            buttonText: widget.editItem != null
                                ? LocaleKeys.applyEdit.tr()
                                : LocaleKeys.add.tr(),
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;
                              final lat =
                                  double.parse(_latitudeController.text);
                              final lng =
                                  double.parse(_longitudeController.text);
                              final data = PlaceItemModel(
                                  icon: widget.editItem != null
                                      ? widget.editItem!.icon
                                      : MyIcons.location,
                                  id: ref.watch(editStateProvider)?.id,
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
                              if (widget.editItem != null) {
                                // ref
                                //     .read(editStateProvider.notifier)
                                //     .updatePlaceItem(null);
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
