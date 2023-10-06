import 'package:aio/config/app_strings.dart';
import 'package:aio/infrastructure/db/schema/technologies.dart';
import 'package:aio/infrastructure/navigation/route_arguments.dart';
import 'package:aio/presentation/filter/provider/filter.provider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/domain.dart';
import '../../../infrastructure/db/schema/platform.dart';
import '../../../infrastructure/network/model/domain_response.dart';
import '../../../infrastructure/network/model/platform_response.dart';
import '../../../infrastructure/network/model/technology_response.dart';
import '../../../utils/utils.dart';
import '../../portfolio/controllers/portfolio.controller.dart';
import '../model/filter_menu.dart';
import '../model/selection_model.dart';

class FilterController extends GetxController {
  RxInt selectedIndex = 0.obs;

  // Database helper
  late DatabaseHelper _dbHelper;

  // Main category list
  List<String> lstSectionCategory = [
    AppStrings.domainIndustry,
    AppStrings.mobileWeb,
    AppStrings.technologyStack
  ];

  /// Provider
  final _provider = FilterProvider();

  /// logger
  final logger = Logger();

  /// Screen viewing type enum
  PortfolioEnum portfolioEnum = PortfolioEnum.PORTFOLIO;

  // domain list
  RxList<SelectionModel> lstDomains = RxList();

  // mobile/web list
  RxList<SelectionModel> lstMobileWeb = RxList();

  // technologies list
  RxList<SelectionModel> lstTechnologies = RxList();

  @override
  void onInit() {
    _dbHelper = GetIt.I<DatabaseHelper>();
    _getArguments();
    super.onInit();
  }

  /// Receive arguments from previous screen.
  void _getArguments() {
    if (Get.arguments != null) {
      portfolioEnum = Get.arguments[RouteArguments.portfolioEnum] ??
          PortfolioEnum.PORTFOLIO;

      // remove mobile web filter
      if (portfolioEnum == PortfolioEnum.CASE_STUDY) {
        lstSectionCategory
            .removeWhere((element) => element == AppStrings.mobileWeb);
      } else {
        _prepareMobileWeb();
      }

      _prepareDomains();
      _prepareTechnologies();

      final isFilterApplied =
          Get.arguments[RouteArguments.filterApplied] ?? false;

      Get.log(
          "check ${((Get.arguments[RouteArguments.filterData]) as FilterMenu).platform.length}");

      if (isFilterApplied) {
        Future.delayed(const Duration(milliseconds: 50), () {
          FilterMenu selectedItems =
              Get.arguments[RouteArguments.filterData] ?? FilterMenu();

          if (selectedItems.domains.isNotEmpty) {
            for (String selectedDomainElement in selectedItems.domains) {
              final domainIndex = lstDomains.indexWhere((element) =>
                  (element.id ?? "") ==
                  selectedDomainElement.replaceAll("'", ''));
              if (domainIndex != -1) {
                lstDomains[domainIndex].selected = true;
              }
            }
          }

          if (selectedItems.technologies.isNotEmpty) {
            for (String selectedElement in selectedItems.technologies) {
              final domainIndex = lstTechnologies.indexWhere((element) =>
                  (element.id ?? "") == selectedElement.replaceAll("'", ''));
              if (domainIndex != -1) {
                lstTechnologies[domainIndex].selected = true;
              }
            }
          }

          if (selectedItems.platform.isNotEmpty) {
            for (String selectedElement in selectedItems.platform) {
              final domainIndex = lstMobileWeb.indexWhere((element) =>
                  (element.id ?? "") == selectedElement.replaceAll("'", ''));
              if (domainIndex != -1) {
                lstMobileWeb[domainIndex].selected = true;
              }
            }
          }
          lstMobileWeb.refresh();
          lstDomains.refresh();
          lstTechnologies.refresh();
        });
      }
    }
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  /// Select technologies
  void selectTechnology(int index) {
    final isSelected = lstTechnologies[index].selected;
    lstTechnologies[index].selected = !isSelected;
    lstTechnologies.refresh();
  }

  /// Select mobile web
  void selectMobileWeb(int index) {
    final isSelected = lstMobileWeb[index].selected;
    lstMobileWeb[index].selected = !isSelected;
    lstMobileWeb.refresh();
  }

  /// Select domains
  void selectDomain(int index) {
    final isSelected = lstDomains[index].selected;
    lstDomains[index].selected = !isSelected;
    lstDomains.refresh();
  }

  /// on apply button click
  void submit() {
    final filterMenuItem = FilterMenu();

    filterMenuItem.domains = (lstDomains.where((p0) => p0.selected).toList())
        .map((element) => "'${element.id ?? ""}'")
        .toList();

    filterMenuItem.platform = (lstMobileWeb.where((p0) => p0.selected).toList())
        .map((element) => "'${element.id ?? ""}'")
        .toList();

    filterMenuItem.technologies =
        (lstTechnologies.where((p0) => p0.selected).toList())
            .map((element) => "'${element.id ?? ""}'")
            .toList();

    Get.log("filter ${filterMenuItem.platform.length}");
    Get.back(result: filterMenuItem);
  }

  /// on cancel button click
  void onClearFilter() {
    for (var element in lstDomains) {
      element.selected = false;
    }

    for (var element in lstTechnologies) {
      element.selected = false;
    }

    for (var element in lstMobileWeb) {
      element.selected = false;
    }

    lstDomains.refresh();
  }

  /// Prepare domains
  void _prepareDomains() async {
    try {
      final domains = await _dbHelper.getAllDomains();
      for (Domain element in domains) {
        lstDomains.add(
            SelectionModel(title: element.domainName, id: element.domainId));
      }
    } catch (ex) {
      logger.e(ex);
    }
  }

  /// Prepare technologies
  void _prepareTechnologies() async {
    try {
      final technologies = await _dbHelper.getAllTechnologies();
      for (Technologies element in technologies) {
        lstTechnologies.add(SelectionModel(
            title: element.technologyName, id: element.technologyId));
      }
    } catch (ex) {
      logger.e(ex);
    }
  }

  /// Prepare technologies
  void _prepareMobileWeb() async {
    try {
      final platforms = await _dbHelper.getAllPlatform();
      for (Platform element in platforms) {
        lstMobileWeb.add(SelectionModel(
            title: element.platformName, id: element.platformId));
      }
    } catch (ex) {
      logger.e(ex);
    }
  }

  /// Get domains
  Future<void> _getDomains() async {
    final response = await _provider.getDomains();
    if (response.data != null) {
      if (response.statusCode == 200) {
        _domainAPISuccess(response);
      } else {
        _getAPIError(response);
      }
    } else {
      _getAPIError(response);
    }
  }

  /// Get technologies
  Future<void> _getTechnologies() async {
    final response = await _provider.getTechnologies();
    if (response.data != null) {
      if (response.statusCode == 200) {
        _technologiesAPISuccess(response);
      } else {
        _getAPIError(response);
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
        _getAPIError(response);
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
          lstDomains.add(SelectionModel(
              title: element.domainName ?? "", id: element.id ?? ""));
        } catch (ex) {
          logger.e(ex);
        }
      }
    }
  }

  /// Domain error
  ///
  /// required [response] response.
  void _getAPIError(dio.Response response) {
    Utils.showErrorMessage(message: response.statusMessage ?? "");
  }

  /// Technologies success
  ///
  /// required [response] response.
  void _technologiesAPISuccess(dio.Response response) async {
    final technologyResponse = TechnologyResponse.fromJson(response.data);
    if ((technologyResponse.data ?? []).isNotEmpty) {
      for (TechnologyResponseData element in (technologyResponse.data ?? [])) {
        lstTechnologies
            .add(SelectionModel(title: element.techName, id: element.id));
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
        lstMobileWeb
            .add(SelectionModel(title: element.screenType, id: element.id));
      }
    }
  }
}
