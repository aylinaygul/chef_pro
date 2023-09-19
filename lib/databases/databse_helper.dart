import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../helpers/globals.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'recipes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE recipes(
            id INTEGER ,
            title TEXT PRIMARY KEY,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertDish(Dish dish) async {
    final db = await database;
    String content = "";
    for (var element in dish.recipies) {
      content +=
          "${element.name}-${element.measurement.toStringAsFixed(3)}-${element.unitName}_";
    }
    final recipe = {
      'title': dish.name.toUpperCase(),
      'content': content.toUpperCase()
    };
    return await db.insert('recipes', recipe);
  }

  Future<List<Dish>> getAllDishes() async {
    final db = await database;
    List<Dish> dishes = [];
    var x = await db.query('recipes');
    for (var element in x) {
      dishes.add(_dishParser(
        element.entries.elementAt(1).value.toString().toUpperCase(),
        element.entries.elementAt(2).value.toString().toUpperCase(),
      ));
    }
    return dishes;
  }

  deleteWithTitle(String title) async {
    final db = await database;
    db.delete('recipes', where: "title= '${title.toUpperCase()}'");
  }

  Dish _dishParser(String name, String content) {
    List<Recipies> recipies = [];
    List<String> recipiesContentList = content.split("_");
    for (var element in recipiesContentList) {
      if (element == "") {
        continue;
      }
      List<String> recipieList = element.split("-");
      recipies.add(Recipies(
        name: recipieList[0],
        unitName: recipieList[2],
        measurement: double.parse(
            double.parse(recipieList[1].replaceAll(",", "."))
                .toStringAsFixed(3)),
      ));
    }
    return Dish(name, recipies);
  }
}
