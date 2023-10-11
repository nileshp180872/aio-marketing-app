import 'package:sqflite/sqflite.dart';

import '../db_constants.dart';

mixin SchemaConfig {
  late Database _db;

  void initialiseTables(Database db) {
    _db = db;

    _createDomainTable();
    _createLeadershipTypeTable();
    _createTechnologiesTable();
    _createEnquiryTable();
    _createPlatformTable();
    _createPortfolioTable();
    _createLeadersTable();
    _createPortfolioImagesTable();
    _createPortfolioTechnologyTable();
    _createCaseStudiesTable();
    _createCaseStudyImagesTable();
    _createCaseStudyTechnologyTable();
    _createCaseStudyTechnologyMappingTable();
  }

  /// Creates domain table.
  void _createDomainTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblDomain} (
            ${DbConstants.domainId} TEXT PRIMARY KEY NOT NULL,
            ${DbConstants.domainName} TEXT NOT NULL
          )
          ''');
  }

  /// Creates leadership type table.
  void _createLeadershipTypeTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblLeadership} (
            ${DbConstants.leadershipId} TEXT PRIMARY KEY NOT NULL,
            ${DbConstants.leadershipName} TEXT NOT NULL
          )
          ''');
  }

  /// Create technologies table
  void _createTechnologiesTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblTechnologies} (
            ${DbConstants.technologicalId} TEXT PRIMARY KEY NOT NULL,
            ${DbConstants.technologicalName} TEXT NOT NULL
          )
          ''');
  }

  /// Create platform table
  void _createPlatformTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblPlatform} (
            ${DbConstants.platformId} TEXT PRIMARY KEY NOT NULL,
            ${DbConstants.platformName} TEXT NOT NULL
          )
          ''');
  }

  /// Create enquiry table
  void _createEnquiryTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblEnquiry} (
            ${DbConstants.enquiryId} TEXT NOT NULL,
            ${DbConstants.enquiryMemberName} TEXT NOT NULL,
            ${DbConstants.enquiryMemberEmail} TEXT NOT NULL,
            ${DbConstants.enquiryMemberPhone} TEXT NOT NULL,
            ${DbConstants.enquiryMemberCompanyName} TEXT NOT NULL,
            ${DbConstants.enquiryMemberMessage} TEXT NOT NULL,
            ${DbConstants.enquirySyncStatus} INTEGER NOT NULL
          )
          ''');
  }

  /// Create enquiry table
  void _createPortfolioTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblPortfolio} (
            ${DbConstants.portfolioAIId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${DbConstants.portfolioId} TEXT NOT NULL,
            ${DbConstants.portfolioDomainId} TEXT,
            ${DbConstants.portfolioDomainName} TEXT,
            ${DbConstants.portfolioScreenType} TEXT,
            ${DbConstants.portfolioScreenName} TEXT,
            ${DbConstants.portfolioProjectName} TEXT,
            ${DbConstants.portfolioProjectDescription} TEXT,
            ${DbConstants.projectImages} TEXT,
            ${DbConstants.projectLink} TEXT
          )
          ''');
  }

  /// Create leaders table
  void _createLeadersTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblLeaders} (
            ${DbConstants.leaderId} TEXT NOT NULL,
            ${DbConstants.leaderName} TEXT,
            ${DbConstants.leaderDesignation} TEXT,
            ${DbConstants.leaderDescription} TEXT,
            ${DbConstants.leaderImage} TEXT
          )
          ''');
  }

  /// Create case studies table
  void _createCaseStudiesTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblCaseStudies} (
          ${DbConstants.caseStudyAIId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${DbConstants.caseStudyId} TEXT NOT NULL,
            ${DbConstants.caseStudyDomainId} TEXT,
            ${DbConstants.caseStudyDomainName} TEXT,
            ${DbConstants.caseStudyProjectName} TEXT,
            ${DbConstants.caseStudyDescription} TEXT,
            ${DbConstants.caseStudyBusinessTitle1} TEXT,
            ${DbConstants.caseStudyBusinessTitle2} TEXT,
            ${DbConstants.caseStudyBusinessTitle3} TEXT,
            ${DbConstants.caseStudyCompanyDescription1} TEXT,
            ${DbConstants.caseStudyCompanyDescription2} TEXT,
            ${DbConstants.caseStudyCompanyDescription3} TEXT,
            ${DbConstants.caseStudyBusinessDescription1} TEXT,
            ${DbConstants.caseStudyBusinessDescription2} TEXT,
            ${DbConstants.caseStudyBusinessDescription3} TEXT,
            ${DbConstants.caseStudySolutionTitle1} TEXT,
            ${DbConstants.caseStudySolutionTitle2} TEXT,
            ${DbConstants.caseStudySolutionTitle3} TEXT,
            ${DbConstants.caseStudySolutionDescription1} TEXT,
            ${DbConstants.caseStudySolutionDescription2} TEXT,
            ${DbConstants.caseStudySolutionDescription3} TEXT,
            ${DbConstants.caseStudyImages} TEXT
          )
          ''');
  }

  /// Create portfolio image table
  void _createPortfolioImagesTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblPortfolioImages} (
            ${DbConstants.portfolioImageId} TEXT,
            ${DbConstants.portfolioImagePath} TEXT,
            ${DbConstants.portfolioImagePortfolioId} TEXT
          )
          ''');
  }

  /// Create portfolio technology table
  void _createPortfolioTechnologyTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblPortfolioTechnologies} (
            ${DbConstants.portfolioTechnologyId} TEXT,
            ${DbConstants.portfolioTechnologyName} TEXT,
            ${DbConstants.portfolioTableId} TEXT
          )
          ''');
  }

  /// Create case study technology table
  void _createCaseStudyTechnologyTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblCaseStudiesTechnologies} (
            ${DbConstants.caseStudyTechnologyId} TEXT,
            ${DbConstants.caseStudyTechnologyName} TEXT,
            ${DbConstants.caseStudyTableId} TEXT
          )
          ''');
  }

  /// Create case study technology mapping table
  void _createCaseStudyTechnologyMappingTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblCaseStudiesTechImageMapping} (
            ${DbConstants.caseStudyTechImageId} TEXT,
            ${DbConstants.caseStudyTechImageName} TEXT,
            ${DbConstants.caseStudyTechMapCaseStudyTableId} TEXT
          )
          ''');
  }

  /// Create case study image table
  void _createCaseStudyImagesTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblCaseStudyImages} (
            ${DbConstants.caseStudyImageId} TEXT,
            ${DbConstants.caseStudyImagePath} TEXT,
            ${DbConstants.caseStudyImageCaseStudyId} TEXT
          )
          ''');
  }
}
