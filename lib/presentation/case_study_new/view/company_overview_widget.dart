import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/case_study_new/view/section_header_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/app_assets.dart';

class CompanyOverviewWidget extends StatelessWidget {
  const CompanyOverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Row(
        children: [
          Expanded(flex: 4, child: Image.asset(AppAssets.caseStudyCompanyOverview)),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeaderWidget(
                  title: AppStrings.companyOverview,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                    "Changing from Manual to Digital Solutions for Customer Identification and Verification."),
                SizedBox(
                  height: 4,
                ),
                Text(
                    "Our client is a global energy company headquartered in Singapore since 1997. They specialize in producing, distributing, and marketing petroleum products across 5 continents and 40+ countries. Their primary focus is on retail fuel and supplying energy products to industries such as mining, aviation, marine, and construction. With 3,000+ service stations worldwide, the company has invested in renewable energy and implemented sustainability initiatives to reduce its environmental impact. With a workforce of approximately 8,000 employees, customer satisfaction is their top priority."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
