import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/my_text_field.dart';
import 'helpers/globals.dart';
import 'widgets/item_card.dart';
import 'home.dart';
import 'widgets/drawer.dart';

class AddDishScreen extends StatefulWidget {
  const AddDishScreen({super.key});

  @override
  _AddDishScreenState createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  final TextEditingController recipeNameController = TextEditingController();
  List<ItemCard> items = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tarif Ekle'),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment
                    .topLeft, // Aligns the content to the top left corner
                padding: const EdgeInsets.only(
                    left: 20.0, top: 20.0), // Adds left and top padding
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligns the children to the start (left) side
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 250,
                      child: MyTextField(
                        label: 'Tarif Adı',
                        controller: recipeNameController,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(5),
                    itemCount: items.length + 1,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == items.length) {
                        return SizedBox(
                          width: buttonWidth,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.blue;
                                }
                                return Colors.blue;
                              }),
                            ),
                            onPressed: _onAddItemButtonPressed,
                            child: const Text(
                              'Malzeme Ekle',
                            ),
                          ),
                        );
                      }
                      return Container(
                        child: items[index],
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.blue;
                        }
                        return Colors.blue;
                      }),
                    ),
                    onPressed: _onSaveButtonPressed,
                    child: const Text(
                      'Kaydet',
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onAddItemButtonPressed() {
    setState(() {
      items.add(ItemCard());
      _scrollController
          .jumpTo(_scrollController.position.maxScrollExtent + 100);
    });
  }

  _onSaveButtonPressed() {
    if (databaseHelper == null) {
      return;
    }
    List<Recipies> recipies = [];
    for (var item in items) {
      recipies.add(Recipies(
          name: item.ingredientController.text,
          unitName: item.measurementController.text,
          measurement:
              double.parse(item.amountController.text.replaceAll(",", "."))));
    }
    Dish dish = Dish(recipeNameController.text, recipies);
    databaseHelper!.insertDish(dish);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text('Kaydedildi'),
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
  }
}
