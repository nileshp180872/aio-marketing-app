import 'package:aio/infrastructure/db/db_constants.dart';
import 'package:aio/infrastructure/db/schema/case_study.dart';
import 'package:aio/infrastructure/db/schema/case_study_images.dart';
import 'package:aio/infrastructure/db/schema/case_study_technology_mapping.dart';
import 'package:aio/infrastructure/db/schema/domain.dart';
import 'package:aio/infrastructure/db/schema/enquiry.dart';
import 'package:aio/infrastructure/db/schema/leadership.dart';
import 'package:aio/infrastructure/db/schema/leadership_type.dart';
import 'package:aio/infrastructure/db/schema/platform.dart';
import 'package:aio/infrastructure/db/schema/portfolio.dart';
import 'package:aio/infrastructure/db/schema/portfolio_images.dart';
import 'package:aio/infrastructure/db/schema/portfolio_technologies.dart';
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
  Future<int> addToDomain(Domain domain) async {
    return await insert(domain.toJson(), DbConstants.tblDomain);
  }

  /// Return all domains as List<Domain>.
  Future<List<Domain>> getAllDomains() async {
    List<dynamic> result = await queryAllRows(DbConstants.tblDomain);

    List<Domain> enquiries = [];
    for (var element in result) {
      enquiries.add(Domain.fromJson(element));
    }
    return enquiries;
  }

  /// Add data to the leadership.
  ///
  /// required [leadershipType] instance of LeadershipType to insert data
  /// into [DbConstants.tblLeadership].
  Future<int> addToLeadershipTypes(LeadershipType leadershipType) async {
    return insert(leadershipType.toJson(), DbConstants.tblLeadership);
  }

  /// Add data to the technologies.
  ///
  /// required [technologies] instance of Technologies to insert data
  /// into [DbConstants.tblTechnologies].
  Future<int> addToTechnologies(Technologies technologies) async {
    return insert(technologies.toJson(), DbConstants.tblTechnologies);
  }

  /// Add data to the leader.
  Future<int> addToLeaders(Leadership leadershipType) async {
    return insert(leadershipType.toJson(), DbConstants.tblLeaders);
  }

  /// Add case studies to db.
  Future<int> addToCaseStudies(CaseStudy caseStudy) async {
    return insert(caseStudy.toJson(), DbConstants.tblCaseStudies);
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

  /// Add data to the platforms.
  Future<int> addToPlatform(Platform platform) async {
    return insert(platform.toJson(), DbConstants.tblPlatform);
  }

  /// Return all platforms.
  Future<List<Platform>> getAllPlatform() async {
    List<dynamic> result = await queryAllRows(DbConstants.tblPlatform);

    List<Platform> enquiries = [];
    for (var element in result) {
      enquiries.add(Platform.fromJson(element));
    }
    return enquiries;
  }

  /// Add portfolio to db.
  Future<int> addToPortfolio(Portfolio portfolio) async {
    return insert(portfolio.toJson(), DbConstants.tblPortfolio);
  }

  /// Add portfolio images to db.
  Future<int> addToPortfolioImage(PortfolioImages portfolioImage) async {
    return insert(portfolioImage.toJson(), DbConstants.tblPortfolioImages);
  }

  /// Add portfolio technologies to db.
  Future<int> addToPortfolioTechnologies(
      PortfolioTechnologies portfolioTechnologies) async {
    return insert(
        portfolioTechnologies.toJson(), DbConstants.tblPortfolioTechnologies);
  }

  /// Add case study images to db.
  Future<int> addToCaseStudyImage(CaseStudyImages caseStudyImages) async {
    return insert(caseStudyImages.toJson(), DbConstants.tblCaseStudyImages);
  }

  /// Add case study technologies to db.
  Future<int> addToCaseStudyTechnologies(
      CaseStudyTechnologyMapping caseStudyTechnologyMapping) async {
    return insert(caseStudyTechnologyMapping.toJson(),
        DbConstants.tblCaseStudiesTechnologies);
  }

  /// Return all portfolios.
  Future<List<Portfolio>> getAllPortfolios() async {
    List<dynamic> result = await queryAllRows(DbConstants.tblPortfolio);

    List<Portfolio> enquiries = [];
    for (var element in result) {
      enquiries.add(Portfolio.fromJson(element));
    }
    return enquiries;
  }

  /// Return all portfolios.
  Future<List<Portfolio>> getFilterPortfolios({
    required List<String> domains,
    required List<String> platforms,
    required List<String> technologies,
  }) async {
    List<dynamic> result = await queryAllRows(DbConstants.tblPortfolio);

    List<Portfolio> enquiries = [];

    for (var element in result) {
      enquiries.add(Portfolio.fromJson(element));
    }
    return enquiries;
  }

  /// Return portfolio detail by Id.
  Future<Portfolio?> getPortfolioById({required String portfolioId}) async {
    List<dynamic> result = await filterDataById(
        table: DbConstants.tblPortfolio,
        columnName: DbConstants.portfolioId,
        id: portfolioId);

    List<Portfolio> enquiries = [];
    for (var element in result) {
      enquiries.add(Portfolio.fromJson(element));
    }
    return enquiries.isNotEmpty ? enquiries.first : null;
  }

  /// Return portfolio detail by search.
  Future<Portfolio?> getPortfolioByName({required String search}) async {
    List<dynamic> result = await filterDataForSearchValue(searchString: search);

    List<Portfolio> enquiries = [];
    for (var element in result) {
      enquiries.add(Portfolio.fromJson(element));
    }
    return enquiries.isNotEmpty ? enquiries.first : null;
  }

  /// Add enquiry to db.
  Future<int> addToEnquiry(Enquiry enquiry) async {
    return insert(enquiry.toJson(), DbConstants.tblEnquiry);
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
  Future<int> getTotalInquiryCount() async {
    return queryRowCount(DbConstants.tblEnquiry);
  }

  /// Clear all tables.
  Future<void> clearAllTables() async {
    await truncateTable(DbConstants.tblDomain);
    await truncateTable(DbConstants.tblTechnologies);
    await truncateTable(DbConstants.tblLeadership);
    await truncateTable(DbConstants.tblPlatform);
    await truncateTable(DbConstants.tblPortfolio);
    await truncateTable(DbConstants.tblEnquiry);
    await truncateTable(DbConstants.tblPortfolioTechnologies);
    await truncateTable(DbConstants.tblPortfolioImages);
    await truncateTable(DbConstants.tblCaseStudies);
    await truncateTable(DbConstants.tblCaseStudiesTechnologies);
    await truncateTable(DbConstants.tblCaseStudyImages);
  }
}
