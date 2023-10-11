import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../infrastructure/network/config/dio_provider.dart';
import '../../../infrastructure/network/network_constants.dart';

class CaseStudyNewProvider {

  /// Returns case study image.
  Future<Response> getCaseStudyById({required String caseStudyId}) async {
    return await GetIt.I<DioProvider>()
        .getBaseAPI(url: "${NetworkAPIs.kCaseStudyById}/$caseStudyId");
  }

  /// Returns send invitation
  Future<Response> sendLinkInvitation(String email, String id) async {
    return await GetIt.I<DioProvider>().postBaseAPI(
        url: NetworkAPIs.kCaseStudyShare, data: {"email": email, "casestudiesID": id});
  }
}
