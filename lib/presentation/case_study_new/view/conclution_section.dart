import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/case_study_new/view/section_header_widget.dart';
import 'package:flutter/material.dart';

class ConclutionSection extends StatelessWidget {
  String conclusion;
  ConclutionSection({required this.conclusion,super.key});

  @override
  Widget build(BuildContext context) {
    late TextTheme _textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80)
          .copyWith(right: 60),
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
            "${conclusion ?? ""}",
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
