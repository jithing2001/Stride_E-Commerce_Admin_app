import 'dart:io';

import 'package:ecommerce_admin/constants.dart';
import 'package:ecommerce_admin/controller/edit_image_controller.dart';
import 'package:ecommerce_admin/model/categorymode.dart';
import 'package:ecommerce_admin/model/product_model.dart';
import 'package:ecommerce_admin/service/brandservices.dart';
import 'package:ecommerce_admin/service/product_services.dart';
import 'package:ecommerce_admin/view/add_product/addproductfield_widgets.dart';
import 'package:ecommerce_admin/view/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatelessWidget {
  final String image;
  final String des;
  final String name;
  final String price;

  EditProduct(
      {super.key,
      required this.options,
      required this.image,
      required this.name,
      required this.price,
      required this.des});
  final List<BrandModel> options;

  late String selectedOption = options[0].category;
  EditImgController editImg = EditImgController();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: name);

    TextEditingController priceController = TextEditingController(text: price);

    TextEditingController descriptionController =
        TextEditingController(text: des);

    Future<void> editProductfunc() async {
      String? downloadImageUrl;
      if (editImg.pickedImg.isNotEmpty) {
        downloadImageUrl =
            await BrandServices().uploadImage(XFile(editImg.pickedImg.value));
      } else {
        downloadImageUrl = image;
      }
      if (downloadImageUrl == null) {
        return;
      }

      ProductModel model = ProductModel(
          ProductName: nameController.text.trim(),
          ProductPrice: priceController.text.trim(),
          ProductDes: descriptionController.text.trim(),
          ProductCategory: selectedOption,
          productImg: downloadImageUrl);

      await ProductServices().deleteProduct(name);
      await ProductServices().addProduct(model);

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return CircleAvatar(
                        radius: 90,
                        backgroundColor: kblack,
                        backgroundImage: editImg.pickedImg.isEmpty
                            ? NetworkImage(image)
                            : FileImage(File(editImg.pickedImg.value))
                                as ImageProvider);
                  })
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    editImg.changeImg();
                  },
                  child: const Text('Add New Image')),
              kheight20,
              AddProductWidget(
                  Controller: nameController,
                  title: 'Product Name',
                  hint: 'Enter the Product name'),
              AddProductWidget(
                  Controller: priceController,
                  title: 'Product Price',
                  hint: 'Enter the Product price'),
              kheight10,
              const Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              kheight5,
              SizedBox(
                height: 150,
                width: double.infinity,
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: 'write about the product',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kblack),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              kheight5,
              const Text(
                'Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              kheight10,
              SizedBox(
                height: 50,
                width: double.infinity,
                child: DropdownButtonFormField(
                  value: selectedOption,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (newValue) async {
                    // setState(() {
                    selectedOption = newValue!;
                    // });
                  },
                  items:
                      options.map<DropdownMenuItem<String>>((BrandModel value) {
                    return DropdownMenuItem<String>(
                      value: value.category,
                      child: Text(value.category),
                    );
                  }).toList(),
                ),
              ),
              kheight10,
              ElevatedButton(
                  onPressed: () async {
                    await editProductfunc();
                    Get.off(const HomeScreen());
                  },
                  child: const Text('Add'))
            ],
          ),
        ),
      ),
    );
  }
}