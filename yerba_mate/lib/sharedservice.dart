import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/material.dart';

// adapted from Snippet Coder =>  https://www.youtube.com/watch?v=czed-wa21IU

class SharedService {
  static Future<bool> isLoggedIn() async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "login_details",
      syncData: jsonEncode(   {
        "id": 1648999519692.8813,
        "email": "hhwiu1079@gmail.com",
        "name": "Linus",
        "profileData": {},
        "mock": true
    },),
    );
    
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");
    print("CHECKING LOG IN");
    return isCacheKeyExist;
  }

  static Future<String?> loginDetails() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");

      return cacheData.syncData;
    }
  }

  static Future<void> setLoginDetails(String  loginResponse) async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "login_details",
      syncData: jsonEncode(loginResponse),
    );

    await APICacheManager().addCacheData(cacheModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_details");
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }
}