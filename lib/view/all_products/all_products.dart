import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/model/product_model.dart';
import 'package:ecommerce_admin/view/all_products/widgets/product_detail_view.dart';
import 'package:ecommerce_admin/view/all_products/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Builder(builder: (context) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('myApp')
                        .doc('Admin')
                        .collection('products')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      // print(snapshot.data!.docs.map((e) => e.data()));

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.9,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          List<ProductModel> allProductModel = [];
                          allProductModel.addAll(snapshot.data!.docs
                              .map((e) => ProductModel.fromJson(e.data())));
                          

                          return InkWell(
                            onTap: () {
                              Get.to(ProductDetailView(
                                imgPath1: allProductModel[index].productImg1,
                                imgPath2: allProductModel[index].productImg2,
                                imgPath3: allProductModel[index].productImg3,
                                productNames:
                                    allProductModel[index].productName,
                                productDes: allProductModel[index].productDes,
                                productRate:
                                    allProductModel[index].productPrice,
                                sellingPrice:
                                    allProductModel[index].discountPrice,
                              ));
                              log(index.toString());
                            },
                            child: ProductGridView(
                              imgPath: allProductModel[index].productImg1,
                              productName: allProductModel[index].productName,
                              productRate: allProductModel[index].discountPrice,
                            ),
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    });
              }))
            ],
          ),
        ));
  }
}
