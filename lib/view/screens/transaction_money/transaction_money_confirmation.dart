import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/bootom_slider_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/data/model/withdraw_model.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:six_cash/view/base/custom_pin_code_field.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/base/demo_otp_hint.dart';
import 'package:six_cash/view/screens/transaction_money/widget/show_amount_view.dart';

import 'widget/bottom_sheet_with_slider.dart';
import 'widget/for_person_widget.dart';




class TransactionMoneyConfirmation extends StatelessWidget {
  final double inputBalance;
  final String transactionType;
  final String purpose;
  final ContactModel contactModel;
  final Function callBack;
  final WithdrawalMethod withdrawMethod;


  TransactionMoneyConfirmation({
    @required this.inputBalance,
    @required this.transactionType,
    this.purpose, this.contactModel,
    this.callBack,
    this.withdrawMethod,
  });
  final _pinCodeFieldController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final bottomSliderController = Get.find<BottomSliderController>();

    if(bottomSliderController.isPinCompleted != null) {
      bottomSliderController.setIsPinCompleted(isCompleted: false, isNotify: false);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: transactionType.tr,
        onTap: () => Get.back(),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(transactionType != TransactionType.WITHDRAW_REQUEST)
              ForPersonWidget(contactModel: contactModel),

            ShowAmountView(amountText:  inputBalance.toString(), onTap: callBack),

            if(transactionType != TransactionType.WITHDRAW_REQUEST)
              Container(
                height: Dimensions.DIVIDER_SIZE_MEDIUM,
                color: Theme.of(context).dividerColor,
              ),

            if(transactionType == TransactionType.WITHDRAW_REQUEST)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                  vertical: Dimensions.PADDING_SIZE_SMALL,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),

                  child: Column(children: [

                    _methodFieldView(
                      type: 'withdraw_method'.tr, value: withdrawMethod.methodName,
                    ),

                    SizedBox(height: 10,),

                    Column(
                      children: withdrawMethod.methodFields.map((_method) =>
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: _methodFieldView(
                              type: _method.inputName.replaceAll('_', ' ').capitalizeFirst,
                              value: _method.inputValue,
                            ),
                          ),
                      ).toList(),),

                  ]),
                ),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
                      bottom:Dimensions.PADDING_SIZE_DEFAULT,
                    ),

                    child: Text('4digit_pin'.tr, style: rubikMedium.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    )),
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center, height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(27.0),
                            color: ColorResources.getGreyBaseGray6(),
                          ),
                          child:PinCodeTextField(
                            controller: _pinCodeFieldController,
                            length: 4, appContext:  context,
                            onChanged: (value) => bottomSliderController.changePinComleted(value),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                            obscureText: true, hintCharacter: '•',
                            hintStyle: rubikMedium.copyWith(color: ColorResources.getGreyBaseGray4()),
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            cursorColor: Theme.of(context).highlightColor,
                            pinTheme: PinTheme.defaults(
                              shape: PinCodeFieldShape.circle,
                              activeColor: ColorResources.getGreyBaseGray6(),
                              activeFillColor: Colors.red,
                              selectedColor: ColorResources.getGreyBaseGray6(),
                              borderWidth: 0,
                              inactiveColor: ColorResources.getGreyBaseGray6(),
                            ),
                          ),

                        ),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                      GestureDetector(
                          onTap: (){
                            final _configModel = Get.find<SplashController>().configModel;
                            if(!Get.find<BottomSliderController>().isPinCompleted) {
                              showCustomSnackBar('please_input_4_digit_pin'.tr);
                            }else {

                              Get.find<TransactionMoneyController>().pinVerify(
                                  pin: _pinCodeFieldController.text,
                              ).then((isCorrect){
                                if(isCorrect) {
                                  if(transactionType == TransactionType.WITHDRAW_REQUEST) {
                                    _placeWithdrawRequest();
                                  }
                                  else if(_configModel.twoFactor
                                      && Get.find<ProfileController>().userInfo.twoFactor
                                  ){
                                    Get.find<AuthController>().checkOtp().then((value) =>
                                    value.isOk ? Get.defaultDialog(
                                      barrierDismissible: false,
                                      title: 'otp_verification'.tr,
                                      content: Column(
                                        children: [
                                          CustomPinCodeField(
                                            onCompleted: (pin) => Get.find<AuthController>().verifyOtp(pin).
                                            then((value) {
                                              if(value.isOk){
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: Get.context,
                                                  isDismissible: false,
                                                  enableDrag: false,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_SIZE_LARGE)),
                                                  ),

                                                  builder: (context) => BottomSheetWithSlider(
                                                    amountCharge: _configModel.sendMoneyChargeFlat,
                                                    amount: inputBalance.toString(),
                                                    contactModel: contactModel,
                                                    pinCode: Get.find<BottomSliderController>().pin,
                                                    transactionType: transactionType,
                                                  ),
                                                );
                                              }
                                            }),
                                          ),

                                          DemoOtpHint(),

                                          GetBuilder<AuthController>(
                                            builder: (verifyController) =>
                                            verifyController.isVerifying ?
                                            CircularProgressIndicator(
                                              color: Theme.of(context).textTheme.titleLarge.color,
                                            ) : SizedBox.shrink(),
                                          )
                                        ],
                                      ),
                                    ) : null);
                                  }else{
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: Get.context,
                                        isDismissible: false,
                                        enableDrag: false,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(Dimensions.RADIUS_SIZE_LARGE),
                                        )),
                                        builder: (context) {
                                          return BottomSheetWithSlider(
                                            amountCharge: _configModel.sendMoneyChargeFlat,
                                            amount: inputBalance.toString(),
                                            contactModel: contactModel,
                                            pinCode: Get.find<BottomSliderController>().pin,
                                            transactionType: transactionType,
                                            purpose: purpose,
                                          );
                                        }
                                    );
                                  }
                                }
                                _pinCodeFieldController.clear();

                              });
                            }
                          },

                        child: GetBuilder<AuthController>(
                          builder: (otpCheckController) {
                            return GetBuilder<TransactionMoneyController>(
                              builder: (pinVerify) {
                                return pinVerify.isLoading|| otpCheckController.isLoading ?
                                SizedBox(
                                  width: Dimensions.RADIUS_SIZE_OVER_LARGE,
                                  height:  Dimensions.RADIUS_SIZE_OVER_LARGE,
                                  child: Center(
                                    child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
                                  ),
                                ) :
                                Container(
                                  width: Dimensions.RADIUS_SIZE_OVER_LARGE,
                                  height:  Dimensions.RADIUS_SIZE_OVER_LARGE,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Theme.of(context).secondaryHeaderColor,
                                  ),
                                  child: Icon(Icons.arrow_forward, color: ColorResources.blackColor),
                                );
                              },
                            );
                          },
                        ),
                      ),

                    ],
                  )

                ],
              ),
            )


          ],
        ),
      ),
    );
  }

  void _placeWithdrawRequest() {
    Map<String, String> _withdrawalMethodField = Map();

    withdrawMethod.methodFields.forEach((_method) {
      _withdrawalMethodField.addAll({'${_method.inputName}' : '${_method.inputValue}'});
    });

    List<Map<String, String>> _withdrawalMethodFieldList = [];
    _withdrawalMethodFieldList.add(_withdrawalMethodField);

    Map<String, String> _withdrawRequestBody = Map();
    _withdrawRequestBody = {
      'pin' : Get.find<BottomSliderController>().pin,
      'amount' : '$inputBalance',
      'withdrawal_method_id' : '${withdrawMethod.id}',
      'withdrawal_method_fields' : '${base64Url.encode(utf8.encode(jsonEncode(_withdrawalMethodFieldList)))}',
    };

    Get.find<TransactionMoneyController>().withDrawRequest(placeBody: _withdrawRequestBody);
  }


  Widget _methodFieldView({@required String type,@required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(type, style: rubikLight.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),),

        Text(value),
      ],
    );
  }

}





