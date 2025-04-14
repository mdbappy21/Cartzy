import 'package:cartzy/data/models/profile_model.dart';

class ReadProfileData {
  String? msg;
  ProfileModel? data;

  ReadProfileData({this.msg, this.data});

  ReadProfileData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new ProfileModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}


