import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/index.dart';

class LoginStatusDatabase {
  static final LoginStatusDatabase instance = LoginStatusDatabase._init();

  static Database? _database;

  LoginStatusDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('loginStatus.db');

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
CREATE TABLE $tableLoginStatus (
  ${LoginStatusFields.id} $idType,
  ${LoginStatusFields.loginStatus} $textType
)
''');
  }

  Future<LoginStatusDatabaseModel> create(
      LoginStatusDatabaseModel loginStatus) async {
    final db = await instance.database;

    final id = await db.insert(tableLoginStatus, loginStatus.toJson());
    return loginStatus.copy(id: id);
  }

  Future<LoginStatusDatabaseModel> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableLoginStatus,
      columns: LoginStatusFields.values,
      where: '${LoginStatusFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return LoginStatusDatabaseModel.fromJson(maps.first);
    } else {
      return const LoginStatusDatabaseModel(loginStatus: "false");
    }
  }

  Future<List<LoginStatusDatabaseModel>> readAllData() async {
    final db = await instance.database;

    const orderBy = '${LoginStatusFields.id} DESC';
    final result = await db.query(tableLoginStatus, orderBy: orderBy);

    return result
        .map((json) => LoginStatusDatabaseModel.fromJson(json))
        .toList();
  }

  Future<int> lengthOfAllData() async {
    final db = await instance.database;

    const orderBy = '${LoginStatusFields.id} DESC';
    final result = await db.query(tableLoginStatus, orderBy: orderBy);

    return result
        .map((json) => LoginStatusDatabaseModel.fromJson(json))
        .toList()
        .length;
  }

  Future<int> update(LoginStatusDatabaseModel loginStatus) async {
    final db = await instance.database;

    return db.update(
      tableLoginStatus,
      loginStatus.toJson(),
      where: '${LoginStatusFields.id} = ?',
      whereArgs: [loginStatus.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tableLoginStatus,
      where: '${LoginStatusFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;
    return db.delete(
      tableLoginStatus,
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
