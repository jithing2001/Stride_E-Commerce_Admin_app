import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/model/categorymode.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class BrandServices {
  Future<String> uploadImage(XFile image) async {
    try {
      final path = 'files/${image.name}';
      final file = File(image.path);
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      return urlDownload;
    } catch (error) {
      return '';
    }
  }

  Future<void> addCategory({
    required String category,
    required String image,
  }) async {
    final collectionRef = FirebaseFirestore.instance
        .collection('myApp')
        .doc('Admin')
        .collection('Category');

    final docRef = collectionRef.doc(category);

    final brand = BrandModel(category: category, image: image);
    final json = brand.toJson();

    await docRef.set(json);
  }

  Future<List<BrandModel>> getCategories() async {
    List<BrandModel> brandList = [];
    final querySnapshot = await FirebaseFirestore.instance
        .collection('myApp')
        .doc('Admin')
        .collection('Category')
        .get();

    List data = querySnapshot.docs;

    for (var element in data) {
      BrandModel model =
          BrandModel(category: element['category'], image: element['image']);
      brandList.add(model);
    }
    return brandList;
  }
}
