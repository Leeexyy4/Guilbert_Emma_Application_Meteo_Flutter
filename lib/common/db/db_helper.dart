import 'package:sqflite/sqflite.dart';

class DbHelper{
  static const String _dbName = 'littlewords.db';
  static const int _dbVersion = 3;

  static Database? _db;

  static initDb() async{
    final String dbPath = await getDatabasesPath();
    final String path = dbPath + _dbName;
    final Database database = await openDatabase(path, version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    _db = database;
  }

  static _onCreate(Database db, int version){
    db.execute(createTable);
  }

  static _onUpgrade(Database db, int oldversion, int newversion){
    db.execute(dropTable);

    _onCreate(db, newversion);
  }

  static const String tableName = "words";

  static const String createTable = '''
  CREATE TABLE if not exists $tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    word TEXT
  );
  ''';

  static const String dropTable = '''
  DROP TABLE IF EXISTS $tableName;
  ''';

}