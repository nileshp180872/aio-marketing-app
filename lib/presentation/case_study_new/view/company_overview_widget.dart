import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/case_study_new/view/section_header_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/app_assets.dart';

class CompanyOverviewWidget extends StatelessWidget {

  CompanyOverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 5, child: Image.asset(AppAssets.caseStudyCompanyOverview)),
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
                const Text(
                  "Changing from Manual to Digital Solutions for Customer Identification and Verification.",
                  style: TextStyle(
                      fontSize: 32,
                      color: Color(0xff263238),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Updating industries with Digitization and advanced technologies",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff00517C),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "Our client is a global energy company headquartered in Singapore since 1997. They specialize in producing, distributing, and marketing petroleum products across 5 continents and 40+ countries. Their primary focus is on retail fuel and supplying energy products to industries such as mining, aviation, marine, and construction. With 3,000+ service stations worldwide, the company has invested in renewable energy and implemented sustainability initiatives to reduce its environmental impact. With a workforce of approximately 8,000 employees, customer satisfaction is their top priority.",
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
