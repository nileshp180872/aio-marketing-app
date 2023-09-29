import 'package:aio/config/app_assets.dart';
import 'package:aio/config/app_strings.dart';

import '../presentation/enquiry/model/country_model.dart';

class AppConstants {
  static const sourceSansPro = 'SoursSansPro';
  static const inter = 'Inter';
  static const poppins = 'Poppins';

  static const multiLineMaxLength = 500;
  static const textFieldMaxLength = 100;

  static const portfolio = 1;
  static const caseStudy = 2;

  /// Page limit for portfolios and case studies APIs.
  static const projectListPaginationLimit = 50;

  /// Page limit for portfolios and case studies
  static const paginationPageLimit = 10;

  static var countryData = CountryModel(
      id: '1',
      countryName: 'AHMEDABAD, INDIA',
      countryAddress: AppStrings.indiaOfficeAddress,
      countryFlag: SVGAssets.indianFlag);

  static var otherCountryData = [
    CountryModel(
        id: '2',
        countryName: 'UK',
        countryAddress: AppStrings.ukOfficeAddress,
        countryFlag: SVGAssets.ukFlag),
    CountryModel(
        id: '3',
        countryName: 'GERMANY',
        countryAddress: AppStrings.germanyOfficeAddress,
        countryFlag: SVGAssets.germanyFlag),
    CountryModel(
        id: '4',
        countryName: 'AUSTRALIA',
        countryAddress: AppStrings.australiaOfficeAddress,
        countryFlag: SVGAssets.australianFlag),
    CountryModel(
        id: '5',
        countryName: 'USA',
        countryAddress: AppStrings.usaOfficeAddress,
        countryFlag: SVGAssets.usaFlag),
  ];


}
