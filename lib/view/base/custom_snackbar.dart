import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

void showCustomSnackBar(String message, {bool isError = true, bool isIcon = false, bool isVpn = false, Duration duration}) {
  if(isVpn) {
    SmartDialog.show(
      onDismiss: () async {
        if(await ApiChecker.isVpnActive()) {
          showCustomSnackBar('', isVpn: true, duration: Duration(minutes: 10));
        }
      },
      alignment: Alignment.topCenter,
      builder: (_) {
        return Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(Get.context).errorColor,
          ),
          child: SafeArea(child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_SMALL,
              horizontal: Dimensions.PADDING_SIZE_LARGE,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('please_disable_the_vpn'.tr, style: rubikLight.copyWith(color: Colors.white),),

                IconButton(
                  icon: Icon(Icons.clear,size: 25),
                  color: Colors.white,
                  onPressed: () {
                    SmartDialog.dismiss();
                  },
                ),
              ],
            ),
          )),
        );
      },
    );

  }else{
    if(message != null && message.isNotEmpty){
      Get..closeCurrentSnackbar()..showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.BOTTOM,

        message: message,
        duration: Duration(seconds: 5),
        isDismissible: true,
        backgroundColor:  isError ? Colors.red : Colors.green,

        icon: isIcon ?  IconButton(icon: Icon(Icons.clear,size: 16,),color: Colors.white,
            onPressed: (){
              Get.back();
            }) : null,
      ));


    }
  }


}