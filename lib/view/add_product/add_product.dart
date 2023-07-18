import 'dart:io';
import 'package:ecommerce_admin/constants.dart';
import 'package:ecommerce_admin/model/categorymode.dart';
import 'package:ecommerce_admin/model/product_model.dart';
import 'package:ecommerce_admin/service/brandservices.dart';
import 'package:ecommerce_admin/service/product_services.dart';
import 'package:ecommerce_admin/view/add_product/addproductfield_widgets.dart';
import 'package:ecommerce_admin/view/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key, required this.options});
  final List<BrandModel> options;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  XFile? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late String selectedOption = widget.options[0].category;
  @override
  Widget build(BuildContext context) {
    // final snap = FirebaseFirestore.instance
    //     .collection('myApp')
    //     .doc('Admin')
    //     .collection('Category')
    //     .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
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
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: kblack,
                    backgroundImage:
                        image != null ? FileImage(File(image!.path)) : null,
                  )
                ],
              ),
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
                  child: const Text('Add Image')),
              kheight20,
              AddProductWidget(
                  Controller: nameController,
                  title: 'Product Name',
                  hint: 'Enter the Product name'),
              AddProductWidget(
                  Controller: productPriceController,
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
                    setState(() {
                      selectedOption = newValue!;
                    });
                  },
                  items: widget.options
                      .map<DropdownMenuItem<String>>((BrandModel value) {
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
                    await AddProductfunc();
                    Get.off(const HomeScreen());
                  },
                  child: const Text('Add'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> AddProductfunc() async {
    final downloadImageUrl = await BrandServices().uploadImage(image!);

    ProductModel model = ProductModel(
        productName: nameController.text,
        productPrice: productPriceController.text,
        discountPrice: sellingPriceController.text,
        productDes: descriptionController.text,
        ProductCategory: selectedOption,
        productImg: downloadImageUrl);

    await ProductServices().addProduct(model);
  }
}
