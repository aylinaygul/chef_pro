import 'package:flutter/material.dart';
import 'widgets/my_text_field.dart';

class ViewInfo extends StatefulWidget {
  final List<String> items;

  const ViewInfo({super.key, required this.items});
  @override
  _ViewInfoState createState() => _ViewInfoState();
}

class _ViewInfoState extends State<ViewInfo> {
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
            if (index == 0) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    widget.items[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else {
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
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
