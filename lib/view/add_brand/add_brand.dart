import 'dart:io';

import 'package:ecommerce_admin/constants.dart';
import 'package:ecommerce_admin/service/brandservices.dart';
import 'package:ecommerce_admin/view/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddBrand extends StatefulWidget {
  const AddBrand({super.key});

  @override
  State<AddBrand> createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  TextEditingController brandController = TextEditingController();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Brand'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            kheight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundColor: kblack,
                  backgroundImage:
                      image != null ? FileImage(File(image!.path)) : null,
                ),
              ],
            ),
            kheight20,
            ElevatedButton(
                onPressed: () async {
                  final pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    setState(() {
                      image = pickedImage;
                    });
                  }
                },
                child: const Text('Select a Image')),
            kheight20,
            TextFormField(
              controller: brandController,
              decoration: InputDecoration(
                  hintText: 'Enter Brand Name',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: kblack),
                      borderRadius: BorderRadius.circular(10))),
            ),
            kheight10,
            SizedBox(
                width: 130,
                height: 40,
                child: ElevatedButton(
                    onPressed: () async {
                      await addCategory();
                      Get.snackbar(
                        'Added Brand Successful',
                        'Brand added successfully',
                      );
                      brandController.clear();
                      image = null;
                      Get.off(const HomeScreen());
                      // BrandModel.getCategories();
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.add),
                        Text('Add Brand'),
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  Future<void> addCategory() async {
    if (image == null) {
      return;
    }
    final downloadImageUrl = await BrandServices().uploadImage(image!);
    await BrandServices().addCategory(
        category: brandController.text.trim(), image: downloadImageUrl);
  }
}
