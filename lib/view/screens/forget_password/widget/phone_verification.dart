import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/forget_password_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_pin_code_field.dart';
import 'package:six_cash/view/base/demo_otp_hint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'information_view.dart';
class PhoneVerification extends StatefulWidget {
  final String phoneNumber;
  const PhoneVerification({Key key, this.phoneNumber}) : super(key: key);

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.getWhiteAndBlack(),
        appBar: CustomAppbar(title: 'phone_verification'.tr),
        body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      InformationView(phoneNumber: widget.phoneNumber),
                      const SizedBox(height: Dimensions.PADDING_SIZE_OVER_LARGE),

                      CustomPinCodeField(
                        padding: Dimensions.PADDING_SIZE_OVER_LARGE,
                        onCompleted: (pin){
                          Get.find<ForgetPassController>().setOtp(pin);
                          String _phoneNumber = widget.phoneNumber;
                          Get.find<AuthController>().verificationForForgetPass(_phoneNumber, pin);
                        },
                      ),
                      const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                      DemoOtpHint(),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                child:  GetBuilder<AuthController>(builder: (controller){
                  return controller.isLoading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)) : SizedBox();
                },),
              )

            ],
          ),


    );
  }
}
