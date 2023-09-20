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
}
