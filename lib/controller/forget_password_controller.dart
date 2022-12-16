import 'package:country_code_picker/country_code.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassController extends GetxController implements GetxService{
  String _countryCode /*= Get.find<LoginController>().countryCode*/;
  String get countryCode => _countryCode;
  String _initNumber ;
  String get initNumber => _initNumber;
  String _otp;
  setOtp(String otp){
    _otp = otp;
  }

  setInitialCode(String code){
    _countryCode = code;
    update();
  }


  setCountryCode(CountryCode code){
    _countryCode = code.toString();
    update();
  }


  // setInitialNumber(){
  //   // _initNumber = Get.find<LoginController>().phoneController.text;
  //   //
  //   // phoneNumberController.text = _initNumber == null ? null : _initNumber;
  //   // update();
  //
  // }



  resetPassword(TextEditingController newPassController, TextEditingController confirmPassController, String phoneNumber){
    if(newPassController.text.isEmpty || confirmPassController.text.isEmpty){
      showCustomSnackBar('please_enter_your_valid_pin'.tr, isError: true);
    }
    else if(newPassController.text.length < 4){
      showCustomSnackBar('pin_should_be_4_digit'.tr, isError: true);
    }
    else if(newPassController.text == confirmPassController.text){
      // write code
      String _number = phoneNumber;
      print("phone : $_number");
      print("otp : $_otp");
      print("pass : ${newPassController.text}");
      print("Confirm pass : ${confirmPassController.text}");
      Get.find<AuthController>().resetPassword(_number, _otp, newPassController.text, confirmPassController.text);
    }
    else{
      showCustomSnackBar('pin_not_matched'.tr, isError: true);
    }
  }


  sendForOtpResponse({BuildContext context,@required String phoneNumber}) async {
    String _number = phoneNumber;
    if (_number.isEmpty) {
      showCustomSnackBar('please_give_your_phone_number'.tr,
          isError: true);
    }
    else if(_number.contains(new RegExp(r'[A-Z]'))){
      showCustomSnackBar(
          'phone_number_not_contain_characters'.tr,
          isError: true);
    }
    else if(_number.contains(new RegExp(r'[a-z]'))){
      showCustomSnackBar(
          'phone_number_not_contain_characters'.tr,
          isError: true);
    }
    else if(_number.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      showCustomSnackBar(
          'phone_number_not_contain_spatial_characters'.tr,

          isError: true);
    }
    else{
      String phoneNumber = _countryCode + _number;
      Get.find<AuthController>().otpForForgetPass(phoneNumber, context);

      print('=====Phone=====>$phoneNumber');

    }
  }

}