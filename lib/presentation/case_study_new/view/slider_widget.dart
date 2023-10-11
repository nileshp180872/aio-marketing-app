import 'package:aio/config/app_colors.dart';
import 'package:aio/infrastructure/network/network_constants.dart';
import 'package:flutter/material.dart';

import '../../project_detail/view/project_image_widget.dart';

class SliderWidget extends StatefulWidget {
  List<String> imageSlider;
  final PageController _pageController = PageController(initialPage: 0);
  int selectedindex = 0;

  SliderWidget({required this.imageSlider, super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 300,
          width: 400,
          child: PageView.builder(
            controller: widget._pageController,
            onPageChanged: (int page) {
              setState(() {
                widget.selectedindex = page;
              });
            },
            itemBuilder: (_, index) {
              return ProjectImageWidget(
                imageURL: "${widget.imageSlider[index]}",
                fit: BoxFit.fill,
              );
            },
            itemCount: widget.imageSlider.length,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 400,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
        )
      ],
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.imageSlider.length; i++) {
      list.add(
          i == widget.selectedindex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColors.colorSecondary : const Color(0XFFEAEAEA),
        ),
      ),
    );
  }
}
