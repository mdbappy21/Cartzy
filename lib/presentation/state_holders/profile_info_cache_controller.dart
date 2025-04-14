import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cartzy/data/models/profile_model.dart';

class ProfileInfoCacheController {
  static Future<void> updateProfile(
      {required ProfileModel profileModel}) async {
    final SharedPreferences localCache = await SharedPreferences.getInstance();
    await localCache.setString('profileData', jsonEncode(profileModel.toJson()));
  }

  static Future<ProfileModel?> getProfile() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? profileData = sharedPreferences.getString('profileData');
    if(profileData==null){
      return null;
    }else{
      return ProfileModel.fromJson(jsonDecode(profileData));
    }
  }
}
