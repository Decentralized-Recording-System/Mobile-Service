import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/index.dart';

class TelemeticsTestDatabase {
  static final TelemeticsTestDatabase instance = TelemeticsTestDatabase._init();

  static Database? _database;

  TelemeticsTestDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('telemeticsTest.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    await db.execute('''
CREATE TABLE $tableTelemeticsTest (
  ${TelemeticsTestFields.id} $idType,
  ${TelemeticsTestFields.list} $textType
)
''');
  }

  Future<TelemeticsTestDatabaseModel> create(
      TelemeticsTestDatabaseModel telemeticsData) async {
    final db = await instance.database;

    final id = await db.insert(tableTelemeticsTest, telemeticsData.toJson());
    return telemeticsData.copy(id: id);
  }

  Future<TelemeticsTestDatabaseModel> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTelemeticsTest,
      columns: TelemeticsTestFields.values,
      where: '${TelemeticsTestFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TelemeticsTestDatabaseModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TelemeticsTestDatabaseModel>> readAllData() async {
    final db = await instance.database;

    const orderBy = '${TelemeticsTestFields.id} DESC';
    final result = await db.query(tableTelemeticsTest, orderBy: orderBy);

    return result
        .map((json) => TelemeticsTestDatabaseModel.fromJson(json))
        .toList();
  }

  Future<int> lengthOfAllData() async {
    final db = await instance.database;

    const orderBy = '${TelemeticsTestFields.id} DESC';
    final result = await db.query(tableTelemeticsTest, orderBy: orderBy);

    return result
        .map((json) => TelemeticsTestDatabaseModel.fromJson(json))
        .toList()
        .length;
  }

  Future<int> update(TelemeticsTestDatabaseModel telemeticsData) async {
    final db = await instance.database;

    return db.update(
      tableTelemeticsTest,
      telemeticsData.toJson(),
      where: '${TelemeticsTestFields.id} = ?',
      whereArgs: [telemeticsData.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tableTelemeticsTest,
      where: '${TelemeticsTestFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;
    return db.delete(
      tableTelemeticsTest,
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
