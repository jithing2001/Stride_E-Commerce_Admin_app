import 'dart:developer';
import 'dart:io';
import 'package:ecommerce_admin/constants.dart';
import 'package:ecommerce_admin/controller/edit_image_controller.dart';
import 'package:ecommerce_admin/controller/image_controller.dart';
import 'package:ecommerce_admin/model/categorymode.dart';
import 'package:ecommerce_admin/model/product_model.dart';
import 'package:ecommerce_admin/service/brandservices.dart';
import 'package:ecommerce_admin/service/product_services.dart';
import 'package:ecommerce_admin/view/add_product/addproductfield_widgets.dart';
import 'package:ecommerce_admin/view/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
  XFile? image1;
  XFile? image2;
  XFile? image3;
  @override
  Widget build(BuildContext context) {
    // final snap = FirebaseFirestore.instance
    //     .collection('myApp')
    //     .doc('Admin')
    //     .collection('Category')
    //     .snapshots();
    final ImageAddNotifier imageControllere = Get.put(ImageAddNotifier());
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
              GetBuilder<ImageAddNotifier>(builder: (imageController) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      color: imageController.selectedIndex == null
                          ? const Color(0xFF2C2B2B)
                          : kwhite,
                      child: imageController.selectedIndex == null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Image",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: kwhite),
                                ),
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: kwhite,
                                  size: 28,
                                )
                              ],
                            )
                          : Center(
                              child: SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.file(
                                  File(imageController.imageList[
                                      imageController.selectedIndex!]),
                                  // fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => InkWell(
                                    onTap: () async {
                                      if (index ==
                                          (imageController.imageList.length)) {
                                        final pickedFile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        if (pickedFile != null) {
                                          if (index == 0) {
                                            image1 = pickedFile;
                                          } else if (index == 1) {
                                            image2 = pickedFile;
                                          } else if (index == 2) {
                                            image3 = pickedFile;
                                          }
                                          imageController.imageAdd(
                                              imagePath: pickedFile.path,
                                              index: index);
                                        }
                                      } else {
                                        imageController.changeIndex(
                                            index: index);
                                      }
                                    },
                                    child: Center(
                                      child: index ==
                                              imageController.imageList.length
                                          ? Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color:
                                                      const Color(0xFF2C2B2B)),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add_a_photo_outlined,
                                                  color: kwhite,
                                                ),
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 35,
                                              backgroundImage: FileImage(
                                                File(imageController
                                                    .imageList[index]),
                                              ),
                                            ),
                                    ),
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 20,
                                  ),
                              itemCount: imageController.imageList.length < 3
                                  ? imageController.imageList.length + 1
                                  : 3)
                        ],
                      ),
                    ),
                  ],
                );
              }),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CircleAvatar(
              //       radius: 90,
              //       backgroundColor: kblack,
              //       backgroundImage:
              //           image != null ? FileImage(File(image!.path)) : null,
              //     )
              //   ],
              // ),
              // ElevatedButton(
              //     onPressed: () async {
              //       final pickedImage = await ImagePicker()
              //           .pickImage(source: ImageSource.gallery);
              //       if (pickedImage != null) {
              //         setState(() {
              //           image = pickedImage;
              //         });
              //       }
              //     },
              //     child: const Text('Add Image')),
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
                    Get.dialog(Center(
                      child: LoadingAnimationWidget.waveDots(
                          color: Colors.white, size: 50),
                    ));
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
    log('enter');
    final downloadImageUrl1 = await BrandServices().uploadImage(image1!);
    log('1');
    final downloadImageUrl2 = await BrandServices().uploadImage(image2!);
    log('2');

    final downloadImageUrl3 = await BrandServices().uploadImage(image3!);
    log('3');

    ProductModel model = ProductModel(
      productName: nameController.text,
      productPrice: productPriceController.text,
      discountPrice: sellingPriceController.text,
      productDes: descriptionController.text,
      ProductCategory: selectedOption,
      productImg1: downloadImageUrl1,
      productImg2: downloadImageUrl2,
      productImg3: downloadImageUrl3,
    );
    log('model');

    await ProductServices().addProduct(model);
  }
}
