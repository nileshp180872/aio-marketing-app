import 'package:aio/config/app_strings.dart';
import 'package:aio/infrastructure/network/network_constants.dart';
import 'package:aio/presentation/case_study_new/view/section_header_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/app_assets.dart';

class CompanyOverviewWidget extends StatelessWidget {
  String companyTitle;
  String companyDescription;
  String companyImage;

  CompanyOverviewWidget(
      {this.companyTitle = "",
      this.companyDescription = "",
      this.companyImage = "",
      super.key});

  @override
  Widget build(BuildContext context) {
    print("image ${"${NetworkConstants.kImageBasePath}${companyImage}"}");
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 5, child: Image.network("${NetworkConstants.kImageBasePath}${companyImage}")),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                SectionHeaderWidget(
                  title: AppStrings.companyOverview,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  companyTitle,
                  style: TextStyle(
                      fontSize: 32,
                      color: Color(0xff263238),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Text(
                //   "Updating industries with Digitization and advanced technologies",
                //   style: TextStyle(
                //       fontSize: 18,
                //       color: Color(0xff00517C),
                //       fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(
                //   height: 4,
                // ),4
            Text(
              companyDescription,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff00517C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
