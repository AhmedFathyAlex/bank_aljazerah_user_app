import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/create_account_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/camera_screen_controller.dart';
import 'package:six_cash/controller/verification_controller.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/data/model/body/signup_body.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/auth/pin_set/widget/appbar_view.dart';
import 'package:six_cash/view/screens/auth/pin_set/widget/pin_view.dart';

class PinSetScreen extends StatelessWidget {
  final String occupation, fName,lName,email;
   PinSetScreen({Key key, this.occupation, this.fName, this.lName, this.email}) : super(key: key);

  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: Theme.of(context).cardColor,
                    ),
                  )
                ],
              ),
              Positioned(
                top: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
                left: 0,
                right: 0,
                child: AppbarView(isLogin: false,),
              ),
              Positioned(
                top: 135,
                left: 0,
                right: 0,
                bottom: 0,
                child: PinView(passController: passController,confirmPassController: confirmPassController,),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 20,right: 10),
            child:   FloatingActionButton(

              onPressed: () {
                if(passController.text.isEmpty  || confirmPassController.text.isEmpty){
                  showCustomSnackBar('enter_your_pin'.tr, isError: true);
                }else{
                  if(passController.text.length < 4 ){
                    showCustomSnackBar('pin_should_be_4_digit'.tr, isError: true);
                  }
                  else{
                    if(passController.text == confirmPassController.text){

                      String _password =  passController.text;
                      String _gender =  Get.find<ProfileController>().gender;
                      String _occupation =  occupation;
                      String _fName =  fName;
                      String _lName =  lName;
                      String _email =  /*email=='' ? null :*/ email;
                      String _phoneNumber =  Get.find<CreateAccountController>().phoneNumber;
                      File _image =  Get.find<CameraScreenController>().getImage;
                      String _otp =  Get.find<VerificationController>().otp;

                      SignUpBody signUpBody = SignUpBody(
                        fName: _fName,
                        lName: _lName,
                        gender: _gender,
                        occupation: _occupation,
                        email: _email,
                        phone: _phoneNumber,
                        otp: _otp,
                        password: _password,
                      );

                      MultipartBody multipartBody = MultipartBody('image',_image );
                      Get.find<AuthController>().registration(signUpBody,[multipartBody]);

                    }
                    else{
                      showCustomSnackBar('pin_not_matched'.tr, isError: true);
                    }
                  }
                }

              },
              elevation: 0,
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              child: GetBuilder<AuthController>(builder: (controller){
                return !controller.isLoading ? SizedBox(

                  child:  Icon(Icons.arrow_forward,color: Theme.of(context).textTheme.bodyText1.color,size: 28,),
                ) : Center(child: SizedBox(height: 20.33,
                    width: 20.33,
                    child: CircularProgressIndicator(color: Theme.of(context).primaryColor)));
              },),
            ) ,
          ),
        ),
      ),
    );
  }
}
