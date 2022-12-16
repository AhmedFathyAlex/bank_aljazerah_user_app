import 'package:country_code_picker/country_code.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController implements GetxService{
  String _countryCode = Get.find<SplashController>().getCountryCode();
  String _phoneNumber;
  String get countryCode => _countryCode;
  String get phoneNumber => _phoneNumber;

  setCountryCode(CountryCode code) {
    _countryCode = code.toString();
    update();
  }

  setPhoneNumber(String phone) {
    _phoneNumber = phone;
    update();
  }
  setInitCountryCode(String code) {
    _countryCode = code;
  }
  sendOtpResponse({@required String number}){
    String _number = number;
    if (_number.isEmpty) {
      showCustomSnackBar('please_give_your_phone_number'.tr, isError: true);
    }
    else if(_number.contains(new RegExp(r'[A-Z]'))){
      showCustomSnackBar('phone_number_not_contain_characters'.tr, isError: true);
    }
    else if(_number.contains(new RegExp(r'[a-z]'))){
      showCustomSnackBar('phone_number_not_contain_characters'.tr, isError: true);
    }
    else if(_number.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      showCustomSnackBar('phone_number_not_contain_spatial_characters'.tr, isError: true);
    }
    else{
      setPhoneNumber(number);
      Get.find<AuthController>().checkPhone(number);
    }
  }
}