import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/model/product_model.dart';

class ProductServices {
  addProduct(ProductModel productModel) async {
    FirebaseFirestore ref = FirebaseFirestore.instance;
    CollectionReference collectionRef =
        ref.collection('myApp').doc('Admin').collection('products');

    DocumentReference productFile = collectionRef.doc(productModel.ProductName);

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
}