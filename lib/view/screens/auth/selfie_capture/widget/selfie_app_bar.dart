import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';

class SelfieAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool showIcon;
  final Function onTap;
  final bool fromEditProfile;
   SelfieAppbar({ this.onTap,@required this.showIcon, @required this.fromEditProfile});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
      child: Padding(
        padding: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
            bottom: Dimensions.PADDING_SIZE_LARGE),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onTap,
             child: showIcon ?  Icon(Icons.clear,color: Colors.white,)
             : Container(),
            ),
            Container(
              alignment: Alignment.center,
              child: showIcon ? IconButton(
                onPressed: () {
                  fromEditProfile  ? Get.offNamed(RouteHelper.getEditProfileRoute()) : Get.offNamed(RouteHelper.getOtherInformationRoute()) ;
                },
                icon: Icon(Icons.check,color: Colors.white,),
              ) : Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size(double.maxFinite, Dimensions.APPBAR_HIGHT_SIZE);
}
