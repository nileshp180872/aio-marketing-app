import 'package:aio/infrastructure/db/db_constants.dart';
import 'package:aio/infrastructure/db/schema/domain.dart';
import 'package:aio/infrastructure/db/schema/enquiry.dart';
import 'package:aio/infrastructure/db/schema/leadership_type.dart';
import 'package:aio/infrastructure/db/schema/technologies.dart';

import 'config/db_config.dart';
import 'config/schema_config.dart';

class DatabaseHelper with DbConfig, SchemaConfig {
  static const kDatabaseName = "aio.db";
  static const kDatabaseVersion = 1;

  /// Initialise db
  void initialiseDb() {
    init(
        databaseName: kDatabaseName,
        databaseVersion: kDatabaseVersion,
        onCreateDb: initialiseTables);
  }

  /// Add data to the domain.
  Future<int> addToDomain(Domain domain) async{
    return await insert(domain.toJson(), DbConstants.tblDomain);
  }

  /// Return all domains.
  Future<List<Domain>> getAllDomains() async {
    List<dynamic> result = await queryAllRows(DbConstants.tblDomain);

    List<Domain> enquiries = [];
    for (var element in result) {
      enquiries.add(Domain.fromJson(element));
    }
    return enquiries;
  }

  /// Add data to the leadership.
  void addToLeadershipTypes(LeadershipType leadershipType) {
    insert(leadershipType.toJson(), DbConstants.tblLeadership);
  }

  /// Add data to the technologies.
  void addToTechnologies(Technologies technologies) {
    insert(technologies.toJson(), DbConstants.tblTechnologies);
  }

  /// Return all domains.
  Future<List<Technologies>> getAllTechnologies() async {
    List<dynamic> result = await queryAllRows(DbConstants.tblTechnologies);

    List<Technologies> enquiries = [];
    for (var element in result) {
      enquiries.add(Technologies.fromJson(element));
    }
    return enquiries;
  }

  /// Add enquiry to db.
  void addToEnquiry(Enquiry enquiry) {
    insert(enquiry.toJson(), DbConstants.tblEnquiry);
  }

  /// Return all enquiries.
  Future<List<Enquiry>> getAllEnquiries() async {
    List<dynamic> result = await queryAllRows(DbConstants.tblEnquiry);

    List<Enquiry> enquiries = [];
    for (var element in result) {
      enquiries.add(Enquiry.fromJson(element));
    }
    return enquiries;
  }

  /// Return all enquiries.
  Future<List<Enquiry>> getFirstColumn() async {
    List<dynamic> result = await queryOneRows(DbConstants.tblEnquiry);

    List<Enquiry> enquiries = [];
    for (var element in result) {
      enquiries.add(Enquiry.fromJson(element));
    }
    return enquiries;
  }

  /// Return count of available inquires data.
  Future<int> getTotalInquiryCount() async{
    return queryRowCount(DbConstants.tblEnquiry);
  }
}
