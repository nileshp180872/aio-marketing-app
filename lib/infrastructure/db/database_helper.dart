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
  /// Update portfolio image to db.
  Future<int> updateToCaseStudies(CaseStudy caseStudy) async {
    return update(
        caseStudy.toJson(),
        caseStudy.caseStudyId ?? "",
        DbConstants.caseStudyId,
        DbConstants.tblCaseStudies);
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

  /// Update portfolio to db.
  Future<int> updateToPortfolio(Portfolio portfolio) async {
    return update(portfolio.toJson(), portfolio.portfolioId ?? "",
        DbConstants.portfolioId, DbConstants.tblPortfolio);
  }

  /// Add portfolio images to db.
  Future<int> addToPortfolioImage(PortfolioImages portfolioImage) async {
    return insert(portfolioImage.toJson(), DbConstants.tblPortfolioImages);
  }

  /// Update portfolio image to db.
  Future<int> updateToPortfolioImage(PortfolioImages portfolioImage) async {
    return update(
        portfolioImage.toJson(),
        portfolioImage.portfolioImageId ?? "",
        DbConstants.portfolioImageId,
        DbConstants.tblPortfolioImages);
  }

  /// Add portfolio technologies to db.
  Future<int> addToPortfolioTechnologies(
      PortfolioTechnologies portfolioTechnologies) async {
    return insert(
        portfolioTechnologies.toJson(), DbConstants.tblPortfolioTechnologies);
  }

  /// Update portfolio technology to db.
  Future<int> updateToPortfolioTechnology(
      PortfolioTechnologies portfolioTechnologies) async {
    return update(
        portfolioTechnologies.toJson(),
        portfolioTechnologies.portfolioTechnologyId ?? "",
        DbConstants.portfolioTechnologyId,
        DbConstants.tblPortfolioTechnologies);
  }

  /// Add case study images to db.
  Future<int> addToCaseStudyImage(CaseStudyImages caseStudyImages) async {
    return insert(caseStudyImages.toJson(), DbConstants.tblCaseStudyImages);
  }

  /// Update portfolio image to db.
  Future<int> updateToCaseStudyImage(CaseStudyImages caseStudyImages) async {
    return update(
        caseStudyImages.toJson(),
        caseStudyImages.caseStudyImageId ?? "",
        DbConstants.caseStudyImageId,
        DbConstants.tblCaseStudyImages);
  }

  /// Add case study technologies to db.
  Future<int> addToCaseStudyTechnologies(
      CaseStudyTechnologyMapping caseStudyTechnologyMapping) async {
    return insert(caseStudyTechnologyMapping.toJson(),
        DbConstants.tblCaseStudiesTechnologies);
  }

  /// Update portfolio technology to db.
  Future<int> updateToCaseStudyTechnology(
      CaseStudyTechnologyMapping caseStudyTechnologyMapping) async {
    return update(
        caseStudyTechnologyMapping.toJson(),
        caseStudyTechnologyMapping.caseStudyTechnologyId ?? "",
        DbConstants.caseStudyTechnologyId,
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

  /// Return all case studies.
  Future<List<CaseStudy>> getAllCaseStudies() async {
    List<dynamic> result = await queryAllRows(DbConstants.tblCaseStudies);

    List<CaseStudy> enquiries = [];
    for (var element in result) {
      enquiries.add(CaseStudy.fromJson(element));
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
  Future<Portfolio?> getPortfolioDetails({required String portfolioId}) async {
    List<dynamic> result = await getPortfolioById(portfolioId: portfolioId);
    return result.isNotEmpty ? result.first : null;
  }

  /// Return case study detail by Id.
  Future<CaseStudy?> getCaseStudyDetails({required String caseStudyId}) async {
    List<dynamic> result = await getCaseStudyById(caseStudyId: caseStudyId);
    return result.isNotEmpty ? result.first : null;
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

  /// Return  comma separated technologies of specific portfolio.
  ///
  /// required [id] -> portfolio id
  Future<String> getPortfolioTechnologies({required String id}) async {
    List<dynamic> result = await filterDataById(
        table: DbConstants.tblPortfolioTechnologies,
        columnName: DbConstants.portfolioTableId,
        id: id);
    if (result.isNotEmpty) {
      List<PortfolioTechnologies> enquiries = [];
      for (var element in result) {
        enquiries.add(PortfolioTechnologies.fromJson(element));
      }
      return (enquiries.map((e) => e.portfolioTechnologyName ?? "").toList())
          .join(",");
    } else {
      return "";
    }
  }

  /// Return  comma separated technologies of specific case study.
  ///
  /// required [id] -> case study id
  Future<String> getCaseStudyTechnologies({required String id}) async {
    List<dynamic> result = await filterDataById(
        table: DbConstants.tblCaseStudiesTechnologies,
        columnName: DbConstants.caseStudyTableId,
        id: id);
    if (result.isNotEmpty) {
      List<CaseStudyTechnologyMapping> enquiries = [];
      for (var element in result) {
        enquiries.add(CaseStudyTechnologyMapping.fromJson(element));
      }
      return (enquiries.map((e) => e.caseStudyTechnologyName ?? "").toList())
          .join(",");
    } else {
      return "";
    }
  }

  /// Return  portfolio images with list of [PortfolioImages]
  ///
  /// required [id] -> portfolio id
  Future<List<PortfolioImages>> getPortfolioImages({required String id}) async {
    List<dynamic> result = await filterDataById(
        table: DbConstants.tblPortfolioImages,
        columnName: DbConstants.portfolioImagePortfolioId,
        id: id);
    if (result.isNotEmpty) {
      List<PortfolioImages> enquiries = [];
      for (var element in result) {
        enquiries.add(PortfolioImages.fromJson(element));
      }
      return enquiries;
    } else {
      return [];
    }
  }

  /// Return  case study images with list of [CaseStudyImages]
  ///
  /// required [id] -> case study id
  Future<List<CaseStudyImages>> getCaseStudyImages({required String id}) async {
    List<dynamic> result = await filterDataById(
        table: DbConstants.tblCaseStudyImages,
        columnName: DbConstants.caseStudyImageCaseStudyId,
        id: id);
    if (result.isNotEmpty) {
      List<CaseStudyImages> enquiries = [];
      for (var element in result) {
        enquiries.add(CaseStudyImages.fromJson(element));
      }
      return enquiries;
    } else {
      return [];
    }
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
    await truncateTable(DbConstants.tblPortfolioTechnologies);
    await truncateTable(DbConstants.tblPortfolioImages);
    await truncateTable(DbConstants.tblCaseStudies);
    await truncateTable(DbConstants.tblCaseStudiesTechnologies);
    await truncateTable(DbConstants.tblCaseStudyImages);
  }
}
