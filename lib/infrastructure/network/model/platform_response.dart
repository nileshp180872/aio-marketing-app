class PlatformResponse{
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

  PlatformData({this.id, this.screenType});

  PlatformData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    screenType = json['screen_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['screen_type'] = screenType;
    return data;
  }
}