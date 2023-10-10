import 'package:aio/presentation/case_study_new/view/slider_widget.dart';
import 'package:flutter/material.dart';

class BottomSection extends StatelessWidget {
  List<String> sliderImage;

  BottomSection({required this.sliderImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SliderWidget(
            imageSlider: sliderImage,
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
