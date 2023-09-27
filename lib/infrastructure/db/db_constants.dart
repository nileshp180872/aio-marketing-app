abstract class DbConstants {
  /// Master tables
  //------------- Domains ---------
  static const tblDomain = 'domain';

  static const domainId = 'domain_id';
  static const domainName = 'domain_name';

  //------------- Platform ---------
  static const tblPlatform = 'platform';

  static const platformId = 'platform_id';
  static const platformName = 'platform_name';

  //------------- Leadership Types ---------
  static const tblLeadership = 'leadership_types';

  static const leadershipId = 'leadership_types_id';
  static const leadershipName = 'leader_type';

  //------------- Technologies ---------
  static const tblTechnologies = 'technologies';

  static const technologicalId = 'technologies_id';
  static const technologicalName = 'technologies_name';

  //------------- Leaders ---------
  static const tblLeaders = 'leaders';

  static const leaderId = 'leader_id';
  static const leaderName = 'leader_name';
  static const leaderDesignation = 'leader_designation';
  static const leaderDescription = 'leader_description';
  static const leaderImage = 'leader_image';

  //------------- Enquiry Data ---------
  static const tblEnquiry = 'enquiry';

  static const enquiryId = 'enquiry_id';
  static const enquiryMemberName = 'enquiry_member_name';
  static const enquiryMemberEmail = 'enquiry_member_email';
  static const enquiryMemberPhone = 'enquiry_member_phone';
  static const enquiryMemberCompanyName = 'enquiry_member_company_name';
  static const enquiryMemberMessage = 'enquiry_member_message';
  static const enquirySyncStatus = 'enquiry_sync_status';

  //------------- Portfolio ---------
  static const tblPortfolio = 'portfolio';

  static const portfolioId = 'portfolio_id';
  static const portfolioDomainId = 'portfolio_domain_id';
  static const portfolioDomainName = 'portfolio_domain_name';
  static const portfolioScreenType = 'portfolio_screen_type';
  static const portfolioScreenName = 'portfolio_screen_name';
  static const portfolioProjectName = 'portfolio_project_name';
  static const portfolioProjectDescription = 'portfolio_project_description';
  static const projectImages = 'project_images';

  //------------- Portfolio technologies ---------
  static const tblPortfolioTechnologies = 'portfolio_technology';

  static const portfolioTechnologyId = 'portfolio_technology_id';
  static const portfolioTechnologyName = 'portfolio_technology_name';
  static const portfolioTableId = 'portfolio_technology_portfolio_id';

  //------------- Portfolio images ---------
  static const tblPortfolioImages = 'portfolio_images';

  static const portfolioImageId = 'portfolio_images_id';
  static const portfolioImagePath = 'portfolio_images_path';
  static const portfolioImagePortfolioId = 'portfolio_images_portfolio_id';

  //------------- Case studies ---------
  static const tblCaseStudies = 'case_study';

  static const caseStudyId = 'case_study_id';
  static const caseStudyDomainId = 'case_study_domain_id';
  static const caseStudyDomainName = 'case_study_domain_name';
  static const caseStudyProjectName = 'case_study_project_name';
  static const caseStudyDescription = 'case_study_description';
  static const caseStudyImages = 'case_study_images';

  //------------- Case Study technologies ---------
  static const tblCaseStudiesTechnologies = 'case_study_technology';

  static const caseStudyTechnologyId = 'case_study_technology_id';
  static const caseStudyTechnologyName = 'case_study_technology_name';
  static const caseStudyTableId = 'case_study_id';

  //------------- Portfolio images ---------
  static const tblCaseStudyImages = 'case_study_images';

  static const caseStudyImageId = 'case_study_images_id';
  static const caseStudyImagePath = 'case_study_images_path';
  static const caseStudyImageCaseStudyId = 'case_study_images_case_study_id';
}
