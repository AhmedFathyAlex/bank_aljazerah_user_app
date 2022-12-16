
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class ProfileRepo {
  final ApiClient apiClient;

  ProfileRepo({@required this.apiClient});


  Future<Response>  getProfileDataApi() async {
    return await apiClient.getData(AppConstants.CUSTOMER_PROFILE_INFO);
  }

  Future<Response>  getPurposeListApi() async {
    return await apiClient.getData(AppConstants.CUSTOMER_PURPOSE_URL );
  }

  Future<Response>  pinVerifyApi({@required String pin}) async {
    Map<String, Object> body = {'pin': pin};
    return await apiClient.postData(AppConstants.CUSTOMER_PIN_VERIFY,body);
  }

  Future<Response>  changePinApi({@required String oldPin,@required String newPin,@required String confirmPin}) async {
    Map<String, Object> _body = {'old_pin': oldPin, 'new_pin': newPin, 'confirm_pin':confirmPin};
    return await apiClient.postData(AppConstants.CUSTOMER_CHANGE_PIN,_body);
  }

  Future<Response>  updateTwoFactorApi() async {
    Map<String, Object> _body = {};
    return await apiClient.postData(AppConstants.CUSTOMER_UPDATE_TWO_FACTOR,_body);
  }



}