import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/index.dart';

class TelemeticsDatabase {
  static final TelemeticsDatabase instance = TelemeticsDatabase._init();

  static Database? _database;

  TelemeticsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('telemetics.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';
    await db.execute('''
CREATE TABLE $tableTelemetics (
  ${TelemeticsFields.id} $idType,
  ${TelemeticsFields.score} $integerType,
  ${TelemeticsFields.brakingValue} $textType,
  ${TelemeticsFields.dangerousBrakeValue} $textType,
  ${TelemeticsFields.dangerousTurnValue} $textType
)
''');
  }

  Future<TelemeticsDatabaseModel> create(
      TelemeticsDatabaseModel telemeticsData) async {
    final db = await instance.database;

    final id = await db.insert(tableTelemetics, telemeticsData.toJson());
    return telemeticsData.copy(id: id);
  }

  Future<TelemeticsDatabaseModel> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTelemetics,
      columns: TelemeticsFields.values,
      where: '${TelemeticsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TelemeticsDatabaseModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TelemeticsDatabaseModel>> readAllData() async {
    final db = await instance.database;

    const orderBy = '${TelemeticsFields.id} DESC';
    final result = await db.query(tableTelemetics, orderBy: orderBy);

    return result
        .map((json) => TelemeticsDatabaseModel.fromJson(json))
        .toList();
  }

  Future<int> lengthOfAllData() async {
    final db = await instance.database;

    const orderBy = '${TelemeticsFields.id} DESC';
    final result = await db.query(tableTelemetics, orderBy: orderBy);

    return result
        .map((json) => TelemeticsDatabaseModel.fromJson(json))
        .toList()
        .length;
  }

  Future<int> update(TelemeticsDatabaseModel telemeticsData) async {
    final db = await instance.database;

    return db.update(
      tableTelemetics,
      telemeticsData.toJson(),
      where: '${TelemeticsFields.id} = ?',
      whereArgs: [telemeticsData.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tableTelemetics,
      where: '${TelemeticsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;
    return db.delete(
      tableTelemetics,
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
