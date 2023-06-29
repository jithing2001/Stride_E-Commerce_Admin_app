import 'package:ecommerce_admin/model/categorymode.dart';
import 'package:ecommerce_admin/model/product_model.dart';
import 'package:ecommerce_admin/service/brandservices.dart';
import 'package:ecommerce_admin/view/add_brand/add_brand.dart';
import 'package:ecommerce_admin/view/add_product/add_product.dart';
import 'package:ecommerce_admin/view/all_brands/all_brands.dart';
import 'package:ecommerce_admin/view/all_order/all_order.dart';
import 'package:ecommerce_admin/view/all_order/tabs.dart';
import 'package:ecommerce_admin/view/all_products/all_products.dart';
import 'package:ecommerce_admin/view/home/widgets/homescreenwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stride Admin Panel',
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                InkWell(
                    onTap: () => Get.to(const AllProducts()),
                    child: HomeListWidgets(title: 'All Products')),
                const Divider(),
                InkWell(
                    onTap: () async {
                      Get.to(const AllBrands());
                    },
                    child: HomeListWidgets(title: 'All Brands')),
                const Divider(),
                InkWell(
                    onTap: () => Get.to(const AddBrand()),
                    child: HomeListWidgets(title: 'Add Brands')),
                const Divider(),
                InkWell(
                    onTap: () async {
                      List<BrandModel> list =
                          await BrandServices().getCategories();
                      Get.to(AddProduct(options: list));
                    },
                    child: HomeListWidgets(title: 'Add Products')),
                const Divider(),
                InkWell(
                    onTap: () => Get.to(const Tabs()),
                    child: HomeListWidgets(title: 'All Orders'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
