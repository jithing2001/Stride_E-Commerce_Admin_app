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
  final String image1;
  final String image2;
  final String image3;
  final String des;
  final String name;
  final String productPrice;
  final String sellingPrice;

  EditProduct(
      {super.key,
      required this.options,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.name,
      required this.productPrice,
      required this.sellingPrice,
      required this.des});
  final List<BrandModel> options;

  late String selectedOption = options[0].category;
  EditImgController editImg = EditImgController();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: name);

    TextEditingController priceController =
        TextEditingController(text: productPrice);
    TextEditingController sellingPriceController =
        TextEditingController(text: productPrice);

    TextEditingController descriptionController =
        TextEditingController(text: des);

    Future<void> editProductfunc() async {
      String? downloadImageUrl1;
      String? downloadImageUrl2;
      String? downloadImageUrl3;

      // Check if any image is edited and upload the new image
      if (editImg.pickedImg.isNotEmpty) {
        if (editImg.selectedIndex == 0) {
          downloadImageUrl1 =
              await BrandServices().uploadImage(XFile(editImg.pickedImg.value));
        } else if (editImg.selectedIndex == 1) {
          downloadImageUrl2 =
              await BrandServices().uploadImage(XFile(editImg.pickedImg.value));
        } else if (editImg.selectedIndex == 2) {
          downloadImageUrl3 =
              await BrandServices().uploadImage(XFile(editImg.pickedImg.value));
        }
      }

      ProductModel model = ProductModel(
          productName: nameController.text.trim(),
          productPrice: priceController.text.trim(),
          discountPrice: sellingPriceController.text.trim(),
          productDes: descriptionController.text.trim(),
          ProductCategory: selectedOption,
          productImg1: downloadImageUrl1 ?? '',
          productImg2: downloadImageUrl2 ?? '',
          productImg3: downloadImageUrl3 ?? '');

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
                  Column(
                    children: [
                      for (int i = 0; i < 3; i++)
                        GestureDetector(
                          onTap: () => editImg.changeImg(i),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: editImg.pickedImages[i].isEmpty
                                ? NetworkImage(i == 0
                                    ? image1
                                    : (i == 1 ? image2 : image3))
                                : FileImage(File(editImg.pickedImages[i]))
                                    as ImageProvider<Object>?,
                          ),
                        ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  ...List.generate(
                      3,
                      (index) => ElevatedButton(
                            onPressed: () async => editImg.changeImg(index),
                            child: Text('Change Image ${index + 1}'),
                          )),
                ],
              ),
              kheight20,
              AddProductWidget(
                  Controller: nameController,
                  title: 'Product Name',
                  hint: 'Enter the Product name'),
              AddProductWidget(
                  Controller: priceController,
                  title: 'Product Price',
                  hint: 'Enter the Product price'),
              AddProductWidget(
                  Controller: sellingPriceController,
                  title: 'Selling Price',
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
                  child: const Text('edit'))
            ],
          ),
        ),
      ),
    );
  }

  Widget displayCurrentImage(String imagePath) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: NetworkImage(imagePath),
    );
  }
}
