class ClientData {
  String? name;
  String? logo;

  ClientData({this.name, this.logo});

  ClientData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}