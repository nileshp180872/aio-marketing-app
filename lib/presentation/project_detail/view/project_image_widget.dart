import 'dart:io';

import 'package:aio/infrastructure/network/network_constants.dart';
import 'package:flutter/material.dart';

import '../../../config/app_assets.dart';

class ProjectImageWidget extends StatelessWidget {
  String imageURL;
  BoxFit fit;

  ProjectImageWidget({required this.imageURL, this.fit = BoxFit.cover,  super.key});

  @override
  Widget build(BuildContext context) {
    if(imageURL.isEmpty){
      return Image.asset(AppAssets.kNoImage);
    }else if (imageURL.contains("com.tridhyatech.aio/app_flutter/")) {
      return _buildFileImage();
    } else {
      return _buildNetworkImage();
    }
  }

  Widget _buildNetworkImage() {
    return Image.network("${NetworkConstants.kImageBasePath}$imageURL",  fit: BoxFit.cover,);
  }

  Widget _buildFileImage() {
    return Image.file(
      File(imageURL),
      fit: BoxFit.cover,
    );
  }
}
