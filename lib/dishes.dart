import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'helpers/globals.dart';
import 'widgets/item_chart_dish.dart';
import 'add_dish_screen.dart';
import 'widgets/drawer.dart';

class Dishes extends StatefulWidget {
  const Dishes({super.key});

  @override
  _DishesState createState() => _DishesState();
}

class _DishesState extends State<Dishes> {
  final TextEditingController recipeNameController = TextEditingController();
  List<Dish> items = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _getDishes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Tarifler'),
        ),
        drawer: MyDrawer(),
        body: GestureDetector(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _onIconButtonPressed,
                  iconSize: 100, // Increase the icon size as desired
                  icon: Icon(Icons.add),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add some spacing between the icon and text
                    Text(
                      'Tarif Ekle',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold), // Apply desired text styling
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Kayıtlı tarif bulunmamaktadır.',
                      style:
                          TextStyle(fontSize: 15), // Apply desired text styling
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () => _onIconButtonPressed(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Tarifler'),
        ),
        drawer: MyDrawer(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(5),
                itemCount: items.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ItemCardDish(
                    number: items.length,
                    items: items,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  void _onIconButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDishScreen()),
    );
  }

  _getDishes() {
    if (databaseHelper == null) {
      return;
    }
    databaseHelper!.getAllDishes().then((value) {
      setState(() {
        items = value;
      });
    });
  }
}
