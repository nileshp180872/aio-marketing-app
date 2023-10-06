import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../infrastructure/db/schema/enquiry.dart';
import '../../../infrastructure/network/config/dio_provider.dart';
import '../../../infrastructure/network/network_constants.dart';

class EnquiryProvider{
  /// Returns add enquiry response.
  Future<Response> addInquiry(Enquiry enquiry) async {
    Map<String, dynamic> body = {
      NetworkParams.companyName: enquiry.enquiryMemberCompany,
      NetworkParams.email: enquiry.enquiryMemberEmail,
      NetworkParams.phoneNumber: enquiry.enquiryMemberPhone,
      NetworkParams.userName: enquiry.enquiryMemberName,
      NetworkParams.message: enquiry.enquiryMemberMessage,
    };
    return await GetIt.I<DioProvider>()
        .postBaseAPI(url: NetworkAPIs.kEnquiry, data: body);
  }
}