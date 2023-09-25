import 'package:get/get.dart';

import '../model/selection_model.dart';

class FilterController extends GetxController {
  RxInt selectedIndex = 0.obs;

  List<String> list1 = ["Domain", "Technology Stack", "Mobile/Web"];
  RxList<SelectionModel> lstDomains = RxList([
    SelectionModel(title: "Domain1"),
    SelectionModel(title: "Domain2"),
    SelectionModel(title: "Domain3")
  ]);
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

  void submit() {}
}
