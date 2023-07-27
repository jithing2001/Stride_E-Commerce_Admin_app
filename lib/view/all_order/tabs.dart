import 'package:ecommerce_admin/view/all_order/widgets/active.dart';
import 'package:ecommerce_admin/view/all_order/widgets/completed.dart';
import 'package:ecommerce_admin/view/all_order/widgets/pending.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tabs extends StatelessWidget {
  // final user;
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Active'),
              Tab(
                text: 'Completed',
              ),
            ],
          ),
          title: const Text('All Orders'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: TabBarView(
          children: [
            const Pending_Orders(),
            const ActiveOrder(),
            CompletedOrder()
          ],
        ),
      ),
    );
  }
}
