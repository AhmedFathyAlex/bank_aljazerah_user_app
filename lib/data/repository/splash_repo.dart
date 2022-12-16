import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class SplashRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({@required this.sharedPreferences, @required this.apiClient});

  Future<Response> getConfigData() async {
   // Response _response = await apiClient.postData(AppConstants.CONFIG_URI, {'email': 'ashek@gmail.com', 'password': '0123456'});
    Response _response = await apiClient.getData(AppConstants.CONFIG_URI);
    return _response;
  }

  Future<bool> initSharedData() {
    if(!sharedPreferences.containsKey(AppConstants.THEME)) {
      return sharedPreferences.setBool(AppConstants.THEME, false);
    }
    if(!sharedPreferences.containsKey(AppConstants.CUSTOMER_COUNTRY_CODE)) {
      return sharedPreferences.setString(AppConstants.CUSTOMER_COUNTRY_CODE, AppConstants.languages[0].countryCode);
    }
    if(!sharedPreferences.containsKey(AppConstants.LANGUAGE_CODE)) {
      return sharedPreferences.setString(AppConstants.LANGUAGE_CODE, AppConstants.languages[0].languageCode);
    }
    if(!sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      return sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.SEND_MONEY_SUGGEST_LIST)) {
      return sharedPreferences.setString(AppConstants.SEND_MONEY_SUGGEST_LIST, '');
    }
    if(!sharedPreferences.containsKey(AppConstants.REQUEST_MONEY_SUGGEST_LIST)) {
      return sharedPreferences.setString(AppConstants.REQUEST_MONEY_SUGGEST_LIST, '');
    }
    if(!sharedPreferences.containsKey(AppConstants.RECENT_AGENT_LIST)) {
      return sharedPreferences.setString(AppConstants.RECENT_AGENT_LIST, '');
    }
    if(!sharedPreferences.containsKey(AppConstants.BIOMETRIC_AUTH)) {
      sharedPreferences.setBool(AppConstants.BIOMETRIC_AUTH, true);
    }

    return Future.value(true);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences.clear();
  }
}
