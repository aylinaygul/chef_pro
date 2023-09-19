import 'package:flutter/material.dart';
import 'home.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './helpers/globals.dart';
import './databases/databse_helper.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();

  databaseHelper = DatabaseHelper();
// Open the database and store the reference.
  database = await openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE material(name TEXT PRIMARY KEY)',
      );
    },
    version: 1,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chef Pro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tarifler'),
    );
  }
}
