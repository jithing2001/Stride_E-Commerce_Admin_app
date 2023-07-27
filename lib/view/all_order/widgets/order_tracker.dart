import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:ecommerce_admin/constants.dart';
import 'package:ecommerce_admin/service/order_tracking_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTracker extends StatelessWidget {
  final data;
  final status;
  final btnTxt;
  const OrderTracker(
      {super.key,
      required this.data,
      required this.status,
      required this.btnTxt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Order Status'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 310,
                      width: 380,
                      child: AnotherCarousel(
                        images: [
                          NetworkImage('${data['image1']}'),
                          NetworkImage('${data['image2']}'),
                          NetworkImage('${data['image3']}'),
                        ],
                      )),
                ],
              ),
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
                "User: ${data["user"]}",
                style: const TextStyle(fontSize: 17),
              ),
              kheight10,
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
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await Update().updateOrder(data, status);
                      Get.back();
                    },
                    child: Text(btnTxt)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
