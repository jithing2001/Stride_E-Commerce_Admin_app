import 'package:ecommerce_admin/constants.dart';
import 'package:flutter/material.dart';

class AddProductWidget extends StatelessWidget {
  const AddProductWidget(
      {super.key,
      required this.Controller,
      required this.title,
      required this.hint});

  final TextEditingController Controller;
  final String title;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        kheight5,
        TextFormField(
          controller: Controller,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: kblack),
                  borderRadius: BorderRadius.circular(10))),
        ),
        kheight10,
      ],
    );
  }
}
