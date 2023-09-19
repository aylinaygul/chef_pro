import 'package:flutter/material.dart';
import '../helpers/globals.dart';
import 'package:chef_pro/view_info.dart';
import 'package:chef_pro/home.dart';

class ItemCardDish extends StatelessWidget {
  final List<Dish> items;
  final int number;
  final int index;

  ItemCardDish({
    Key? key,
    required this.items,
    required this.number,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        // Wrap the Row with SingleChildScrollView
        scrollDirection: Axis.horizontal, // Set the scroll direction
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(width: (MediaQuery.of(context).size.width / 5)),
            Text(items[index].name),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text('Tarifi silmek istediğinize emin misiniz?'),
                    action: SnackBarAction(
                      label: 'Evet',
                      onPressed: () {
                        if (databaseHelper == null) {
                          return;
                        }
                        databaseHelper!.deleteWithTitle(items[index].name);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: Text('Silindi.'),
                          ),
                        );
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    title: 'Tarifler',
                                  )),
                        );
                      },
                    ),
                  ),
                );
              },
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                List<String> recipes = [];
                if (items[index] == null) {
                  return;
                }

                recipes.add("${items[index].name}\n");

                for (var element in items[index].recipies) {
                  recipes.add(
                    "${element.measurement} ${element.unitName} ${element.name}\n",
                  );
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewInfo(items: recipes),
                  ),
                );
              },
              icon: Icon(Icons.info),
            ),
          ],
        ),
      ),
    );
  }
}
