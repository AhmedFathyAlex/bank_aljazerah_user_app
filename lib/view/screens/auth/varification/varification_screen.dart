import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/create_account_controller.dart';
import 'package:six_cash/controller/verification_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_pin_code_field.dart';
import 'package:six_cash/view/base/demo_otp_hint.dart';
import 'package:six_cash/view/screens/auth/varification/widget/information_section.dart';
import 'package:six_cash/view/screens/auth/varification/widget/timer_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getWhiteAndBlack(),
      appBar: CustomAppbar(title: 'phone_verification'.tr, onTap:() {
        Get.find<VerificationController>().cancelTimer();
        Get.back();
      }),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  InformationSection(),
                  const SizedBox(height: Dimensions.PADDING_SIZE_OVER_LARGE),

                  GetBuilder<VerificationController>(builder: (getController){
                    return  CustomPinCodeField(
                      padding: Dimensions.PADDING_SIZE_OVER_LARGE,
                      onCompleted: (pin){
                        getController.setOtp(pin);
                        String _phoneNumber =  Get.find<CreateAccountController>().phoneNumber;
                        Get.find<AuthController>().phoneVerify(_phoneNumber, pin);
                      },
                    );
                  }),

                  DemoOtpHint(),

                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                  TimerSection(),
                ],
              ),
            ),
          ),
          GetBuilder<AuthController>(builder: (controller)=>Container(
            height: 100,
            child: controller.isLoading ?
            Center(
              child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
            ): Container(),
          ))

        ],
      ),

    );
  }
}
