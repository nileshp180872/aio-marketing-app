import 'package:aio/infrastructure/db/db_constants.dart';

class Domain {
  String? domainId;
  String? domainName;

    Domain({this.domainId, this.domainName});

  Domain.fromJson(Map<String, dynamic> json) {
    domainId = json[DbConstants.domainId];
    domainName = json[DbConstants.domainName];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.domainId] = domainId;
    data[DbConstants.domainName] = domainName;
    return data;
  }
}
