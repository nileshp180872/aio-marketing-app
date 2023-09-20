import 'package:sqflite/sqflite.dart';

import '../db_constants.dart';


mixin SchemaConfig{

  late Database _db;

  void initialiseTables(Database db){
    _db = db;

    _createDomainTable();
    _createLeadershipTypeTable();
    _createTechnologiesTable();
  }

  /// Creates domain table.
  void _createDomainTable() async{
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblDomain} (
            ${DbConstants.domainId} TEXT PRIMARY KEY NOT NULL,
            ${DbConstants.domainName} TEXT NOT NULL
          )
          ''');
  }

  /// Creates leadership type table.
  void _createLeadershipTypeTable() async{
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblLeadership} (
            ${DbConstants.leadershipId} TEXT PRIMARY KEY NOT NULL,
            ${DbConstants.leadershipName} TEXT NOT NULL
          )
          ''');
  }

  /// Create technologies table
  void _createTechnologiesTable() async{
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblTechnologies} (
            ${DbConstants.technologicalId} TEXT PRIMARY KEY NOT NULL,
            ${DbConstants.technologicalName} TEXT NOT NULL
          )
          ''');
  }

}