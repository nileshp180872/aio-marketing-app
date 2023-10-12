import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/case_study_new/view/section_header_widget.dart';
import 'package:aio/presentation/case_study_new/view/slider_widget.dart';
import 'package:aio/presentation/case_study_new/view/technology_single_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSection extends StatelessWidget {
  List<String> sliderImage;
  List<String> techlogoImage;

  BottomSection(
      {required this.sliderImage, required this.techlogoImage, super.key});

  @override
  Widget build(BuildContext context) {
    return sliderImage.isNotEmpty || techlogoImage.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: SliderWidget(
                    imageSlider: sliderImage,
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SectionHeaderWidget(
                          title: AppStrings.appliedTechnology,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: _buildTechnologySolution()),
                      ],
                    )),
              ],
            ),
          )
        : Container();
  }

  Widget _buildTechnologySolution() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: techlogoImage.length,
      itemBuilder: (_, index) {
        return TechnologySignleTileWidget(image: techlogoImage[index]);
      },
      separatorBuilder: (_, __) {
        return const SizedBox(
          width: 20,
        );
      },
    );
  }
}
