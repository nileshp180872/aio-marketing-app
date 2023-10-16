import 'package:aio/config/app_constants.dart';
import 'package:aio/infrastructure/db/db_constants.dart';
import 'package:aio/infrastructure/db/schema/leadership.dart';
import 'package:aio/infrastructure/db/schema/portfolio.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../schema/case_study.dart';

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
        .query(table, where: '$columnName = ?', whereArgs: [id]);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String table) async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

// We are assuming here that the id column in the map is set. The other
// column values will be used to update the row.
  Future<int> update(
    Map<String, dynamic> row,
    String columnId,
    String columnName,
    String tableName,
  ) async {
    int id = row[columnId];
    return await _db.update(
      tableName,
      row,
      where: '$columnName = ?',
      whereArgs: [id],
    );
  }

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
        "SELECT * FROM portfolio where portfolio.portfolio_project_name LIKE '%$searchString%' OR portfolio.portfolio_domain_name LIKE '%$searchString%';");
  }

  // first row returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<dynamic>> filterPortfolioDataForFilter({
    required String domains,
    required String screens,
    required String technologies,
  }) async {
    final List<Map<String, dynamic>> result = await _db.rawQuery(
        "SELECT * FROM portfolio WHERE portfolio.portfolio_domain_id in ($domains) OR portfolio.portfolio_screen_type in ($screens) ORDER BY portfolio.portfolio_autoincrement_id LIMIT 2;");

    return List<Portfolio>.generate(
        result.length, (index) => Portfolio.fromJson(result[index]),
        growable: true);
  }

  /// Return all rows returned as a list of maps, where each map is
  /// a key-value list of columns.
  Future<List<Portfolio>> getPortfolioWithImage(int offset,
      {required String domains,
      required String screens,
      required String technologies,
      String projectId = "",
      bool filterApplied = false,
      int limit = AppConstants.paginationPageLimit}) async {
    const joinImages =
        "left join ${DbConstants.tblPortfolioImages} on ${DbConstants.portfolioId} = ${DbConstants.portfolioImagePortfolioId}";

    const joinTechnologyTable =
        "left join ${DbConstants.tblPortfolioTechnologies} on ${DbConstants.portfolioId} = ${DbConstants.portfolioTableId}";

    String filterAllDataQuery =
        "SELECT ${DbConstants.tblPortfolio}.*, ${DbConstants.portfolioImagePath} as images, ${DbConstants.portfolioTechnologyId} as technologies FROM ${DbConstants.tblPortfolio} $joinImages $joinTechnologyTable";

    String queryFilter =
        "GROUP BY ${DbConstants.portfolioId} ORDER BY ${DbConstants.portfolioProjectName} ASC LIMIT $limit OFFSET $offset";

    String filterQuery = "WHERE";

    if (domains.isNotEmpty) {
      filterQuery =
          " $filterQuery ${DbConstants.portfolioDomainId} in ($domains)";
    }

    if (screens.isNotEmpty) {
      filterQuery =
          " $filterQuery ${filterQuery.trim().toUpperCase() != "WHERE" ? "OR" : ""} ${DbConstants.portfolioScreenType} in ($screens)";
    }

    if (technologies.isNotEmpty) {
      filterQuery =
          " $filterQuery ${filterQuery.trim().toUpperCase() != "WHERE" ? "OR" : ""} technologies in ($technologies)";
    }

    if (projectId.isNotEmpty) {
      filterQuery =
          " $filterQuery ${filterQuery.trim().toUpperCase() != "WHERE" ? "OR" : ""} ${DbConstants.caseStudyId} = '$projectId'";
    }
    String finalQuery =
        "$filterAllDataQuery ${filterApplied ? filterQuery : ""} $queryFilter";

    Get.log("portfolioQuery --> $finalQuery");
    final List<Map<String, dynamic>> result = await _db.rawQuery(finalQuery);

    return List<Portfolio>.generate(
        result.length, (index) => Portfolio.fromJson(result[index]),
        growable: true);
  }

  /// Return all rows returned as a list of maps, where each map is
  /// a key-value list of columns.
  Future<List<Portfolio>> getPortfolioBySearch(int offset,
      {required String search,
      int limit = AppConstants.paginationPageLimit}) async {
    if (search.trim().isEmpty) {
      return [];
    }
    const joinImages =
        "left join ${DbConstants.tblPortfolioImages} on ${DbConstants.portfolioId} = ${DbConstants.portfolioImagePortfolioId}";

    const joinTechnologyTable =
        "left join ${DbConstants.tblPortfolioTechnologies} on ${DbConstants.portfolioId} = ${DbConstants.portfolioTableId}";

    String filterAllDataQuery =
        "SELECT ${DbConstants.tblPortfolio}.*, ${DbConstants.portfolioImagePath} as images, ${DbConstants.portfolioTechnologyId} as technologies FROM ${DbConstants.tblPortfolio} $joinImages $joinTechnologyTable";

    String queryFilter =
        "GROUP BY ${DbConstants.portfolioId} ORDER BY ${DbConstants.portfolioProjectName} ASC LIMIT $limit OFFSET $offset";

    String filterQuery = "WHERE";

    if (search.isNotEmpty) {
      filterQuery =
          " $filterQuery ${filterQuery.trim().toUpperCase() != "WHERE" ? "OR" : ""} portfolio.portfolio_project_name LIKE '$search%' OR portfolio.portfolio_domain_name LIKE '$search%'";
    } else {
      filterQuery = "";
    }

    String finalQuery = "$filterAllDataQuery $filterQuery $queryFilter";

    Get.log("search portfolio $finalQuery");
    final List<Map<String, dynamic>> result = await _db.rawQuery(finalQuery);

    return List<Portfolio>.generate(
        result.length, (index) => Portfolio.fromJson(result[index]),
        growable: true);
  }

  /// Return all rows returned as a list of maps, where each map is
  /// a key-value list of columns.
  Future<List<CaseStudy>> getCaseStudyWithImage(int offset,
      {required String domains,
      required String technologies,
      bool filterApplied = false,
      int limit = AppConstants.paginationPageLimit}) async {
    const joinImages =
        "left join ${DbConstants.tblCaseStudyImages} on ${DbConstants.tblCaseStudies}.${DbConstants.caseStudyId} = ${DbConstants.caseStudyImageCaseStudyId}";

    const joinTechnologyTable =
        "left join ${DbConstants.tblCaseStudiesTechnologies} on ${DbConstants.tblCaseStudies}.${DbConstants.caseStudyId} = ${DbConstants.caseStudyTechnologyId}";

    String filterAllDataQuery =
        "SELECT ${DbConstants.tblCaseStudies}.*, ${DbConstants.caseStudyImagePath} as images, ${DbConstants.caseStudyTechnologyId} as technologies FROM ${DbConstants.tblCaseStudies} $joinImages $joinTechnologyTable";

    String queryFilter =
        "GROUP BY ${DbConstants.tblCaseStudies}.${DbConstants.caseStudyId} ORDER BY ${DbConstants.caseStudyProjectName} ASC LIMIT $limit OFFSET $offset";

    String filterQuery = "WHERE";

    if (domains.isNotEmpty) {
      filterQuery =
          " $filterQuery ${DbConstants.caseStudyDomainId} in ($domains)";
    }

    if (technologies.isNotEmpty) {
      filterQuery =
          " $filterQuery ${filterQuery.trim().toUpperCase() != "WHERE" ? "OR" : ""} technologies in ($technologies)";
    } else {
      filterQuery = "";
    }

    String finalQuery =
        "$filterAllDataQuery ${filterApplied ? filterQuery : ""}$queryFilter";

    Get.log("Get case study from ${finalQuery}");
    final List<Map<String, dynamic>> result = await _db.rawQuery(finalQuery);

    return List<CaseStudy>.generate(
        result.length, (index) => CaseStudy.fromJson(result[index]),
        growable: true);
  }

  /// Return all rows returned as a list of maps, where each map is
  /// a key-value list of columns.
  Future<List<CaseStudy>> getCaseStudyBySearch(int offset,
      {required String search,
      int limit = AppConstants.paginationPageLimit}) async {
    if (search.trim().isEmpty) {
      return [];
    }
    const joinImages =
        "left join ${DbConstants.tblCaseStudyImages} on ${DbConstants.tblCaseStudies}.${DbConstants.caseStudyId} = ${DbConstants.caseStudyImageCaseStudyId}";

    const joinTechnologyTable =
        "left join ${DbConstants.tblCaseStudiesTechnologies} on ${DbConstants.tblCaseStudies}.${DbConstants.caseStudyId} = ${DbConstants.caseStudyTechnologyId}";

    String filterAllDataQuery =
        "SELECT ${DbConstants.tblCaseStudies}.*, ${DbConstants.caseStudyImagePath} as images, ${DbConstants.caseStudyTechnologyId} as technologies FROM ${DbConstants.tblCaseStudies} $joinImages $joinTechnologyTable";

    String queryFilter =
        "GROUP BY ${DbConstants.tblCaseStudies}.${DbConstants.caseStudyId} ORDER BY ${DbConstants.caseStudyProjectName} ASC LIMIT $limit OFFSET $offset";

    String filterQuery = "WHERE";

    if (search.isNotEmpty) {
      filterQuery =
          " $filterQuery ${filterQuery.trim().toUpperCase() != "WHERE" ? "OR" : ""} case_study.case_study_project_name LIKE '$search%' OR case_study.case_study_domain_name LIKE '$search%'";
    } else {
      filterQuery = "";
    }

    String finalQuery = "$filterAllDataQuery $filterQuery $queryFilter";

    Get.log("Get case study from ${finalQuery}");
    final List<Map<String, dynamic>> result = await _db.rawQuery(finalQuery);

    return List<CaseStudy>.generate(
        result.length, (index) => CaseStudy.fromJson(result[index]),
        growable: true);
  }

  // Return first row matched by portfolioId returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Portfolio>> getPortfolioById(
      {required String portfolioId}) async {
    final List<Map<String, dynamic>> result = await _db.rawQuery(
        "SELECT portfolio.* FROM portfolio WHERE portfolio.portfolio_id = '$portfolioId' LIMIT 1;");

    return List<Portfolio>.generate(
        result.length, (index) => Portfolio.fromJson(result[index]),
        growable: true);
  }

  /// Prepare team leaders stored in db.
  Future<List<Leadership>> getAllTeamLeaders() async {
    final List<Map<String, dynamic>> result =
        await _db.rawQuery("SELECT * FROM ${DbConstants.tblLeaders}");

    return List<Leadership>.generate(
        result.length, (index) => Leadership.fromJson(result[index]),
        growable: true);
  }

  // Return first row matched by caseStudyId returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<CaseStudy>> getCaseStudyById(
      {required String caseStudyId}) async {
    final List<Map<String, dynamic>> result = await _db.rawQuery(
        "SELECT * FROM case_study WHERE case_study.case_study_id = '$caseStudyId' LIMIT 1;");

    return List<CaseStudy>.generate(
        result.length, (index) => CaseStudy.fromJson(result[index]),
        growable: true);
  }


  //delete all the rows from the table.
  Future<int> truncateTable(String tableName) async {
    return await _db.delete(tableName);
  }
}
