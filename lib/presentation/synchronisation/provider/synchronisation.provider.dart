import 'package:aio/infrastructure/db/schema/enquiry.dart';
import 'package:aio/infrastructure/network/network_constants.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../infrastructure/network/config/dio_provider.dart';

class SynchronisationProvider {
  /// Returns list of domains.
  Future<Response> getDomains() async {
    return GetIt.I<DioProvider>().getBaseAPI(url: NetworkAPIs.kDomains);
  }

  /// Returns list of technologies.
  Future<Response> getTechnologies() async {
    return GetIt.I<DioProvider>().getBaseAPI(url: NetworkAPIs.kTechnologies);
  }

  /// Returns list of leadership.
  Future<Response> getLeadership() async {
    return GetIt.I<DioProvider>().getBaseAPI(url: NetworkAPIs.kLeadership);
  }

  /// Returns add enquiry response.
  Future<Response> addInquiry(Enquiry enquiry) async {
    Map<String, dynamic> body = {
      NetworkParams.companyName: enquiry.enquiryMemberCompany,
      NetworkParams.email: enquiry.enquiryMemberEmail,
      NetworkParams.phoneNumber: enquiry.enquiryMemberPhone,
      NetworkParams.userName: enquiry.enquiryMemberName,
      NetworkParams.message: enquiry.enquiryMemberMessage,
    };
    return GetIt.I<DioProvider>()
        .postBaseAPI(url: NetworkAPIs.kEnquiry, data: body);
  }
}
