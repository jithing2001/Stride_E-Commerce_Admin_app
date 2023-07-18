import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/view/all_order/widgets/order_tracker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveOrder extends StatelessWidget {
  final user;
  const ActiveOrder({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc('myorder')
              .collection(user)
              .where('status', isEqualTo: 'active')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
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
                                snapshot.data!.docs[index]["productName"],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'Size: ${snapshot.data!.docs[index]['size']}'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₹${snapshot.data!.docs[index]['price']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () => Get.to( OrderTracker(data: snapshot.data!.docs[index],user: user,)),
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
