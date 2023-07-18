import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/view/all_order/tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('user_details').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError) {
              return const CircularProgressIndicator();
            }
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Get.to(Tabs(
                    user: snapshot.data!.docs[index]['email'],
                  )),
                  child: ListTile(
                      title: Center(
                    child: Text(
                      snapshot.data!.docs[index]['email'],
                    ),
                  )),
                );
              },
            );
          }),
    );
  }
}
