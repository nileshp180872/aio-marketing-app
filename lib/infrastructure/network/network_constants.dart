abstract class NetworkConstants {
  static const kProduction = "";

  static const kDevelopment = "http://172.16.0.33:4000/$kApiVersion";
  static const kApiVersion = "api/v1/";

  static const kImageBasePath = "http://172.16.0.33:4000/";
}

abstract class NetworkAPIs {
  // Domains
  static const kDomains = "list/domain";

  // Technologies
  static const kTechnologies = "list/tech";

  // Leadership
  static const kLeadershipRole = "list/leader";

  // leaders
  static const kLeaders = "leader/list";

  // Platform
  static const kPlatform = "list/screen";

  // Enquiry
  static const kEnquiry = "enquiry/new";

  // Portfolio
  static const kPortfolio = "portfolio/list";

  // case studies
  static const kCaseStudies = "casestudies/list";
}

abstract class NetworkParams {
  static const companyName = "company_name";
  static const email = "email";
  static const message = "message";
  static const phoneNumber = "phone_no";
  static const userName = "users_name";
}
