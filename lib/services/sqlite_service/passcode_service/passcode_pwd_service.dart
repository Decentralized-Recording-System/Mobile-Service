import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/index.dart';

class PassCodePwdDatabase {
  static final PassCodePwdDatabase instance = PassCodePwdDatabase._init();

  static Database? _database;

  PassCodePwdDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('passCodePwd.db');

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
CREATE TABLE $tablePassCodePwd (
  ${PassCodePwdFields.id} $idType,
  ${PassCodePwdFields.pwdPassCode} $textType
)
''');
  }

  Future<PassCodePwdDatabaseModel> create(
      PassCodePwdDatabaseModel passCodePwd) async {
    final db = await instance.database;

    final id = await db.insert(tablePassCodePwd, passCodePwd.toJson());
    return passCodePwd.copy(id: id);
  }

  Future<PassCodePwdDatabaseModel> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablePassCodePwd,
      columns: PassCodePwdFields.values,
      where: '${PassCodePwdFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return PassCodePwdDatabaseModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<PassCodePwdDatabaseModel>> readAllData() async {
    final db = await instance.database;

    const orderBy = '${PassCodePwdFields.id} DESC';
    final result = await db.query(tablePassCodePwd, orderBy: orderBy);

    return result
        .map((json) => PassCodePwdDatabaseModel.fromJson(json))
        .toList();
  }

  Future<int> update(PassCodePwdDatabaseModel passCodePwd) async {
    final db = await instance.database;

    return db.update(
      tablePassCodePwd,
      passCodePwd.toJson(),
      where: '${PassCodePwdFields.id} = ?',
      whereArgs: [passCodePwd.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tablePassCodePwd,
      where: '${PassCodePwdFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;
    return db.delete(
      tablePassCodePwd,
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
