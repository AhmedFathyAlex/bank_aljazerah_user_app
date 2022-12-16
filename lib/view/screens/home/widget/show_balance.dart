import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

class ShowBalance extends StatelessWidget {
  final ProfileController profileController;
  const ShowBalance({Key key, this.profileController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
      children: [
        profileController.userInfo != null
        ?Text(PriceConverter.balanceWithSymbol(balance: profileController.userInfo.balance.toString()), style: rubikMedium.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_OVER_LARGE,))
        :Text(PriceConverter.balanceWithSymbol(balance: '0.0'), style: rubikMedium.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_OVER_LARGE,)
          ),
        const SizedBox(
          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        ),
        Text('available_balance'.tr, style: rubikLight.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Colors.white))
      ],
    );
  }
}
