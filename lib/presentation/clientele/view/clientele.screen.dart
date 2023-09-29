import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_constants.dart';
import '../../../config/app_strings.dart';
import '../../../config/app_values.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../utils/user_feature.mixin.dart';
import '../../project_list/view/pagination_project_grid_widget.dart';
import '../controllers/clientele.controller.dart';

class ClienteleScreen extends GetView<ClientteleCotroller> with AppFeature {
  ClienteleScreen({Key? key}) : super(key: key);

  final ClientteleCotroller _controller = Get.find(tag: Routes.CLIENTELE);

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCustomAppBar(
                  title: _controller.screenTitle.value, enableSearch: false),
              const SizedBox(
                height: AppValues.size_30,
              ),
              Center(
                child: Text(
                  AppStrings.clientelecontent1,
                  style: _textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 32,
                      height: 1.5,
                      fontFamily: AppConstants.poppins,
                      color: AppColors.colorSecondary),
                ),
              ),
              const SizedBox(
                height: AppValues.size_30,
              ),
              Expanded(child: _buildScreenBody())
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenBody() {
    return Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppValues.sideMargin, vertical: 0),
        child: GridView.builder(
          itemCount: _controller.clientList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 2

          ),
          itemBuilder: (BuildContext context, int index) {
            return Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),

                child: Image.asset(
                    _controller.clientList.elementAt(index).logo.toString()));
          },
        ));
  }
// _buildScreenBody() {
//   return Column(
//     children: [
//       Center(
//         child: Text(
//           AppStrings.clientelecontent1,
//           style: _textTheme.bodyLarge?.copyWith(
//               fontWeight: FontWeight.w300,
//               fontSize: 32,
//               height: 1.5,
//               fontFamily: AppConstants.poppins,
//               color: AppColors.colorSecondary),
//         ),
//       ),
//       GridView(
//           physics: NeverScrollableScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3, crossAxisSpacing: 16),
//           children: [Image.asset(ClientAssets.client1)])
//     ],
//   );
// }
}
