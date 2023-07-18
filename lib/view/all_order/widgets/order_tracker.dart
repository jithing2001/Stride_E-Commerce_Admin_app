import 'package:ecommerce_admin/constants.dart';
import 'package:ecommerce_admin/service/order_tracking_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTracker extends StatelessWidget {
  final data;
  final user;
  const OrderTracker({super.key, required this.data, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Order Status'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Order Details',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ],
            ),
            kheight30,
            Text(
              "Product Name: ${data["productName"]}",
              style: const TextStyle(fontSize: 17),
            ),
            kheight10,
            Text(
              "Product Price: ₹${data["price"]}",
              style: const TextStyle(fontSize: 17),
            ),
            kheight10,
            Text(
              "Product Size: ${data["size"]}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "Delivery Address: ${data["address"]}",
              style: const TextStyle(fontSize: 17),
            ),
            kheight10,
            Text(
              "Order Status: ${data["status"]}",
              style: const TextStyle(fontSize: 17),
            ),
            kheight10,
            ElevatedButton(
                onPressed: () async {
                  await Update().updateOrder(user, data['productName']);
                  Get.back();
                },
                child: const Text('Completed'))
          ],
        ),
      ),
    );
  }
}
