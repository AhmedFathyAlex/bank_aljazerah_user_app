
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class AuthRepo extends GetxService{
   final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({@required this.apiClient, @required this.sharedPreferences});


  Future<Response> checkPhoneNumber({String phoneNumber}) async {
    return apiClient.postData(AppConstants.CUSTOMER_PHONE_CHECK_URI, {"phone": phoneNumber});
  }
   Future<Response> resendOtp({String phoneNumber}) async {
     return apiClient.postData(AppConstants.CUSTOMER_PHONE_RESEND_OTP_URI, {"phone": phoneNumber});
   }
  
  Future<Response> verifyPhoneNumber({String phoneNumber,String otp}) async {
    return apiClient.postData(AppConstants.CUSTOMER_PHONE_VERIFY_URI, {"phone": phoneNumber, "otp": otp});
  }
   Future<Response> registration(Map<String,String> customerInfo,List<MultipartBody> multipartBody) async {
     return await apiClient.postMultipartData(AppConstants.CUSTOMER_REGISTRATION_URI, customerInfo,multipartBody);
   }
   Future<Response> login({String phone, String password}) async {
     return await apiClient.postData(AppConstants.CUSTOMER_LOGIN_URI, {"phone": phone, "password": password});
   }
   Future<Response> deleteUser() async {
     return await apiClient.deleteData(AppConstants.CUSTOMER_REMOVE);
   }

   Future<Response> updateToken() async {
     String _deviceToken;
     if (GetPlatform.isIOS) {
       NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
         alert: true, announcement: false, badge: true, carPlay: false,
         criticalAlert: false, provisional: false, sound: true,
       );
       if(settings.authorizationStatus == AuthorizationStatus.authorized) {
         _deviceToken = await _saveDeviceToken();
         FirebaseMessaging.instance.subscribeToTopic(AppConstants.ALL);
         FirebaseMessaging.instance.subscribeToTopic(AppConstants.USERS);
         debugPrint('=========>Device Token ======$_deviceToken');
       }
     }else {
       _deviceToken = await _saveDeviceToken();
       FirebaseMessaging.instance.subscribeToTopic(AppConstants.ALL);
       FirebaseMessaging.instance.subscribeToTopic(AppConstants.USERS);
       debugPrint('=========>Device Token ======$_deviceToken');
     }
     if(!GetPlatform.isWeb) {
       // FirebaseMessaging.instance.subscribeToTopic('six_cash');
       FirebaseMessaging.instance.subscribeToTopic(AppConstants.ALL);
       FirebaseMessaging.instance.subscribeToTopic(AppConstants.USERS);
     }
     return await apiClient.postData(AppConstants.TOKEN_URI, {"_method": "put", "token": _deviceToken});
   }


   Future<String> _saveDeviceToken() async {
     String _deviceToken = '';
     if(!GetPlatform.isWeb) {
       _deviceToken = await FirebaseMessaging.instance.getToken();
     }
     if (_deviceToken != null) {
     }
     return _deviceToken;
   }


   Future<Response>  checkOtpApi() async {
     return await apiClient.postData(AppConstants.CUSTOMER_CHECK_OTP,{});
   }

   Future<Response>  verifyOtpApi({@required String otp}) async {
     return await apiClient.postData(AppConstants.CUSTOMER_VERIFY_OTP, {'otp': otp });
   }


   Future<Response> logout() async {
     return await apiClient.postData(AppConstants.CUSTOMER_LOGOUT_URI,{});
   }
   Future<Response> updateProfile(Map<String,String> profileInfo, List<MultipartBody> multipartBody) async {
     return await apiClient.postMultipartData(AppConstants.CUSTOMER_UPDATE_PROFILE, profileInfo, multipartBody);
   }
   Future<Response>  pinVerifyApi({@required String pin}) async {
     return await apiClient.postData(AppConstants.CUSTOMER_PIN_VERIFY,{'pin': pin});
   }

   Future<bool> saveUserToken(String token) async {
     apiClient.token = token;
     apiClient.updateHeader(token);
     return await sharedPreferences.setString(AppConstants.TOKEN, token);
   }
   Future<void> saveCustomerName(String name) async{
    try{
      await sharedPreferences.setString(AppConstants.CUSTOMER_NAME, name);
    }
    catch(e){
      throw e;
    }
   }
   Future<void> saveCustomerCountryCode(String code) async{
     try{
       await sharedPreferences.setString(AppConstants.COUNTRY_CODE, code);
     }
     catch(e){
       throw e;
     }
   }
   Future<void> saveCustomerNumber(String number) async{
     try{
       await sharedPreferences.setString(AppConstants.CUSTOMER_NUMBER, number);
     }
     catch(e){
       throw e;
     }
   }
   Future<void> saveCustomerQrCode(String qrCode) async{
     try{
       await sharedPreferences.setString(AppConstants.CUSTOMER_QR_CODE, qrCode);
     }
     catch(e){
       throw e;
     }
   }

   String getUserToken() {
     return sharedPreferences.getString(AppConstants.TOKEN) ?? null;
   }
   bool isLoggedIn() {
     return sharedPreferences.containsKey(AppConstants.TOKEN);
   }
   void removeUserToken()async{
     await sharedPreferences.remove(AppConstants.TOKEN);
   }

   String getCustomerName() {
     return sharedPreferences.getString(AppConstants.CUSTOMER_NAME) ?? '';
   }
   void removeCustomerName() async{
     await sharedPreferences.remove(AppConstants.CUSTOMER_NAME);
   }
   String getCustomerCountryCode() {
     return sharedPreferences.getString(AppConstants.COUNTRY_CODE) ?? '';
   }
   void removeCustomerCountryCode() async{
     await sharedPreferences.remove(AppConstants.COUNTRY_CODE);
   }
   String getCustomerNumber() {
     return sharedPreferences.getString(AppConstants.CUSTOMER_NUMBER) ?? '';
   }
   void removeCustomerNumber() async{
     await sharedPreferences.remove(AppConstants.CUSTOMER_NUMBER);
   }
   String getCustomerQrCode() {
     return sharedPreferences.getString(AppConstants.CUSTOMER_QR_CODE) ?? '';
   }
   void removeCustomerQrCode() async{
     await sharedPreferences.remove(AppConstants.CUSTOMER_QR_CODE);
   }
   void removeCustomerToken() async{
     await sharedPreferences.remove(AppConstants.TOKEN);
   }

   // for Forget password
   Future<Response> forgetPassOtp({String phoneNumber}) async {
     return apiClient.postData(AppConstants.CUSTOMER_FORGET_PASS_OTP_URI, {"phone": phoneNumber});
   }
   Future<Response> forgetPassVerification({String phoneNumber, String otp}) async {
     return apiClient.postData(AppConstants.CUSTOMER_FORGET_PASS_VERIFICATION, {"phone": phoneNumber, "otp": otp});
   }
   Future<Response> forgetPassReset({String phoneNumber, String otp, String password, String confirmPass}) async {
     return apiClient.putData(AppConstants.CUSTOMER_FORGET_PASS_RESET, {"phone": phoneNumber, "otp": otp, "password": password, "confirm_password": confirmPass});
   }

   Future<void> setBiometric(bool isActive) async {
    if(!isActive) {
     await deleteSecureData(AppConstants.BIOMETRIC_PIN);
    }
     sharedPreferences.setBool(AppConstants.BIOMETRIC_AUTH, isActive);
   }

   bool isBiometricEnabled() {
     return sharedPreferences.getBool(AppConstants.BIOMETRIC_AUTH) ?? true;
   }

   final FlutterSecureStorage _storage = FlutterSecureStorage();

   IOSOptions _getIOSOptions() => const IOSOptions(
     accessibility: KeychainAccessibility.first_unlock,
   );

   AndroidOptions _getAndroidOptions() => const AndroidOptions(
     encryptedSharedPreferences: true,
   );

   Future<String> readSecureData(String key) async {
     String value = "";
     try {
      String _value = await (_storage.read(key: key, aOptions: _getAndroidOptions(), iOptions: _getIOSOptions())) ?? "";
       String _decodeValue =  utf8.decode(base64Url.decode(_value));
       value = _decodeValue.replaceRange(4, _decodeValue.length, '');

     } catch (e) {
       print('error read data : $e');
     }
     return value;
   }

   Future<void> deleteSecureData(String key) async {
     try {
       await _storage.delete(key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
     } catch (e) {
       print(e);
     }

   }

   Future<void> writeSecureData(String key, String value) async {
     String _uniqueKey = base64Encode(utf8.encode('${UniqueKey().toString()}${UniqueKey().toString()}'));
     String _storeValue = base64Encode(utf8.encode('$value $_uniqueKey'));
     try {
       await _storage.write(
         key: key,
         value: _storeValue,
         iOptions: _getIOSOptions(),
         aOptions: _getAndroidOptions(),
       );
     } catch (e) {
       print('error from : repo : $e');
     }
   }

   Future<bool> containsKeyInSecureData(String key) async {
     var containsKey = await _storage.containsKey(key: key, aOptions: _getAndroidOptions(), iOptions: _getIOSOptions());
     return containsKey;
   }




}