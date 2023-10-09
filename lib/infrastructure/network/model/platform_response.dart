class PlatformResponse {
  List<PlatformData>? data;

  PlatformResponse({this.data});

  PlatformResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PlatformData>[];
      json['data'].forEach((v) {
        data!.add(PlatformData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlatformData {
  String? id;
  String? screenType;
  String? modifiedOn;
  String? deletedOn;
  bool? isEnable;
  bool? isDeleted;

  PlatformData(
      {this.id,
      this.screenType,
      this.modifiedOn,
      this.deletedOn,
      this.isEnable,
      this.isDeleted});

  PlatformData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    screenType = json['screen_type'];
    modifiedOn = json['modified_on'];
    deletedOn = json['deleted_on'];
    isEnable = json['is_enable'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['screen_type'] = screenType;
    data['modified_on'] = modifiedOn;
    data['deleted_on'] = deletedOn;
    data['is_enable'] = isEnable;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
