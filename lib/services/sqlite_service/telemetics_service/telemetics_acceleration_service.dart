import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/index.dart';

class TelemeticsAccelerationDatabase {
  static final TelemeticsAccelerationDatabase instance =
      TelemeticsAccelerationDatabase._init();

  static Database? _database;

  TelemeticsAccelerationDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('telemeticsAcceleration.db');

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
CREATE TABLE $tableTelemeticsAcceleration (
  ${TelemeticsAccelerationFields.id} $idType,
  ${TelemeticsAccelerationFields.score} $integerType,
  ${TelemeticsAccelerationFields.highestValue} $textType
)
''');
  }

  Future<TelemeticsAccelerationModel> create(
      TelemeticsAccelerationModel telemeticsData) async {
    final db = await instance.database;

    final id =
        await db.insert(tableTelemeticsAcceleration, telemeticsData.toJson());
    return telemeticsData.copy(id: id);
  }

  Future<TelemeticsAccelerationModel> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTelemeticsAcceleration,
      columns: TelemeticsAccelerationFields.values,
      where: '${TelemeticsAccelerationFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TelemeticsAccelerationModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TelemeticsAccelerationModel>> readAllData() async {
    final db = await instance.database;

    const orderBy = '${TelemeticsAccelerationFields.id} DESC';
    final result =
        await db.query(tableTelemeticsAcceleration, orderBy: orderBy);

    return result
        .map((json) => TelemeticsAccelerationModel.fromJson(json))
        .toList();
  }

  Future<int> lengthOfAllData() async {
    final db = await instance.database;

    const orderBy = '${TelemeticsAccelerationFields.id} DESC';
    final result =
        await db.query(tableTelemeticsAcceleration, orderBy: orderBy);

    return result
        .map((json) => TelemeticsAccelerationModel.fromJson(json))
        .toList()
        .length;
  }

  Future<int> update(TelemeticsAccelerationModel telemeticsData) async {
    final db = await instance.database;

    return db.update(
      tableTelemeticsAcceleration,
      telemeticsData.toJson(),
      where: '${TelemeticsAccelerationFields.id} = ?',
      whereArgs: [telemeticsData.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tableTelemeticsAcceleration,
      where: '${TelemeticsAccelerationFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;
    return db.delete(
      tableTelemeticsAcceleration,
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
