import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:guilbertemmaflutterproject/common/model/ville.dart';

class DbHelper{
  static const String _dbName = 'meteodb.db';
  static const int _dbVersion = 3;
  static Database? db;

  static Future initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    db = await openDatabase(path, version: _dbVersion,onCreate: _createDB);

  }

  static Future _createDB(Database db, int version) async{
    const idType = 'INTEGER PRIMARY KEY';
    const villeType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE if not exists $tableville (
    ${VilleFields.id} $idType,
    ${VilleFields.nom} $villeType
    );
    ''');
  }

  static Future _updateDB(Database db, int version) async{
    await db.execute('''
      DROP TABLE IF EXISTS $tableville;
      ''');
  }

  static Future<Ville> create (Ville ville) async {
    final nomCapitalize = ville.nom.toLowerCase().replaceRange(0, 1, ville.nom.substring(0, 1).toUpperCase());
    final id = await db!.insert(tableville, ville.copy(nom: nomCapitalize).toJson());
    return ville.copy(id: id);
  }

  static Future<bool> isVillePresent(String nomVille) async {
    final result = await db!.query(
      tableville,
      columns: [VilleFields.id],
      where: '${VilleFields.nom} = ?',
      whereArgs: [nomVille.toUpperCase()],
    );

    return result.isNotEmpty;
  }

  static Future<Ville?> readVille(int id) async {

    final maps = await db!.query(
      tableville,
      columns: VilleFields.values,
      where: '${VilleFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty){
      return Ville.fromJson(maps.first);
    }else{
      throw Exception('ID $id not fund');
    }
  }

  static Future<List<Ville>> readAllVilles() async{

    const order = '${VilleFields.id} ASC';
    final result = await db!.query(tableville,orderBy: order);

    return result.map((json) => Ville.fromJson(json)).toList();

  }

  static Future<int> update(Ville ville) async {


    return db!.update(
      tableville,
      ville.toJson(),
      where: '${VilleFields.id} = ?',
      whereArgs: [ville.id],
    );
  }

  static Future<int> delete(int id) async {

    return db!.delete(
      tableville,
      where: '${VilleFields.id} = ?',
      whereArgs: [id],
    );
  }

  static Future close() async{

    db!.close();
  }
}