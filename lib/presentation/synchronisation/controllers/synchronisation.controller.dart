import 'package:aio/infrastructure/db/db_constants.dart';
import 'package:aio/infrastructure/db/schema/domain.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:synchronized/synchronized.dart';

import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/leadership_type.dart';
import '../../../infrastructure/db/schema/technologies.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/network/model/domain_response.dart';
import '../../../infrastructure/network/model/leadership_type.dart';
import '../../../infrastructure/network/model/technology_response.dart';
import '../../../utils/utils.dart';
import '../provider/synchronisation.provider.dart';

class SynchronisationController extends GetxController {
  late DatabaseHelper _dbHelper;

  final logger = Logger();

  final SynchronisationProvider _provider = SynchronisationProvider();

  // prevent concurrent access to data
  var lock = Lock();

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
      Future.delayed(
          const Duration(
            seconds: 1,
          ),
          () => getAPIS());
    }
  }

  /// Get domains API.
  void getAPIS() async {
    if (await Utils.isConnected()) {
      await lock.synchronized(() async {
        Future.wait(
          [
            _getDomains(),
            _getTechnologies(),
            _getLeaderships(),
          ],
        ).then((value) => _synchronizeEnquiryWithServer);
      }).then((value) {
        logger.i("Data synchronised!.");
        Get.offAllNamed(Routes.HOME);
      });
    } else {
      logger.i("Sync not processed due to internet connectivity.");
    }
  }

  /// Get domains
  Future<void> _getDomains() async {
    final response = await _provider.getDomains();
    if (response.data == null) {
      if (response.statusCode == 200) {
        _domainAPISuccess(response.data);
      } else {
        _domainAPIError(response.data);
      }
    }
  }

  /// Get technologies
  Future<void> _getTechnologies() async {
    final response = await _provider.getTechnologies();
    if (response.data == null) {
      if (response.statusCode == 200) {
        _technologiesAPISuccess(response.data);
      } else {
        _domainAPIError(response.data);
      }
    }
  }

  /// Get leadership types
  Future<void> _getLeaderships() async {
    final response = await _provider.getLeadership();
    if (response.data == null) {
      if (response.statusCode == 200) {
        _leadershipTypeAPISuccess(response.data);
      } else {
        _domainAPIError(response.data);
      }
    }
  }

  /// Domain success
  ///
  /// required [response] response.
  void _domainAPISuccess(dio.Response response) async {
    final domainResponse = DomainResponse.fromJson(response.data);
    for (DomainResponseData element in (domainResponse.data ?? [])) {
      final model =
          Domain(domainId: element.id, domainName: element.domainName);
      final dbResponse = await _dbHelper.addToDomain(model);
      Get.log('dbResponse $dbResponse');
    }
  }

  /// Technologies success
  ///
  /// required [response] response.
  void _technologiesAPISuccess(dio.Response response) {
    final technologyResponse = TechnologyResponse.fromJson(response.data);
    for (TechnologyResponseData element in (technologyResponse.data ?? [])) {
      final model = Technologies(
          technologyId: element.id, technologyName: element.techName);
      _dbHelper.addToTechnologies(model);
    }
  }

  /// Leadership Types success
  ///
  /// required [response] response.
  void _leadershipTypeAPISuccess(dio.Response response) {
    final leadershipResponse = LeadershipTypeResponse.fromJson(response.data);
    for (LeadershipTypeData element in (leadershipResponse.data ?? [])) {
      final model = LeadershipType(
          leadershipTypeId: element.id, leadershipTypeName: element.leaderType);
      _dbHelper.addToLeadershipTypes(model);
    }
  }

  /// Domain error
  ///
  /// required [response] response.
  void _domainAPIError(dio.Response response) {}

  /// Synchronize enquiry with server.
  void _synchronizeEnquiryWithServer() async {
    final storedEnquiries = await _dbHelper.getTotalInquiryCount();
    if (storedEnquiries > 0) {
      for (int i = 0; i < storedEnquiries - 1; i++) {
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
      final deleteResponse = _dbHelper.delete(
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
    Get.back();
  }
}
