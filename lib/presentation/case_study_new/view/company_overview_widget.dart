import 'package:aio/config/app_strings.dart';
import 'package:aio/infrastructure/network/network_constants.dart';
import 'package:aio/presentation/case_study_new/view/section_header_widget.dart';
import 'package:flutter/material.dart';

import '../../project_detail/view/project_image_widget.dart';

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
    final _textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 5,
              child: ProjectImageWidget(
                  imageURL:
                      companyImage)),
          const SizedBox(width: 20,),
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
                  style: _textTheme.bodyMedium?.copyWith(
                      fontSize: 28,
                      color: Color(0xff263238),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  companyDescription,
                  style: _textTheme.bodyMedium?.copyWith(
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
