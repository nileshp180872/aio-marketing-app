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
    _createCaseStudiesTable();
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
            ${DbConstants.enquiryId} TEXT PRIMARY KEY NOT NULL,
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
            ${DbConstants.portfolioId} TEXT PRIMARY KEY NOT NULL,
            ${DbConstants.portfolioDomainId} TEXT,
            ${DbConstants.portfolioDomainName} TEXT,
            ${DbConstants.portfolioScreenType} TEXT,
            ${DbConstants.portfolioScreenName} TEXT,
            ${DbConstants.portfolioProjectName} TEXT,
            ${DbConstants.portfolioProjectDescription} TEXT,
            ${DbConstants.projectImages} TEXT
          )
          ''');
  }

  /// Create leaders table
  void _createLeadersTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblLeaders} (
            ${DbConstants.leaderId} TEXT PRIMARY KEY NOT NULL,
            ${DbConstants.leaderName} TEXT,
            ${DbConstants.leaderDesignation} TEXT,
            ${DbConstants.leaderDescription} TEXT
          )
          ''');
  }

  /// Create case studies table
  void _createCaseStudiesTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblCaseStudies} (
            ${DbConstants.caseStudyId} TEXT PRIMARY KEY NOT NULL,
            ${DbConstants.caseStudyDomainId} TEXT,
            ${DbConstants.caseStudyDomainName} TEXT,
            ${DbConstants.caseStudyProjectName} TEXT,
            ${DbConstants.caseStudyDescription} TEXT,
            ${DbConstants.caseStudyImages} TEXT
          )
          ''');
  }
}
