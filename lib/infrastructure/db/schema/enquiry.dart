import '../db_constants.dart';

class Enquiry {
  String? enquiryId;
  String? enquiryMemberName;
  String? enquiryMemberEmail;
  String? enquiryMemberPhone;
  String? enquiryMemberCompany;
  String? enquiryMemberMessage;
  int enquirySyncStatus = 0;

  Enquiry({
    this.enquiryId,
    this.enquiryMemberName,
    this.enquiryMemberEmail,
    this.enquiryMemberPhone,
    this.enquiryMemberCompany,
    this.enquiryMemberMessage,
    this.enquirySyncStatus = 0,
  });

  Enquiry.fromJson(Map<String, dynamic> json) {
    enquiryId = json[DbConstants.enquiryId];
    enquiryMemberName = json[DbConstants.enquiryMemberName];
    enquiryMemberEmail = json[DbConstants.enquiryMemberEmail];
    enquiryMemberPhone = json[DbConstants.enquiryMemberPhone];
    enquiryMemberCompany = json[DbConstants.enquiryMemberCompanyName];
    enquiryMemberMessage = json[DbConstants.enquiryMemberMessage];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.technologicalId] = enquiryId;
    data[DbConstants.technologicalName] = enquiryMemberName;
    data[DbConstants.enquiryMemberEmail] = enquiryMemberEmail;
    data[DbConstants.enquiryMemberPhone] = enquiryMemberPhone;
    data[DbConstants.enquiryMemberCompanyName] = enquiryMemberCompany;
    data[DbConstants.enquiryMemberMessage] = enquiryMemberMessage;
    return data;
  }
}
