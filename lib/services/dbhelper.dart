import 'package:path/path.dart';
import 'package:platform_converter/modal/contact_modal.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();

  Database? _database;

  final _contactTable = 'contact';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initState();
    return _database!;
  }

  Future<Database> initState() async {
    var databasePath = await getDatabasesPath();
    final path = join(databasePath, "converter.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $_contactTable (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT,chat TEXT,date TEXT,time TEXT,image TEXT)');
    });
  }

  Future<void> insertData(ContactModal contact) async {
    final db = await database;
    await db.insert(_contactTable, ContactModal.toMap(contact),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateData(ContactModal contact) async {
    final db = await database;


    await db.update(_contactTable, ContactModal.toMap(contact),
        where: "id=?", whereArgs: [contact.id]);
  }

  Future<void> deleteData(var id) async {
    final db = await database;
    await db.delete(_contactTable, where: "id=?", whereArgs: [id]);
  }

  Future<List<Map<String, Object?>>> fetchDataFromDatabase() async {
    final db = await database;
    return await db.query(_contactTable);
  }
}
