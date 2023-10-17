import 'dart:convert';

import 'package:aio/infrastructure/cache/shared_cofig.dart';
import 'package:aio/infrastructure/db/db_constants.dart';
import 'package:aio/infrastructure/db/schema/case_study_images.dart';
import 'package:aio/infrastructure/db/schema/case_study_technology_mapping.dart';
import 'package:aio/infrastructure/db/schema/domain.dart';
import 'package:aio/infrastructure/db/schema/leadership.dart';
import 'package:aio/infrastructure/db/schema/portfolio.dart';
import 'package:aio/infrastructure/db/schema/portfolio_images.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:synchronized/synchronized.dart';

import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/case_study.dart';
import '../../../infrastructure/db/schema/case_study_tech_image.dart';
import '../../../infrastructure/db/schema/leadership_type.dart';
import '../../../infrastructure/db/schema/platform.dart';
import '../../../infrastructure/db/schema/portfolio_technologies.dart';
import '../../../infrastructure/db/schema/technologies.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/network/model/case_studies_response.dart';
import '../../../infrastructure/network/model/domain_response.dart';
import '../../../infrastructure/network/model/leaders_response.dart';
import '../../../infrastructure/network/model/leadership_type_response.dart';
import '../../../infrastructure/network/model/platform_response.dart';
import '../../../infrastructure/network/model/portfolio_response.dart';
import '../../../infrastructure/network/model/technology_response.dart';
import '../../../utils/utils.dart';
import '../provider/synchronisation.provider.dart';

class SynchronisationController extends GetxController {
  late DatabaseHelper _dbHelper;

  /// logger
  final logger = Logger();

  final SynchronisationProvider _provider = SynchronisationProvider();

  // prevent concurrent access to data
  var lock = Lock();

  RxBool enableAnimation = true.obs;

  /// is network enable
  RxBool isNetworkEnable = false.obs;

  @override
  void onInit() {
    _setupFields();
    super.onInit();
  }

  /// Setup fields.
  void _setupFields() async {
    _dbHelper = GetIt.I<DatabaseHelper>();

    isNetworkEnable.value = await Utils.isConnected();

    if (isNetworkEnable.value) {
      _dbHelper.clearAllTables();
      Future.delayed(
          const Duration(
            seconds: 1,
          ),
          () => getAPIS());
    }
  }

  void _checkPermission() async {
    Permission permission = GetPlatform.isAndroid?Permission.manageExternalStorage:Permission.storage;
    final permissionStatus = await permission.status;
    Get.log("permissionStatus ${permissionStatus}");
    if (permissionStatus.isDenied) {
      // Here just ask for the permission for the first time
      await permission.request();
      if (permissionStatus.isDenied) {
        await openAppSettings();
      }else{
        getAPIS();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      getAPIS();
    }
  }

  /// Get domains API.
  void getAPIS() async {
    if (await Utils.isConnected()) {
      await lock.synchronized(() async {
        await Future.wait(
          [
            _getDomains(),
            _getTechnologies(),
            _getLeaderships(),
            _getPlatforms(),
            _getLeaders(),
          ],
        ).then((value) async {
          _synchronizeEnquiryWithServer();
          await Future.wait(
            [
              _syncPortfolio(),
              _syncCaseStudy(),
            ],
          );
        });
      }).then((value) {
        var now = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');
        String formattedDate = formatter.format(now);
        GetIt.I<SharedPreference>().setLastDbSyncDate(formattedDate);
        Get.offAllNamed(Routes.HOME);
      });
    } else {
      logger.i("Sync not processed due to internet connectivity.");
    }
  }

  /// Get domains
  Future<void> _getDomains() async {
    final response = await _provider.getDomains();
    if (response.data != null) {
      if (response.statusCode == 200) {
        _domainAPISuccess(response);
      } else {
        _domainAPIError(response);
      }
    } else {
      _domainAPIError(response);
    }
  }

  /// Get technologies
  Future<void> _getTechnologies() async {
    final response = await _provider.getTechnologies();
    if (response.data != null) {
      if (response.statusCode == 200) {
        _technologiesAPISuccess(response);
      } else {
        _domainAPIError(response);
      }
    }
  }

  /// Get platforms
  Future<void> _getPlatforms() async {
    final response = await _provider.getPlatforms();
    if (response.data != null) {
      if (response.statusCode == 200) {
        _platformAPISuccess(response);
      } else {
        _domainAPIError(response);
      }
    }
  }

  /// Check if getLastDbSyncDate is empty then update portfolio.
  /// otherwise call all the data API.
  Future<void> _syncPortfolio() {
    if (GetIt.I<SharedPreference>().getLastDbSyncDate.isEmpty) {
      return _getPortfolios();
    } else {
      return _getUpdatedPortfolios();
    }
  }

  /// Check if getLastDbSyncDate is empty then update case study
  /// otherwise call all the data API.
  Future<void> _syncCaseStudy() {
    if (GetIt.I<SharedPreference>().getLastDbSyncDate.isEmpty) {
      return _getCaseStudies();
    } else {
      return _getUpdatedCaseStudies();
    }
  }

  /// Get portfolio API.
  Future<void> _getPortfolios() async {
    final response = await _provider.getAllPortfolios();
    if (response.data != null) {
      if (response.statusCode == 200) {
        _portfolioAPISuccess(response);
      } else {
        _domainAPIError(response);
      }
    }
  }

  /// Get case studies API.
  Future<void> _getCaseStudies() async {
    final response = await _provider.getCaseStudies();
    if (response.data != null) {
      if (response.statusCode == 200) {
        _caseStudyAPISuccess(response);
      } else {
        _domainAPIError(response);
      }
    }
  }

  /// Get portfolio API.
  Future<void> _getUpdatedPortfolios() async {
    final response = await _provider.getUpdatedPortfolios(
        date: GetIt.I<SharedPreference>().getLastDbSyncDate);
    if (response.data != null) {
      if (response.statusCode == 200) {
        _portfolioUpdateAPISuccess(response);
      } else {
        _domainAPIError(response);
      }
    }
  }

  /// Get portfolio API.
  Future<void> _getUpdatedCaseStudies() async {
    final response = await _provider.getUpdatedCaseStudy(
        date: GetIt.I<SharedPreference>().getLastDbSyncDate);
    if (response.data != null) {
      if (response.statusCode == 200) {
        _caseStudyUpdateAPISuccess(response);
      } else {
        _domainAPIError(response);
      }
    }
  }

  /// Get leadership types
  Future<void> _getLeaderships() async {
    final response = await _provider.getLeadership();
    if (response.data != null) {
      if (response.statusCode == 200) {
        _leadershipTypeAPISuccess(response);
      } else {
        _domainAPIError(response);
      }
    }
  }

  /// Get leaders leaders
  Future<void> _getLeaders() async {
    final response = await _provider.getLeaders();
    if (response.data != null) {
      if (response.statusCode == 200) {
        _leaderAPISuccess(response);
      } else {
        _domainAPIError(response);
      }
    }
  }

  /// Domain success
  ///
  /// required [response] response.
  void _domainAPISuccess(dio.Response response) async {
    final domainResponse = DomainResponse.fromJson(response.data);
    if ((domainResponse.data ?? []).isNotEmpty) {
      for (DomainResponseData element in (domainResponse.data ?? [])) {
        try {
          if (!(element.isDeleted ?? false)) {
            final model = Domain(
                domainId: element.id ?? "",
                domainName: element.domainName ?? "");
            await _dbHelper.addToDomain(model);
          }
        } catch (ex) {
          logger.e(ex);
        }
      }
    }
  }

  /// Technologies success
  ///
  /// required [response] response.
  void _technologiesAPISuccess(dio.Response response) async {
    final technologyResponse = TechnologyResponse.fromJson(response.data);
    if ((technologyResponse.data ?? []).isNotEmpty) {
      for (TechnologyResponseData element in (technologyResponse.data ?? [])) {
        try {
          if (!(element.isDeleted ?? false)) {
            final model = Technologies(
                technologyId: element.id ?? "",
                technologyName: element.techName ?? "");
            await _dbHelper.addToTechnologies(model);
          }
        } catch (ex) {
          logger.e(ex);
        }
      }
    }
  }

  /// Platform success
  ///
  /// required [response] response.
  void _platformAPISuccess(dio.Response response) async {
    final leadershipResponse = PlatformResponse.fromJson(response.data);
    if ((leadershipResponse.data ?? []).isNotEmpty) {
      for (PlatformData element in (leadershipResponse.data ?? [])) {
        try {
          if (!(element.isDeleted ?? false)) {
            final model = Platform(
                platformId: element.id ?? "",
                platformName: element.screenType ?? "");
            await _dbHelper.addToPlatform(model);
          }
        } catch (ex) {
          logger.e(ex);
        }
      }
    }
  }

  /// Portfolio API success
  ///
  /// required [response] response.
  void _portfolioAPISuccess(dio.Response response) async {
    final leadershipResponse = PortfolioResponse.fromJson(response.data);

    if ((leadershipResponse.data ?? []).isNotEmpty) {
      for (PortfolioResponseData element in (leadershipResponse.data ?? [])) {
        try {
          await _addPortfolioData(element);
          await _addPortfolioImages(element);
          await _addPortfolioTechnologies(element);
        } catch (ex) {
          logger.e(ex);
        }
      }
    }
  }

  /// Portfolio Update API success
  ///
  /// required [response] response.
  void _portfolioUpdateAPISuccess(dio.Response response) async {
    final leadershipResponse = PortfolioResponse.fromJson(response.data);
    if ((leadershipResponse.data ?? []).isNotEmpty) {
      for (PortfolioResponseData element in (leadershipResponse.data ?? [])) {
        try {
          if ((element.isDeleted ?? false)) {
            await _addPortfolioData(element, isDelete: true);
            await _addPortfolioImages(element, isDelete: true);
            await _addPortfolioTechnologies(element, isDelete: true);
          } else if ((element.modifiedOn ?? "").isNotEmpty) {
            await _addPortfolioData(element, isUpdate: true);
            await _addPortfolioImages(element, isUpdate: true);
            await _addPortfolioTechnologies(element, isUpdate: true);
          } else {
            await _addPortfolioData(element);
            await _addPortfolioImages(element);
            await _addPortfolioTechnologies(element);
          }
        } catch (ex) {
          logger.e(ex);
        }
      }
    }
  }

  /// Portfolio Update API success
  ///
  /// required [response] response.
  void _caseStudyUpdateAPISuccess(dio.Response response) async {
    final leadershipResponse = CaseStudiesResponse.fromJson(response.data);
    if ((leadershipResponse.data ?? []).isNotEmpty) {
      for (CaseStudiesResponseData element in (leadershipResponse.data ?? [])) {
        try {
          if ((element.isDeleted ?? false)) {
            await _addCaseStudies(element, isDelete: true);
            await _addCaseStudyImages(element, isDelete: true);
            await _addCaseStudyTechnologies(element, isDelete: true);
            await _addCaseStudyTechnologyImages(element, isDelete: true);
          } else if ((element.modifiedOn ?? "").isNotEmpty) {
            await _addCaseStudies(element, isUpdate: true);
            await _addCaseStudyImages(element, isUpdate: true);
            await _addCaseStudyTechnologies(element, isUpdate: true);
            await _addCaseStudyTechnologyImages(element, isUpdate: true);
          } else {
            await _addCaseStudies(element);
            await _addCaseStudyImages(element);
            await _addCaseStudyTechnologies(element);
            await _addCaseStudyTechnologyImages(element);
          }
        } catch (ex) {
          logger.e(ex);
        }
      }
    }
  }

  /// Save portfolio data
  Future<void> _addPortfolioData(PortfolioResponseData element,
      {bool isUpdate = false, bool isDelete = false}) async {
    final model = Portfolio(
        portfolioDomainId: element.domainID,
        portfolioDomainName: element.domainName,
        portfolioId: element.portfolioID,
        portfolioLink: element.urlLink,
        portfolioProjectDescription: element.description,
        portfolioProjectName: element.projectName,
        portfolioScreenTypeId: element.screenTYPE,
        portfolioScreenTypeName: element.screenNAME);
    if (isUpdate) {
      await _dbHelper.updateToPortfolio(model);
    } else if (isDelete) {
      await _dbHelper.deletePortfolio(model);
    } else {
      await _dbHelper.addToPortfolio(model);
    }
  }

  /// Portfolio images
  Future<void> _addPortfolioImages(PortfolioResponseData element,
      {bool isUpdate = false, bool isDelete = false}) async {
    (element.imageMapping ?? []).forEach((imageMappingElement) async {
      try {
        String leaderImage = "";
        try {
          leaderImage = await Utils.getImagePath(
              imageURL: imageMappingElement.portfolioImage ?? "",
              locationName: "portfolio");
        } catch (ex) {
          print("portfolio error $ex");
        }
        final portfolioImage = PortfolioImages(
            portfolioImageId: imageMappingElement.portfolioID,
            portfolioImagePath: leaderImage,
            portfolioImagePortfolioId: element.portfolioID);
        if (isUpdate) {
          await _dbHelper.updateToPortfolioImage(portfolioImage);
        } else if (isDelete) {
          await _dbHelper.deletePortfolioImages(portfolioImage);
        } else {
          await _dbHelper.addToPortfolioImage(portfolioImage);
        }
      } catch (ex) {
        logger.e(ex);
      }
    });
  }

  /// Add portfolio technologies
  Future<void> _addPortfolioTechnologies(PortfolioResponseData element,
      {bool isUpdate = false, bool isDelete = false}) async {
    (element.techMapping ?? []).forEach((technologyMappingElement) async {
      try {
        final techMapping = PortfolioTechnologies(
            portfolioTechnologyId: technologyMappingElement.techID,
            portfolioTechnologyName: technologyMappingElement.techName,
            portfolioTechnologyPortfolioId: element.portfolioID);
        if (isUpdate) {
          await _dbHelper.updateToPortfolioTechnology(techMapping);
        } else if (isDelete) {
          await _dbHelper.deletePortfolioTechnologies(techMapping);
        } else {
          await _dbHelper.addToPortfolioTechnologies(techMapping);
        }
      } catch (ex) {
        logger.e(ex);
      }
    });
  }

  /// Portfolio API success
  ///
  /// required [response] response.
  void _caseStudyAPISuccess(dio.Response response) async {
    final leadershipResponse = CaseStudiesResponse.fromJson(response.data);
    if ((leadershipResponse.data ?? []).isNotEmpty) {
      (leadershipResponse.data ?? []).forEach((element) async {
        try {
          await _addCaseStudies(element);
          await _addCaseStudyImages(element);
          await _addCaseStudyTechnologies(element);
          await _addCaseStudyTechnologyImages(element);
        } catch (ex) {
          logger.e(ex);
        }
      });
    }
  }

  /// Add case studies
  Future<void> _addCaseStudies(CaseStudiesResponseData element,
      {bool isUpdate = false, bool isDelete = false}) async {
    String thumbnailImage = "";
    try {
      thumbnailImage = await Utils.getImagePath(
          imageURL: element.thumbnailImage ?? "",
          locationName: "case_study_thumbnail");
    } catch (ex) {
      print("thumbnailImage error $ex");
    }
    String bannerImage = "";
    try {
      bannerImage = await Utils.getImagePath(
          imageURL: element.bannerImage ?? "",
          locationName: "case_study_banner");
    } catch (ex) {
      print("banner error $ex");
    }

    String businessSolution1 = "";
    try {
      businessSolution1 = await Utils.getImagePath(
          imageURL: element.solutionImage1 ?? "",
          locationName: "case_study_solution1");
    } catch (ex) {
      print("banner error $ex");
    }

    String businessSolution2 = "";
    try {
      businessSolution2 = await Utils.getImagePath(
          imageURL: element.solutionImage2 ?? "",
          locationName: "case_study_solution2");
    } catch (ex) {
      print("businessSolution2 error $ex");
    }

    String businessSolution3 = "";
    try {
      businessSolution3 = await Utils.getImagePath(
          imageURL: element.solutionImage3 ?? "",
          locationName: "case_study_solution3");
    } catch (ex) {
      print("businessSolution3 error $ex");
    }

    String businessImage1 = "";
    try {
      businessImage1 = await Utils.getImagePath(
          imageURL: element.businessImage1 ?? "",
          locationName: "case_study_business1");
    } catch (ex) {
      print("businessImage1 error $ex");
    }

    String businessImage2 = "";
    try {
      businessImage2 = await Utils.getImagePath(
          imageURL: element.businessImage1 ?? "",
          locationName: "case_study_business1");
    } catch (ex) {
      print("businessImage2 error $ex");
    }

    String businessImage3 = "";
    try {
      businessImage3 = await Utils.getImagePath(
          imageURL: element.businessImage1 ?? "",
          locationName: "case_study_business1");
    } catch (ex) {
      print("businessImage3 error $ex");
    }

    String companyImage = "";
    try {
      companyImage = await Utils.getImagePath(
          imageURL: element.companyImage ?? "",
          locationName: "case_study_business1");
    } catch (ex) {
      print("companyImage error $ex");
    }

    final model = CaseStudy(
        caseStudyId: element.casestudiesID,
        caseStudyDomainId: element.domainID,
        caseStudyProjectName: element.projectName,
        caseStudyDomainName: element.domainName,
        caseStudyBusinessDescription1: element.solutionDescription1,
        caseStudyBusinessDescription2: element.solutionDescription2,
        caseStudyBusinessDescription3: element.solutionDescription3,
        caseStudyBusinessImage1: businessImage1,
        caseStudyBusinessImage2: businessImage2,
        caseStudyBusinessImage3: businessImage3,
        caseStudyBusinessTitle1: element.businessTitle1,
        caseStudyBusinessTitle2: element.businessTitle2,
        caseStudyBusinessTitle3: element.businessTitle3,
        caseStudyCompanyTitle: element.companyTitle,
        caseStudyCompanyImage: companyImage,
        caseStudyCompanyDescription: element.companyDescription,
        caseStudyCompanyName: element.companyName,
        caseStudyLink: element.urlLink,
        caseStudyDocument: element.document,
        caseStudySolutionDescription1: element.solutionDescription1,
        caseStudySolutionDescription2: element.solutionDescription2,
        caseStudySolutionDescription3: element.solutionDescription3,
        caseStudySolutionTitle1: element.solutionTitle1,
        caseStudySolutionTitle2: element.solutionTitle2,
        caseStudySolutionTitle3: element.solutionTitle3,
        caseStudySolutionImage1: businessSolution1,
        caseStudySolutionImage2: businessSolution2,
        caseStudySolutionImage3: businessSolution3,
        caseStudyProjectDescription: element.description1,
        caseStudyThumbnailImage: thumbnailImage,
        caseStudyConclusion: element.conclusion,
        caseStudyBannerImage: bannerImage);
    Get.log("inserting case study ${json.encode(model.toJson())}");
    if (isUpdate) {
      await _dbHelper.updateToCaseStudies(model);
    } else if (isDelete) {
      await _dbHelper.deleteCaseStudy(model);
    } else {
      await _dbHelper.addToCaseStudies(model);
    }
  }

  /// Case study images
  Future<void> _addCaseStudyImages(CaseStudiesResponseData element,
      {bool isUpdate = false, bool isDelete = false}) async {
    (element.imageMapping ?? []).forEach((imageMappingElement) async {
      String businessCasestudyImage = "";
      try {
        try {
          businessCasestudyImage = await Utils.getImagePath(
              imageURL: imageMappingElement.casestudiesImage ?? "",
              locationName: "casestudy");
        } catch (ex) {
          print("businessCasestudyImage error $ex");
        }

        final caseStudyImage = CaseStudyImages(
            caseStudyImageId: imageMappingElement.casestudiesID,
            caseStudyImagePath: businessCasestudyImage,
            caseStudyImagePortfolioId: element.casestudiesID);
        if (isUpdate) {
          await _dbHelper.updateToCaseStudyImage(caseStudyImage);
        } else if (isDelete) {
          await _dbHelper.deleteCaseStudyImages(caseStudyImage);
        } else {
          await _dbHelper.addToCaseStudyImage(caseStudyImage);
        }
      } catch (ex) {
        logger.e(ex);
      }
    });
  }

  /// Add case study technologies
  Future<void> _addCaseStudyTechnologies(CaseStudiesResponseData element,
      {bool isUpdate = false, bool isDelete = false}) async {
    try {
      (element.techMapping ?? []).forEach((technologyMappingElement) async {
        final techMapping = CaseStudyTechnologyMapping(
            caseStudyTechnologyId: technologyMappingElement.techId,
            caseStudyTechnologyName: technologyMappingElement.techName,
            caseStudyTableId: element.casestudiesID);
        if (isUpdate) {
          await _dbHelper.updateToCaseStudyTechnology(techMapping);
        } else if (isDelete) {
          await _dbHelper.deleteCaseStudyTechnologies(techMapping);
        } else {
          await _dbHelper.addToCaseStudyTechnologies(techMapping);
        }
      });
    } catch (ex) {
      logger.e(ex);
    }
  }

  /// Add case study technologies
  Future<void> _addCaseStudyTechnologyImages(CaseStudiesResponseData element,
      {bool isUpdate = false, bool isDelete = false}) async {
    Get.log("_addCaseStudyTechnologyImages");
    try {
      (element.techImageMapping ?? [])
          .forEach((technologyMappingElement) async {
        String technologyImage = "";
        try {
          technologyImage = await Utils.getImagePath(
              imageURL: technologyMappingElement.techImage ?? "",
              locationName: "casestudy_tech_image");
        } catch (ex) {
          print("technologyImage error $ex");
        }
        final techMapping = CaseStudyTechImages(
            caseStudyTechImageId: technologyMappingElement.casestudiesId,
            caseStudyTechImagePath: technologyImage,
            caseStudyTechImagePortfolioId: element.casestudiesID);
        if (isUpdate) {
          await _dbHelper.updateToCaseStudyTechnologyImage(techMapping);
        } else if (isDelete) {
          await _dbHelper.deleteCaseStudyTechnologyImages(techMapping);
        } else {
          await _dbHelper.addToCaseStudyTechnologyImages(techMapping);
        }
      });
    } catch (ex) {
      logger.e(ex);
    }
  }

  /// Leadership Types success
  ///
  /// required [response] response.
  void _leadershipTypeAPISuccess(dio.Response response) async {
    final leadershipResponse = LeadershipTypeResponse.fromJson(response.data);
    if ((leadershipResponse.data ?? []).isNotEmpty) {
      for (LeadershipTypeData element in (leadershipResponse.data ?? [])) {
        try {
          final model = LeadershipType(
              leadershipTypeId: element.id,
              leadershipTypeName: element.leaderType);
          await _dbHelper.addToLeadershipTypes(model);
        } catch (ex) {
          logger.e(ex);
        }
      }
    }
  }

  /// Leaders API success
  ///
  /// required [response] response.
  void _leaderAPISuccess(dio.Response response) async {
    final leadershipResponse = LeadersResponse.fromJson(response.data);

    if ((leadershipResponse.data ?? []).isNotEmpty) {
      for (LeadersResponseData element in (leadershipResponse.data ?? [])) {
        try {
          String leaderImage = "";
          if ((element.imageMapping ?? []).isNotEmpty) {
            leaderImage = (element.imageMapping ?? []).first.leaderImage ?? "";
          }
          try {
            leaderImage = await Utils.getImagePath(
                imageURL: leaderImage ?? "", locationName: "leaders");
          } catch (ex) {
            print("thumbnailImage error $ex");
          }
          final model = Leadership(
              leaderId: element.leadershipID,
              description: element.description,
              leaderName: element.leaderNAME,
              image: leaderImage,
              designation: element.designation);
          await _dbHelper.addToLeaders(model);
        } catch (ex) {
          logger.e(ex);
        }
      }
    }
  }

  /// Domain error
  ///
  /// required [response] response.
  void _domainAPIError(dio.Response response) {
    enableAnimation.value = false;
    Utils.showErrorMessage(message: response.statusMessage ?? "");
  }

  /// Synchronize enquiry with server.
  void _synchronizeEnquiryWithServer() async {
    final storedEnquiries = await _dbHelper.getTotalInquiryCount();
    if (storedEnquiries > 0) {
      for (int i = 0; i < storedEnquiries; i++) {
        await _syncWithServer();
      }
    }
  }

  /// _sync data with server.
  ///
  /// returns true if server response is success and data deleted
  /// from device storage.
  Future<bool> _syncWithServer() async {
    final queryList = await _dbHelper.getFirstColumn();
    final response = await _provider.addInquiry(queryList.first);
    if (response.statusCode == 200) {
      final deleteResponse = await _dbHelper.delete(
          id: queryList.first.enquiryId ?? "",
          table: DbConstants.tblEnquiry,
          columnName: DbConstants.enquiryId);
      return deleteResponse == 1;
    } else {
      return false;
    }
  }

  /// on back.
  void onGetBack() {
    Get.offAllNamed(Routes.HOME);
  }
}
