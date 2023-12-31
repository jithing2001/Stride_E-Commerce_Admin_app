import 'package:ecommerce_admin/constants.dart';
import 'package:flutter/material.dart';

class ProductGridView extends StatelessWidget {
  String? imgPath;
  String? productName;
  String? productRate;
  String? sellingRate;
  ProductGridView(
      {super.key,
      required this.imgPath,
      required this.productName,
      required this.productRate,
      required this.sellingRate});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          // height: 400,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: kblack),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 200,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Image(
                      image: NetworkImage(
                        '$imgPath',
                      ),
                      fit: BoxFit.cover,
                      // height: 120,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  kwidth20,
                  SizedBox(
                    width: 165,
                    child: Text(
                      '$productName',
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  kwidth20,
                  Text(
                    '₹$productRate',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: kred,
                        decoration: TextDecoration.lineThrough),
                  ),
                  kwidth5,
                  Text('₹$sellingRate',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: kgreen))
                ],
              )
            ],
          ),
        ));
  }
}
