import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/case_study_new/view/section_header_widget.dart';
import 'package:aio/presentation/case_study_new/view/slider_widget.dart';
import 'package:aio/presentation/case_study_new/view/technology_single_logo.dart';
import 'package:flutter/material.dart';

class ConclutionSection extends StatelessWidget {
  ConclutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    late TextTheme _textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderWidget(
            title: AppStrings.conclusion,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Our esteemed client faced several challenges in the fast-paced and constantly evolving world of information technology, like staying up-to-date with emerging technologies & meeting changing customer expectations, regarding security and data etc. They hired Tridhya Tech, A leading software company that provides a platform for building and deploying enterprise-level websites, portals, and intranets. We addressed these challenges through the digitalization of the customer KYC process. To implement this solution, technologies such as DXP 7.3, PostgreSQL, and Azure VMs have been used. By embracing innovation, our esteemed client can continue to thrive in the constantly evolving world of information technology." ??
                "",
            style: _textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color(0xff263238)),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
