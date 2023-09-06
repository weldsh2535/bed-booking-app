import 'package:sqflite/sqflite.dart';

import '../models/rooms.dart';
import '../models/tasks.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "tasks";
  static final String _roomTableName ="rooms";
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'BRD.db';
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) async {
        print("creating a new one");
        //create Task table
        await db.execute("CREATE TABLE $_tableName ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "fullName STRING,"
            "phoneNumber INTEGER,"
            "kebele INTEGER,"
            "houseNumber INTEGER,"
            "roomNumber INTEGER,"
            "registerDate STRING,"
            "exitDate STRING,"
            "color INTEGER"
            ")");

            //create 
              // Create Room
        await db.execute('''
          CREATE TABLE $_roomTableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            numberOfPeople INTEGER,
            type TEXT,
            color INTEGER
          )
        ''');
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("insert function called");
    print(task!.toJson());
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
  UPDATE tasks 
  SET color = ?
  WHERE id =?
''', [1, id]);
  }

  //rooms
  static Future<int> insertRooms(Rooms? rooms) async {
    print("insert function called");
    print(rooms!.toJson());
    return await _db?.insert(_roomTableName, rooms!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> queryRooms() async {
    print("query function called");
    return await _db!.query(_roomTableName);
  }

  static deleteRoom(Rooms rooms) async {
    return await _db!.delete(_roomTableName, where: 'id=?', whereArgs: [rooms.id]);
  }

  static updateRoom(int id) async {
    return await _db!.rawUpdate('''
  UPDATE rooms 
  SET color = ?
  WHERE id =?
''', [1, id]);
  }
}
