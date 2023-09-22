import 'package:get/get.dart';

import '../model/member_model.dart';

class BoardMemberSliderController extends GetxController {
  /// List of board members.
  RxList<MemberModel> lstMembers = RxList();

  @override
  void onInit() {
    _prepareMembers();
    super.onInit();
  }

  /// Prepare members.
  void _prepareMembers() {
    lstMembers.addAll([
      MemberModel(),
      MemberModel(),
      MemberModel(),
      MemberModel(),
      MemberModel(),
    ]);
  }
}
