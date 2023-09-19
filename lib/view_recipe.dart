import 'package:flutter/material.dart';

class ViewRecipe extends StatefulWidget {
  final List<String> items;

  const ViewRecipe({super.key, required this.items});
  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarif Hesapla"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: widget.items.length,
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
                  widget.items[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
