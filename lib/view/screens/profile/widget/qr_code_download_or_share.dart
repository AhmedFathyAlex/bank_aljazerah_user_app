
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:six_cash/controller/screen_shot_widget_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_logo.dart';
class QrCodeDownloadOrShareScreen extends StatelessWidget {
  final String qrCode;
  final String phoneNumber;
  const QrCodeDownloadOrShareScreen({@required this.qrCode, @required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Screenshot(
        controller: Get.find<ScreenShootWidgetController>().statementController,
        child: Scaffold(
          backgroundColor: ColorResources.backgroundColor,
          body: Center(
            child: Container(
              height: size.height,
              width: size.width,
              margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: ColorResources.blackColor.withOpacity(0.25), blurRadius: 6)]
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomLogo(height: Dimensions.BIG_LOGO, width: Dimensions.BIG_LOGO),
                        const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                        Text(
                          Get.find<SplashController>().configModel.companyName,
                          style: rubikMedium.copyWith(color: Theme.of(context).primaryColor,
                          fontSize: Dimensions.FONT_SIZE_OVER_OVER_LARGE),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE),

                    SvgPicture.string(qrCode,height: size.width*0.6,width: size.width*0.6),
                    const SizedBox(height: Dimensions.PADDING_SIZE_OVER_LARGE),

                    Text(
                      phoneNumber,
                      style: rubikRegular.copyWith(
                        color: ColorResources.phoneNumberColor,
                        fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                    Divider(
                      color: ColorResources.phoneNumberColor,
                      height: 1,
                      endIndent: size.width * 0.3,
                      indent: size.width * 0.3,
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    Divider(
                      color: ColorResources.phoneNumberColor,
                      height: 1,
                      endIndent: size.width * 0.4,
                      indent: size.width * 0.4,
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    Text(
                      'scan_the_QR_code_to_send_money'.tr,
                      style: rubikSemiBold.copyWith(
                        color: ColorResources.phoneNumberColor,
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                    Container(
                      height: 30,
                      width: double.infinity,
                      decoration: BoxDecoration(gradient: LinearGradient(
                        colors: ColorResources.ssColor,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
