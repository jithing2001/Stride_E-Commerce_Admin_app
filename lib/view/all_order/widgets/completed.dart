import 'package:ecommerce_admin/view/all_order/widgets/order_tracker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletedOrder extends StatelessWidget {
  const CompletedOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(12.0),
            child: SizedBox(
              height: 110,
              width: double.infinity,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Adidas Evolve',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('Order id: 2639741'),
                      Text('Quantity: 1'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('₹1500'),
                          Text(
                            'Completed',
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          )
                        ],
                      )
                    ],
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
