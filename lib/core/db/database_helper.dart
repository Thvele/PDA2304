import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../common/database_request.dart';
class DataBaseHelper{

  static final DataBaseHelper instance = DataBaseHelper._instance();
  DataBaseHelper._instance();

  late final Directory _appDocumentDirectory;
  late final String _pathDB;
  late final Database _database;
  final int _DBver = 1;


  Future<void> init() async {
    _appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    _pathDB = join(_appDocumentDirectory.path, 'store.db');

    if(Platform.isLinux || Platform.isWindows || Platform.isMacOS){

    }
    else{
      _database = await openDatabase(
        _pathDB,
        version: _DBver,
        onCreate: (db, version) async {
          await onCreateTable(db);
        }
      );
    }
  }

  Future<void> onCreateTable(Database db) async {
    for(var i = 0; i < DataBaseRequest.tableList.length; i++){
      await db.execute(DataBaseRequest.tableCreateList[i]);
    }
  }
}