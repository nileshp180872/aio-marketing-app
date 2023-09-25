abstract class NetworkConstants {
  static const kProduction = "";

  static const kDevelopment = "http://172.16.0.33:4000/$kApiVersion";
  static const kApiVersion = "api/v1/";
}

abstract class NetworkAPIs {
  // Domains
  static const kDomains = "list/domain";

  // Technologies
  static const kTechnologies = "list/tech";

  // Leadership
  static const kLeadership = "list/leader";

  // Enquiry
  static const kEnquiry = "enquiry/new";
}

abstract class NetworkParams {
  static const companyName = "comapny_name";
  static const email = "email";
  static const message = "message";
  static const phoneNumber = "phone_no";
  static const userName = "users_name";
}
