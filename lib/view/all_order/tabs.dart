import 'package:ecommerce_admin/view/all_order/all_order.dart';
import 'package:ecommerce_admin/view/all_order/widgets/completed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tabs extends StatelessWidget {
  final user;
  const Tabs({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
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
            ActiveOrder(user: user),
            CompletedOrder(user: user),
          ],
        ),
      ),
    );
  }
}
