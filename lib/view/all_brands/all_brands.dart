import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/model/categorymode.dart';
import 'package:ecommerce_admin/view/brand_wise/brand_wise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brands'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('myApp')
              .doc('Admin')
              .collection('Category')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 20,
              ),
              itemBuilder: (context, index) {
                List<BrandModel> allBrandModel = [];
                allBrandModel.addAll(snapshot.data!.docs
                    .map((e) => BrandModel.fromJson(e.data())));
                final categoryDoc = snapshot.data!.docs[index];
                final categoryId = categoryDoc.id;
                return InkWell(
                  onTap: () =>
                      Get.to(BrandWise(title: allBrandModel[index].category)),
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black,
                        backgroundImage:
                            NetworkImage(allBrandModel[index].image)),
                    title: Text(
                      snapshot.data!.docs[index]['category'],
                      style: const TextStyle(fontSize: 25),
                    ),
                    trailing: IconButton(
                        onPressed: () async {
                          try {
                            await FirebaseFirestore.instance
                                .collection('myApp')
                                .doc('Admin')
                                .collection('Category')
                                .doc(categoryId)
                                .delete();
                          } catch (error) {
                            print('Failed to delete category: $error');
                          }
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
            );
          }),
    );
  }
}
