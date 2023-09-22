abstract class DbConstants {
  /// Master tables
  //------------- Domains ---------
  static const tblDomain = 'domain';

  static const domainId = 'domain_id';
  static const domainName = 'domain_name';

  //------------- Leadership Types ---------
  static const tblLeadership = 'leadership_types';

  static const leadershipId = 'leadership_types_id';
  static const leadershipName = 'leader_type';

  //------------- Technologies ---------
  static const tblTechnologies = 'technologies';

  static const technologicalId = 'technologies_id';
  static const technologicalName = 'technologies_name';

  //------------- Enquiry Data ---------
  static const tblEnquiry = 'enquiry';

  static const enquiryId = 'enquiry_id';
  static const enquiryMemberName = 'enquiry_member_name';
  static const enquiryMemberEmail = 'enquiry_member_email';
  static const enquiryMemberPhone = 'enquiry_member_phone';
  static const enquiryMemberCompanyName = 'enquiry_member_company_name';
  static const enquiryMemberMessage = 'enquiry_member_message';
  static const enquirySyncStatus = 'enquiry_sync_status';
}
