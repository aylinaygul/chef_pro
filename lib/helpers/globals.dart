import 'package:sqflite/sqflite.dart';
import '../databases/databse_helper.dart';

Database? database;
DatabaseHelper? databaseHelper;

class Recipies {
  final String name;
  final String unitName;
  final double measurement;
  const Recipies(
      {required this.name, required this.unitName, required this.measurement});
}

class Dish {
  final String name;
  final List<Recipies> recipies;

  Dish(this.name, this.recipies);
}
