import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/view/all_products/widgets/product_detail_view.dart';
import 'package:ecommerce_admin/view/all_products/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandWise extends StatelessWidget {
  final String title;
  const BrandWise({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('myApp')
              .doc('Admin')
              .collection('products')
              .where('productCategory', isEqualTo: title)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const CircularProgressIndicator();
            }
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.9,
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => Get.to(ProductDetailView(
                  imgPath1: snapshot.data!.docs[index]['productImg1'],
                  imgPath2: snapshot.data!.docs[index]['productImg2'],
                  imgPath3: snapshot.data!.docs[index]['productImg3'],
                  productNames: snapshot.data!.docs[index]['productName'],
                  productDes: snapshot.data!.docs[index]['productDes'],
                  productRate: snapshot.data!.docs[index]['productPrice'],
                  sellingPrice: snapshot.data!.docs[index]['discountPrice'],
                )),
                child: ProductGridView(
                    imgPath: snapshot.data!.docs[index]['productImg1'],
                    productName: snapshot.data!.docs[index]['productName'],
                    productRate: snapshot.data!.docs[index]['discountPrice']),
              ),
            );
          }),
    );
  }
}
