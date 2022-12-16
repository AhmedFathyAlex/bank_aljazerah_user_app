import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'custom_button.dart';

class MyDialog extends StatelessWidget {
  final bool isFailed;
  final bool showTwoBtn;
  final double rotateAngle;
  final IconData icon;
  final String title;
  final String description;
  final Function onTap;
  MyDialog({this.isFailed = false, this.rotateAngle = 0, @required this.icon, @required this.title, @required this.description, this.showTwoBtn = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Stack(clipBehavior: Clip.none, children: [

          Positioned(
            left: 0, right: 0, top: -55,
            child: Container(
              height: 80,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: isFailed ? ColorResources.getRedColor() : Theme.of(context).primaryColor, shape: BoxShape.circle),
              child: Transform.rotate(angle: rotateAngle, child: Icon(icon, size: 40, color: Colors.white)),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(title, style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Text(description, textAlign: TextAlign.center, style: rubikRegular),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Visibility(
                visible: !showTwoBtn,
                  child:  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                    child: CustomButton(buttonText: 'ok'.tr , onTap: () => Navigator.pop(context),color: Colors.green,),
                  ),
              ),
              Visibility(
                visible: showTwoBtn,
                child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [

                      Expanded(child: CustomButton(buttonText: 'no'.tr,color: ColorResources.getRedColor(), onTap: () => Navigator.pop(context))),
                      SizedBox(width: 10,),
                      Expanded(child: CustomButton(buttonText: 'yes'.tr, onTap: onTap,color: ColorResources.getAcceptBtn(),)),
                    ],
                  ),
                ),
              ),
            ]),
          ),

        ]),
      ),
    );
  }
}
