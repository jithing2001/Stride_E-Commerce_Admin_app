import 'package:ecommerce_admin/view/all_order/widgets/order_tracker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveOrder extends StatelessWidget {
  const ActiveOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Get.to(const OrderTrackerClass()),
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
                        const Text(
                          'Adidas Evolve',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Text('Order id: 2639741'),
                        const Text('Quantity: 1'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('₹1500'),
                            InkWell(
                              onTap: () => Get.to(const OrderTrackerClass()),
                              child: const Text(
                                'Track',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
