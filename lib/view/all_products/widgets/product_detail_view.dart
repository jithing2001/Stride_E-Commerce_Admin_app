import 'package:ecommerce_admin/constants.dart';
import 'package:ecommerce_admin/model/categorymode.dart';
import 'package:ecommerce_admin/service/brandservices.dart';
import 'package:ecommerce_admin/service/product_services.dart';
import 'package:ecommerce_admin/view/edit_product/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailView extends StatelessWidget {
  String? imgPath;
  String? productNames;
  String? productDes;
  String? productRate;
  ProductDetailView(
      {super.key,
      required this.imgPath,
      required this.productNames,
      required this.productDes,
      required this.productRate});

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
                  image:imgPath!,
                  des: productDes!,
                  name: productNames!,
                  price: productRate!,
                ));
              },
              icon: Icon(
                Icons.edit,
                color: kblack,
              )),
          IconButton(
              onPressed: () async {
                await ProductServices().deleteProduct('$productNames');
                Get.back();
              },
              icon: Icon(
                Icons.delete,
                color: kblack,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kheight90,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 400,
                child: Image(
                  image: NetworkImage('$imgPath'),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          kheight20,
          Row(
            children: [
              kwidth50,
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
              kwidth50,
              Text(
                '₹$productRate',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          kheight20,
          Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Text(
              '$productDes',
              style: TextStyle(fontSize: 15),
            ),
          )),
        ],
      ),
    );
  }
}
