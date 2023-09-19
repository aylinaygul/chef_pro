import 'package:flutter/material.dart';
import 'package:chef_pro/add_dish_screen.dart';
import 'package:chef_pro/dishes.dart';
import 'package:chef_pro/helpers/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chef_pro/calculate.dart';
import 'package:chef_pro/home.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<DropdownMenuItem<Dish>> dropdownList = [
    DropdownMenuItem(child: Text("Yemek Adı"))
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Hesapla'),
            onTap: _onCalculateButtonPressed,
          ),
          ListTile(
            title: Text('Tarif Ekle'),
            onTap: _onAddDishButtonPressed,
          ),
          ListTile(
            title: Text('Tarifler'),
            onTap: _onDishesButtonPressed,
          ),
        ],
      ),
    );
  }

  _onAddDishButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDishScreen()),
    );
  }

  _onDishesButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Dishes()),
    );
  }

  _onCalculateButtonPressed() {
    callGetDish().then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Calculate(
            dropdownList: dropdownList,
          ),
        ),
      );
    });
  }

  Future<void> callGetDish() async {
    await _getDishes();
  }

  _getDishes() async {
    dropdownList.clear();
    if (databaseHelper != null) {
      var value = await databaseHelper!.getAllDishes();
      for (var element in value) {
        dropdownList.add(DropdownMenuItem(
          value: element,
          child: Text(element.name),
        ));
      }
    }
  }
}
