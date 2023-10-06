abstract class NetworkConstants {
  static const kProduction = "http://137.184.19.129:4041/$kApiVersion";

  static const kDevelopment = "http://172.16.0.33:4041/$kApiVersion";

  static const kApiVersion = "api/v1/";

  static const kImageBasePath = "http://137.184.19.129:4041/";
}

abstract class NetworkAPIs {
  // Domains
  static const kDomains = "lookup/domain";

  // Technologies
  static const kTechnologies = "lookup/tech";

  // Leadership
  static const kLeadershipRole = "lookup/leader";

  // leaders
  static const kLeaders = "leader/list";

  // Platform
  static const kPlatform = "lookup/screen";

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
  static const startDate = "startDate";
  static const endDate = "endDate";
  static const limit = "limit";
  static const page = "page";
  static const domainId = "domain_id";
  static const screenId = "screen_id";
  static const techId = "tech_id";
  static const searchKey = "searchKey";
}
