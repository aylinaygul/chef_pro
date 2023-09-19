import 'package:chef_pro/helpers/globals.dart';
import 'package:chef_pro/widgets/my_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'view_recipe.dart';
import 'widgets/drawer.dart';

class Calculate extends StatefulWidget {
  final List<DropdownMenuItem<Dish>> dropdownList;

  Calculate({required this.dropdownList, Key? key}) : super(key: key);

  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  final TextEditingController personNumberController = TextEditingController();
  List<Dish> addedRecipes = [];
  Dish? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarif Hesapla'),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          SizedBox(height: 15),
          Center(
            child: SizedBox(
              width: 100,
              child: TextField(
                textAlign: TextAlign.center,
                controller: personNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true,
                    hintText: 'Kişi Sayısı'),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: (MediaQuery.of(context).size.width - 200),
              child: MyDropdownButtonFormField(
                items: widget.dropdownList,
                onChanged: (Dish? value) {
                  dropdownValue = value;
                },
                value: dropdownValue,
                text:
                    (dropdownValue != null) ? dropdownValue!.name : "Yemek Adı",
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: Text(
              'Ekle',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                addedRecipes.add(dropdownValue!);
              });
            },
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: ListTile(
              title: Text(
                'Seçilen Tarifler',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: addedRecipes.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      addedRecipes[index].name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      addedRecipes = [];
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Seçimleri Temizle',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Hesapla',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (addedRecipes.isEmpty) {
                      return;
                    }
                    List<String> recipes = [];
                    Map<String, double> mergedIngredients = {};

                    for (var item in addedRecipes) {
                      for (var element in item.recipies) {
                        String name = element.name;
                        double quantity = element.measurement.toDouble();
                        String unitName = element.unitName;

                        String key = "$name $unitName";
                        if (mergedIngredients.containsKey(key)) {
                          mergedIngredients[key] =
                              mergedIngredients[key]! + quantity;
                        } else {
                          mergedIngredients[key] = quantity;
                        }
                      }
                    }

                    for (var ingredient in mergedIngredients.keys) {
                      List<String> parts = ingredient.split(" ");
                      String name = parts[0];
                      String unitName = parts[1];
                      double quantity = mergedIngredients[ingredient]!;
                      double result =
                          (quantity * int.parse(personNumberController.text));
                      recipes.add(
                          "${((result * 10).ceil() / 10).toStringAsFixed(1)} $unitName $name");
                    }

                    ;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewRecipe(items: recipes),
                      ),
                    );

                    ;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
