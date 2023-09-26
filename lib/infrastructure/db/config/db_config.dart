import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

mixin DbConfig {
  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init(
      {required String databaseName,
      required int databaseVersion,
      required Function(Database db) onCreateDb}) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, databaseName);
    _db = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: (db, version) => onCreateDb(db),
    );
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row, String table) async {
    return await _db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<dynamic>> queryAllRows(String table) async {
    return await _db.query(table);
  }

  // first row returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<dynamic>> queryOneRows(String table) async {
    return await _db.query(table, limit: 1);
  }

  // first row returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<dynamic>> filterDataById(
      {required String table,
      required String columnName,
      required String id}) async {
    return await _db
        .query(table, limit: 1, where: '$columnName = ?', whereArgs: [id]);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String table) async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

// // We are assuming here that the id column in the map is set. The other
// // column values will be used to update the row.
// Future<int> update(Map<String, dynamic> row) async {
//   int id = row[columnId];
//   return await _db.update(
//     table,
//     row,
//     where: '$columnId = ?',
//     whereArgs: [id],
//   );
// }
//
// Deletes the row specified by the id. The number of affected rows is
// returned. This should be 1 as long as the row exists.
  Future<int> delete(
      {required String id,
      required String table,
      required String columnName}) async {
    return await _db.delete(
      table,
      where: '$columnName = ?',
      whereArgs: [id],
    );
  }

  // first row returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<dynamic>> filterDataForSearchValue(
      {required String searchString}) async {
    return await _db.rawQuery(
        "	SELECT * FROM portfolio where portfolio.portfolio_project_name LIKE '$searchString' OR portfolio.portfolio_domain_name LIKE '$searchString';");
  }

  //delete all the rows from the table.
  Future<int> truncateTable(String tableName) async {
    return await _db.delete(tableName);
  }
}
