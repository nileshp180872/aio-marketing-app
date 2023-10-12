import 'package:flutter/material.dart';

import '../../project_detail/view/project_image_widget.dart';
import '../model/business_challenge.dart';

class BusinessChallengeSingleTileWidget extends StatelessWidget {
  BusinessChallenge model;
  late TextTheme _textTheme;

  BusinessChallengeSingleTileWidget({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;

    return (model.title ?? "").isNotEmpty
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ProjectImageWidget(
                        radiusRequired: true,
                        fit: BoxFit.fitHeight,
                        imageURL: model.icon ?? ""),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title ?? "",
                    style: _textTheme.bodyLarge?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff263238)),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    model.description ?? "",
                    style: _textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff263238)),
                  ),
                ],
              ))
            ],
          )
        : Container();
  }
}
