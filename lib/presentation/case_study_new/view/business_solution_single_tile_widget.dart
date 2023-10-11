import 'package:flutter/material.dart';

import '../../project_detail/view/project_image_widget.dart';
import '../model/business_challenge.dart';

class BusinessSolutionSingleTileWidget extends StatelessWidget {
  BusinessChallenge model;

  BusinessSolutionSingleTileWidget({required this.model, super.key});

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return (model.title ?? "").isNotEmpty
        ? SizedBox(
            width: MediaQuery.of(context).size.width / 3 - 60,
            // width:300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      height: 50,
                      width: 50,
                      child: ProjectImageWidget(imageURL: "${model.icon}"),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title ?? "",
                          // textAlign: TextAlign.justify,
                          style: _textTheme.bodyLarge?.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff263238)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          model.description ?? "",
                          maxLines: 13,
                          overflow: TextOverflow.ellipsis,
                          style: _textTheme.bodyLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff263238)),
                        )
                      ],
                    )),
                  ],
                ),
              ],
            ),
          )
        : Container();
  }
}
