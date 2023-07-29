import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/model/order_model.dart';
import 'package:ecommerce_admin/view/all_order/widgets/order_tracker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveOrder extends StatelessWidget {
  // final user;
  const ActiveOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc('myorder')
              .collection('allOrders')
              .where('status', isEqualTo: 'active')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError) {
              return const CircularProgressIndicator();
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('Data is empty'),
              );
            }
            log(snapshot.data!.docs.length.toString());
            List<OrderModel> allOrderModel = [];
            allOrderModel.addAll(
                snapshot.data!.docs.map((e) => OrderModel.fromJson(e.data())));

            return ListView.builder(
              itemCount: allOrderModel.length,
              itemBuilder: (context, index) {
                return InkWell(
                  // onTap: () => Get.to(OrderTrackerClass(
                  //     user: user,
                  //     stIndex: index,
                  //     productName: snapshot.data!.docs[index]['productName'])),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 110,
                      width: double.infinity,
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allOrderModel[index].productName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text('Size: ${allOrderModel[index].productSize}'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₹${allOrderModel[index].discountPrice}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () => Get.to(OrderTracker(
                                      data: snapshot.data!.docs[index],
                                      status: 'completed',
                                      btnTxt: 'Delivered',
                                    )),
                                    child: const Text(
                                      'Track',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const Text(
                                'Active',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
