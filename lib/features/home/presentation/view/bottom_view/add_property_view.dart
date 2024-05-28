import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:real_estate_app/core/common/snackbar/my_snackbar.dart';
import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';
import 'package:real_estate_app/features/property/presentation/viewmodel/property_viewmodel.dart';

class AddPropertyPage extends ConsumerStatefulWidget {
  const AddPropertyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddPropertyPageState();
}

class _AddPropertyPageState extends ConsumerState<AddPropertyPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageURLController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sqmetersController = TextEditingController();
  final TextEditingController continentController = TextEditingController();
  final TextEditingController bedsController = TextEditingController();
  String selectedType = 'beach'; // Default property type
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(propertyViewModelProvider.notifier).uploadImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final propertyState = ref.watch(propertyViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Property'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildPropertyForm(),
      ),
    );
  }

  Widget _buildPropertyForm() {
    final propertyState = ref.watch(propertyViewModelProvider);
    // final authState = ref.watch(authViewModelProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.grey[300],
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            checkCameraPermission();
                            _browseImage(ref, ImageSource.camera);
                            Navigator.pop(context);
                            // Upload image it is not null
                          },
                          icon: const Icon(Icons.camera),
                          label: const Text('Camera'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            checkCameraPermission();
                            _browseImage(ref, ImageSource.gallery);
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.image),
                          label: const Text('Gallery'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: SizedBox(
                height: 200,
                width: 200,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _img != null
                      ? FileImage(_img!)
                      : const AssetImage('assets/images/profile.png')
                          as ImageProvider,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Property Title
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a title';
              }
              if (value.length < 6) {
                return 'Title must be at least 6 characters long';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Property Type Dropdown
          DropdownButtonFormField<String>(
            value: selectedType,
            items: ['beach', 'mountain', 'village']
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedType = value!;
              });
            },
            onSaved: (value) {
              selectedType = value!;
            },
            decoration: const InputDecoration(labelText: 'Type'),
          ),
          const SizedBox(height: 10),
          // Property Description
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a description';
              }
              if (value.length < 10) {
                return 'Description must be at least 10 characters long';
              }
              return null;
            },
            onSaved: (value) {
              // Save the property description.
            },
          ),
          const SizedBox(height: 10),
          // Property Image
          // You can use a package like `image_picker` to allow users to pick an image from their device.
          // Add an image picker button here.

          // Property Price
          TextFormField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Price'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a price';
              }
              return null;
            },
            onSaved: (value) {
              // Save the property price.
            },
          ),
          const SizedBox(height: 10),
          // Property Square Meters
          TextFormField(
            controller: sqmetersController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Square Meters'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the square meters';
              }

              // You can add more validation for a valid square meter value.
              return null;
            },
            onSaved: (value) {
              // Save the square meters value.
            },
          ),
          const SizedBox(height: 10),
          // Property Continent
          TextFormField(
            controller: continentController,
            decoration: const InputDecoration(labelText: 'Address'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the continent';
              }
              return null;
            },
            onSaved: (value) {
              // Save the continent value.
            },
          ),
          const SizedBox(height: 10),
          // Property Beds
          TextFormField(
            controller: bedsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Beds'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the number of beds';
              }

              // You can add more validation for a valid bed count.
              return null;
            },
            onSaved: (value) {
              // Save the number of beds.
            },
          ),
          const SizedBox(height: 10),
          // ... Add form fields for other properties ...

          Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue, // Set the background color
            ),
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Create the Property object based on the form data.
                  var newProperty = PropertyEntity(
                    title: titleController.text,
                    desc: descriptionController.text,
                    type: selectedType,
                    img: propertyState.imageName,
                    price: priceController.text,
                    sqmeters: sqmetersController.text,
                    continent: continentController.text,
                    beds: bedsController.text,
                  );

                  // Access the PropertyProvider and add the property.
                  ref
                      .read(propertyViewModelProvider.notifier)
                      .addProperty(context, newProperty);
                  if (propertyState.error != null) {
                    showSnackBar(
                      message: propertyState.error.toString(),
                      context: context,
                      color: Colors.red,
                    );
                  } else {
                    showSnackBar(
                      message: 'Property added successfully',
                      context: context,
                    );
                  }
                  // Navigate back to the previous screen or perform any other action.
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Add Property',
                style: TextStyle(
                  color: Colors.white, // Set the text color
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    imageURLController.dispose();
    priceController.dispose();
    sqmetersController.dispose();
    continentController.dispose();
    bedsController.dispose();
    super.dispose();
  }
}
