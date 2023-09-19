import 'package:sqflite/sqflite.dart';

class Material {
  final String name;

  const Material({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{name: $name}';
  }
}
