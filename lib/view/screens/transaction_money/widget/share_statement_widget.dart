import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:screenshot/screenshot.dart';
import 'package:six_cash/controller/screen_shot_widget_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_logo.dart';

class ShareStatementWidget extends StatefulWidget {
  final String amount;
  final String transactionType;
  final ContactModel contactModel;
  final String charge;
  final String trxId;
  const ShareStatementWidget({Key key,@required this.amount, @required this.transactionType, @required this.contactModel,@required this.charge,@required this.trxId}) : super(key: key);

  @override
  State<ShareStatementWidget> createState() => ShareStatementWidgetState();
}

class ShareStatementWidgetState extends State<ShareStatementWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final splashController = Get.find<SplashController>();
        return Screenshot(
          key: widget.key,
          controller: Get.find<ScreenShootWidgetController>().statementController,
          child: Scaffold(
            backgroundColor: ColorResources.backgroundColor,
            body: Center(
              child: Container(
                height: size.height,
                width: size.width,
                margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: ColorResources.blackColor.withOpacity(0.25),
                        blurRadius: 6,
                      )
                    ]
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       SizedBox(height: 100,width: 100,child: Image.asset(Images.success_icon)) ,

                      Center(child: Text('successful'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_OVER_OVER_LARGE, color: Theme.of(context).primaryColor))),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      Text('${PriceConverter.balanceWithSymbol(balance: widget.amount)}', style: rubikSemiBold.copyWith(fontSize: 40 , color: Theme.of(context).primaryColor)),
                      widget.transactionType != 'request_money' ? Text('charge'.tr + ' ' + widget.charge, style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,color: Theme.of(context).primaryColor)) : SizedBox.shrink(),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      Divider(
                        color: ColorResources.phoneNumberColor,
                        height: 1,
                        endIndent: size.width*0.3,
                        indent: size.width*0.3,
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Divider(
                        color: ColorResources.phoneNumberColor,
                        height: 1,
                        endIndent: size.width*0.4,
                        indent: size.width*0.4,
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_OVER_LARGE,
                      ),
                      Text(widget.transactionType == 'send_money'? 'send_money'.tr : widget.transactionType == 'cash_out'? 'cash_out'.tr : 'request_money'.tr, style: rubikSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_OVER_LARGE)),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Center(child: Text('${widget.contactModel.name == null ? '' :
                        widget.contactModel.name} (${widget.contactModel.phoneNumber})', textAlign : TextAlign.center,
                          style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).primaryColor))),

                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                      widget.trxId != null ?  Text( 'trx_id'.tr +': ${widget.trxId}', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)) : SizedBox(),

                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE,
                      ),

                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        CustomLogo(width: 67, height: 67),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Text('${splashController.configModel.companyName}', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_OVER_OVER_LARGE, color: Theme.of(context).primaryColor)),
                        ),
                      ],)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
