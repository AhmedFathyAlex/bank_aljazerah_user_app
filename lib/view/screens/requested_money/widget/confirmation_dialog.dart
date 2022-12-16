import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/requested_money_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_button.dart';
import 'package:six_cash/view/base/custom_password_field.dart';

class ConfirmationDialog extends StatefulWidget {
  final String icon;
  final String title;
  final String description;
  final Function onYesPressed;
  final bool isAccept;
  final TextEditingController passController;
  ConfirmationDialog({@required this.icon, this.title, @required this.description, @required this.onYesPressed, this.isAccept = false,@required this.passController});

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Stack(clipBehavior: Clip.none, children: [

        Positioned(
          left: 0, right: 0, top: -55,
          child: Container(
            height: 80,
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: widget.isAccept ? ColorResources.getAcceptBtn() : ColorResources.getRedColor() , shape: BoxShape.circle),
            child: Transform.rotate(angle: 0, child:Image.asset(widget.icon, width: 50, height: 50)),
          ),
        ),

        GetBuilder<RequestedMoneyController>(builder: (reqController){
          return Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.title != null ? Text(widget.title, style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)) :  SizedBox(),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Text(widget.description, textAlign: TextAlign.center, style: rubikRegular),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  CustomPasswordField(
                    hint: '＊＊＊＊',
                    controller: widget.passController,
                    isShowSuffixIcon: false,
                    isPassword: true,
                    isIcon: false,
                    textAlign: TextAlign.center,
                  ),

                  !reqController.isLoading? Row(
                    children: [

                      Expanded(child: CustomButton(buttonText: 'no'.tr,color: ColorResources.getRedColor(), onTap: (){
                        widget.passController.text = '';
                        Navigator.pop(context);
                      })),
                      SizedBox(width: 10,),
                      Expanded(child: CustomButton(buttonText: 'yes'.tr, onTap: widget.onYesPressed,color: ColorResources.getAcceptBtn(),)),
                    ],
                  ) : Center(child: CircularProgressIndicator(color: Theme.of(context).textTheme.titleLarge.color)),
                ]),
          );
        })

    ]),
      ),);
  }
}