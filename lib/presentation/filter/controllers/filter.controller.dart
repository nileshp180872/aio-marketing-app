import 'package:aio/config/app_strings.dart';
import 'package:aio/infrastructure/db/schema/technologies.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/domain.dart';
import '../../../infrastructure/db/schema/platform.dart';
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

  // domain list
  RxList<SelectionModel> lstDomains = RxList();

  // mobile/web list
  RxList<SelectionModel> lstMobileWeb = RxList();

  // technologies list
  RxList<SelectionModel> lstTechnologies = RxList();

  @override
  void onInit() {
    _dbHelper = GetIt.I<DatabaseHelper>();

    _prepareDomains();
    _prepareTechnologies();
    _prepareMobileWeb();
    super.onInit();
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
    Get.back();
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
    final domains = await _dbHelper.getAllDomains();
    for (Domain element in domains) {
      lstDomains.add(SelectionModel(title: element.domainName));
    }
  }

  /// Prepare technologies
  void _prepareTechnologies() async {
    final technologies = await _dbHelper.getAllTechnologies();
    for (Technologies element in technologies) {
      lstTechnologies.add(SelectionModel(title: element.technologyName));
    }
  }

  /// Prepare technologies
  void _prepareMobileWeb() async {
    final platforms = await _dbHelper.getAllPlatform();
    for (Platform element in platforms) {
      lstMobileWeb.add(SelectionModel(title: element.platformName));
    }
  }
}
