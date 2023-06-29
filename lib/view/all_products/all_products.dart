import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
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

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          // final productData = products[index].data();
                          // final productDoc = snapshot.data!.docs[index];
                          // final categoryId = productDoc.id;

                          return InkWell(
                            onTap: () {
                              Get.to(ProductDetailView(
                                imgPath: snapshot.data!.docs[index]
                                    ['productImg'],
                                productNames: snapshot.data!.docs[index]
                                    ['productName'],
                                productDes: snapshot.data!.docs[index]
                                    ['ProductDes'],
                                productRate: snapshot.data!.docs[index]
                                    ['ProductPrice'],
                              ));
                              log(index.toString());
                            },
                            child: ProductGridView(
                              imgPath: snapshot.data!.docs[index]['productImg'],
                              productName: snapshot.data!.docs[index]
                                  ['productName'],
                              productRate: snapshot.data!.docs[index]
                                  ['ProductPrice'],
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
