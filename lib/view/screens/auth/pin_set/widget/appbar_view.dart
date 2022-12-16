import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_logo.dart';

import '../../../../base/roundedButton.dart';

class AppbarView extends StatelessWidget {
  final bool isLogin;
  const AppbarView({Key key,@required this.isLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
        right: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomLogo(
            height: Dimensions.SMALL_LOGO,
            width: Dimensions.SMALL_LOGO,
          ),
          isLogin
              ? RoundedButton(onTap: (){
            Get.toNamed(RouteHelper.getChoseLanguageRoute());
          }, buttonText:   'language'.tr,)
          : Container(),
        ],
      ),
    );
  }
}



