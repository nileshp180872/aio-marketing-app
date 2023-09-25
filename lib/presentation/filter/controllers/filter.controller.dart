import 'package:aio/infrastructure/db/schema/technologies.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/domain.dart';
import '../model/selection_model.dart';

class FilterController extends GetxController {
  RxInt selectedIndex = 0.obs;

  // Database helper
  late DatabaseHelper _dbHelper;

  List<String> list1 = ["Domain", "Technology Stack", "Mobile/Web"];
  RxList<SelectionModel> lstDomains = RxList();
  RxList<SelectionModel> lstMobileWeb = RxList([
    SelectionModel(title: "Mobile/Web1"),
    SelectionModel(title: "Mobile/Web2"),
    SelectionModel(title: "Mobile/Web3"),
    SelectionModel(title: "Mobile/Web4"),
    SelectionModel(title: "Mobile/Web5"),
    SelectionModel(title: "Mobile/Web6"),
    SelectionModel(title: "Mobile/Web7")
  ]);
  RxList<SelectionModel> lstTechnologies = RxList([
    SelectionModel(title: "Technology Stack1"),
    SelectionModel(title: "Technology Stack2"),
    SelectionModel(title: "Technology Stack3"),
    SelectionModel(title: "Technology Stack4"),
    SelectionModel(title: "Technology Stack5"),
    SelectionModel(title: "Technology Stack6"),
    SelectionModel(title: "Technology Stack7"),
    SelectionModel(title: "Technology Stack1"),
    SelectionModel(title: "Technology Stack2"),
    SelectionModel(title: "Technology Stack3"),
    SelectionModel(title: "Technology Stack4"),
    SelectionModel(title: "Technology Stack5"),
    SelectionModel(title: "Technology Stack6"),
    SelectionModel(title: "Technology Stack7"),
    SelectionModel(title: "Technology Stack1"),
    SelectionModel(title: "Technology Stack2"),
    SelectionModel(title: "Technology Stack3"),
    SelectionModel(title: "Technology Stack4"),
    SelectionModel(title: "Technology Stack5"),
    SelectionModel(title: "Technology Stack6"),
    SelectionModel(title: "Technology Stack7"),
    SelectionModel(title: "Technology Stack1"),
    SelectionModel(title: "Technology Stack2"),
    SelectionModel(title: "Technology Stack3"),
    SelectionModel(title: "Technology Stack4"),
    SelectionModel(title: "Technology Stack5"),
    SelectionModel(title: "Technology Stack6"),
    SelectionModel(title: "Technology Stack7"),
    SelectionModel(title: "Technology Stack1"),
    SelectionModel(title: "Technology Stack2"),
    SelectionModel(title: "Technology Stack3"),
    SelectionModel(title: "Technology Stack4"),
    SelectionModel(title: "Technology Stack5"),
    SelectionModel(title: "Technology Stack6"),
    SelectionModel(title: "Technology Stack7"),
  ]);

  @override
  void onInit() {
    _dbHelper = GetIt.I<DatabaseHelper>();

    _prepareDomains();
    _prepareTechnologies();
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
    Get.log("domainName ${domains.length}");
    for (Domain element in domains) {
      Get.log("domainName ${element.domainName}");
      lstDomains.add(SelectionModel(title: element.domainName));
    }
  }

  /// Prepare technologies
  void _prepareTechnologies() async {
    final technologies = await _dbHelper.getAllTechnologies();
    Get.log("technologyName ${technologies.length}");
    for (Technologies element in technologies) {
      Get.log("technologyName ${element.technologyName}");
      lstTechnologies.add(SelectionModel(title: element.technologyName));
    }
  }
}
