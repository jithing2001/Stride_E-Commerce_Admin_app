import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:ecommerce_admin/constants.dart';
import 'package:ecommerce_admin/model/categorymode.dart';
import 'package:ecommerce_admin/service/brandservices.dart';
import 'package:ecommerce_admin/service/product_services.dart';
import 'package:ecommerce_admin/view/edit_product/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailView extends StatelessWidget {
  String? imgPath1;
  String? imgPath2;
  String? imgPath3;
  String? productNames;
  String? productDes;
  String? productRate;
  String? sellingPrice;
  ProductDetailView(
      {super.key,
      required this.imgPath1,
      required this.imgPath2,
      required this.imgPath3,
      required this.productNames,
      required this.productDes,
      required this.productRate,
      required this.sellingPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: kwhite,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: kblack,
            )),
        actions: [
          IconButton(
              onPressed: () async {
                List<BrandModel> list = await BrandServices().getCategories();
                
                Get.to(EditProduct(
                  options: list,
                  image1: imgPath1!,
                  image2: imgPath2!,
                  image3: imgPath3!,
                  des: productDes!,
                  name: productNames!,
                  productPrice: productRate!,
                  sellingPrice: sellingPrice!,
                ));
              },
              icon: Icon(
                Icons.edit,
                color: kblack,
              )),
          IconButton(
              onPressed: () async {
                Get.dialog(AlertDialog(
                  content: SizedBox(
                    height: 100,
                    width: 100,
                    child: Column(
                      children: [
                        const Text('Are you sure?'),
                        kheight30,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await ProductServices()
                                    .deleteProduct(productNames!);
                                Get.back();
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            kwidth40,
                            InkWell(
                                onTap: () => Get.back(),
                                child: const Text('No',
                                    style: TextStyle(fontSize: 20)))
                          ],
                        )
                      ],
                    ),
                  ),
                ));
              },
              icon: Icon(
                Icons.delete,
                color: kblack,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kheight30,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 300,
                    width: 400,
                    child: AnotherCarousel(
                      images: [
                        NetworkImage('$imgPath1'),
                        NetworkImage('$imgPath2'),
                        NetworkImage('$imgPath3'),
                      ],
                    )
                    ),
              ],
            ),
            kheight20,
            Row(
              children: [
                kwidth25,
                SizedBox(
                  width: 350,
                  child: Text(
                    '$productNames',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                kwidth25,
                Text(
                  '₹$productRate',
                  style: const TextStyle(
                      fontSize: 30,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.red),
                ),
                kwidth10,
                Text(
                  '₹$sellingPrice',
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            ),
            kheight20,
            Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Text(
                '$productDes',
                style: const TextStyle(fontSize: 15),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
