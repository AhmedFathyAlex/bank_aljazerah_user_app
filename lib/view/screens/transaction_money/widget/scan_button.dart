import 'package:dotted_border/dotted_border.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';

class ScanButton extends StatelessWidget {
  final VoidCallback onTap;
  const ScanButton({Key key,@required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_OVER_LARGE),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: CustomInkWell(
        onTap: onTap,
        radius: Dimensions.RADIUS_SIZE_OVER_LARGE,
        child: DottedBorder(
          strokeWidth: 1.0,
          color: Theme.of(context).primaryColor,
          borderType: BorderType.RRect,
          radius: Radius.circular(Dimensions.RADIUS_SIZE_OVER_LARGE),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_SMALL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(Images.qrCode, width: Dimensions.PADDING_SIZE_DEFAULT),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Text('scan_qr_code'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.blackColor),),
                )
              ],
            ),
          )),
      ),
    );
  }
}