import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isDigit;

  const MyTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isDigit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 400,
            child: TextField(
              textAlign: TextAlign.center,
              controller: controller,
              keyboardType: (isDigit) ? TextInputType.number : null,
              inputFormatters: [
                if (isDigit) ...[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+([,.]\d*)?$')),
                ]
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
