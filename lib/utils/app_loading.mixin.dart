import 'package:get/get.dart';

mixin AppLoadingMixin {
  RxBool loading = false.obs;

  bool get isLoading => loading.isTrue;

  void showLoading() {
    loading.value = true;
  }

  void hideLoading() {
    loading.value = true;
  }
}
