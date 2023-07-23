import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/model/product_model.dart';

class ProductServices {
  DocumentSnapshot<Map<String, dynamic>>? user;
  addProduct(ProductModel productModel) async {
    FirebaseFirestore ref = FirebaseFirestore.instance;
    CollectionReference collectionRef =
        ref.collection('myApp').doc('Admin').collection('products');

    DocumentReference productFile = collectionRef.doc(productModel.productName);

    await productFile.set(productModel.toJson());
  }

  deleteProduct(String name) async {
    await FirebaseFirestore.instance
        .collection('myApp')
        .doc('Admin')
        .collection('products')
        .doc(name)
        .delete();
  }

  getuser() async {
    user = await FirebaseFirestore.instance
        .collection('users')
        .doc('myorder')
        .get();
    log(user.toString());
  }

  getProduct() {
   final get= FirebaseFirestore.instance
        .collection('myApp')
        .doc('Admin')
        .collection('products')
        .get();
    
  }
}
