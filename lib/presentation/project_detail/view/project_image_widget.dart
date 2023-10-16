import 'dart:io';

import 'package:aio/infrastructure/network/network_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_assets.dart';

class ProjectImageWidget extends StatelessWidget {
  String imageURL;
  BoxFit fit;
  bool radiusRequired;

  ProjectImageWidget(
      {required this.imageURL,
      this.radiusRequired = false,
      this.fit = BoxFit.cover,
      super.key});

  @override
  Widget build(BuildContext context) {
    print("baseURL $imageURL");
    final file = File(imageURL);
    if (imageURL.isEmpty) {
      return _buildNoImage();
    } else if (file.existsSync()) {
      return _buildFileImage();
    } else {
      return _buildNetworkImage();
    }
  }

  Widget _buildNoImage() => Image.asset(
        AppAssets.kNoImage,
        fit: fit,
      );

  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: "${NetworkConstants.kImageBasePath}$imageURL",
      fit: fit,
    );
  }

  Widget _buildFileImage() {
    Get.log("imageURL $imageURL");
    return Image.file(
      File(imageURL),
      fit: fit,
    );
  }
}
