import 'package:chef_pro/dishes.dart';
import 'package:chef_pro/helpers/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController personNumberController = TextEditingController();

  List<DropdownMenuItem<Dish>> dropdownList = [
    DropdownMenuItem(child: Text("Yemek Adı"))
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dishes();
  }
}
