import 'package:flutter/material.dart';
import 'my_text_field.dart';

class ItemCard extends StatelessWidget {
  final TextEditingController ingredientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController measurementController = TextEditingController();

  ItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                width: 3 * (MediaQuery.of(context).size.width - 40) / 5,
                child: MyTextField(
                  label: 'Malzeme Adı',
                  controller: ingredientController,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 40) / 5,
            child: MyTextField(
              label: 'Ölçü',
              isDigit: true,
              controller: amountController,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 40) / 5,
            child: MyTextField(
              label: 'Birimi',
              controller: measurementController,
            ),
          ),
        ],
      ),
    );
  }
}
