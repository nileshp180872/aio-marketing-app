import 'dart:io';

import 'package:aio/infrastructure/network/network_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_assets.dart';

class ProjectImageWidget extends StatelessWidget {
  String imageURL;
  BoxFit fit;

  ProjectImageWidget({required this.imageURL, this.fit = BoxFit.cover,  super.key});

  @override
  Widget build(BuildContext context) {
    final file = File(imageURL);
    if(imageURL.isEmpty){
      return _buildNoImage();
    }else if (file.existsSync()) {
      return _buildFileImage();
    } else {
      return _buildNetworkImage();
    }
  }

  Widget _buildNoImage() =>Image.asset(AppAssets.kNoImage);
  Widget _buildNetworkImage() {
    return CachedNetworkImage(imageUrl:"${NetworkConstants.kImageBasePath}$imageURL",
      errorWidget: (_,__,___)=>_buildNoImage(),
      /*progressIndicatorBuilder: (context, url, downloadProgress) =>
          SizedBox(
              height: 50,
              width: 50,
              child: Center(child: CircularProgressIndicator(value: downloadProgress.progress))),*/
      fit: BoxFit.cover,);
  }

  Widget _buildFileImage() {
    return Image.file(
      File(imageURL),
      fit: BoxFit.cover,
    );
  }
}
