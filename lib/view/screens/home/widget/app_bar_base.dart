import 'package:six_cash/controller/home_controller.dart';
import 'package:six_cash/controller/menu_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/view/base/custom_image.dart';
import 'package:six_cash/view/screens/home/widget/animated_card/custom_rect_tween.dart';
import 'package:six_cash/view/screens/home/widget/animated_card/hero_dialogue_route.dart';
import 'package:six_cash/view/screens/home/widget/animated_card/qr_popup_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/screens/home/widget/show_balance.dart';
import 'package:six_cash/view/screens/home/widget/show_name.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';
import 'package:six_cash/view/screens/transaction_money/widget/animated_button.dart';

class AppBarBase extends StatelessWidget implements PreferredSizeWidget {
  AppBarBase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return Container(
          color: Theme.of(context).primaryColor,


          child: Container(
            padding: const EdgeInsets.only(
              top: 54, left: Dimensions.PADDING_SIZE_LARGE,
              right: Dimensions.PADDING_SIZE_LARGE,
              bottom: Dimensions.PADDING_SIZE_SMALL,
            ),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_LARGE),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  GestureDetector(
                    onTap: () => Get.find<MenuController>().selectProfilePage(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: Dimensions.RADIUS_SIZE_OVER_LARGE,
                      width: Dimensions.RADIUS_SIZE_OVER_LARGE,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: profileController.userInfo == null ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(Images.avatar,fit: BoxFit.cover),
                          ),
                        ) : CustomImage(
                          image: '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}/${profileController.userInfo.image ?? ''}',
                          fit: BoxFit.cover,
                          placeholder: Images.avatar,
                        ),

                      ),
                    ),
                  ),
                  const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                  Get.find<SplashController>().configModel.themeIndex == '1'
                      ? ShowName()
                      : ShowBalance(profileController:profileController),
                ],),

                // const Spacer(),

                Row(children: [
                  AnimatedButtonView(
                    onTap: ()=> Get.to(()=> TransactionMoneyBalanceInput(
                    transactionType: TransactionType.WITHDRAW_REQUEST,
                    )),
                  ),

                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),


                  GestureDetector(
                    onTap: () => Navigator.of(context).push(HeroDialogRoute(builder:(_) =>QrPopupCard())),

                    child: Hero(
                      tag: Get.find<HomeController>().heroShowQr,
                      createRectTween: (begin, end) => CustomRectTween(begin: begin, end: end),

                      child: Container(
                        width: Get.width * 0.11,
                        height: Get.width * 0.11,
                        padding: EdgeInsets.all(Get.width * 0.025),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Theme.of(context).cardColor,
                        ),
                        child: profileController.userInfo != null ? SvgPicture.string(
                          profileController.userInfo.qrCode,
                          height: Dimensions.PADDING_SIZE_LARGE,
                          width: Dimensions.PADDING_SIZE_LARGE,
                        ) :
                        SizedBox(
                          height: Dimensions.PADDING_SIZE_LARGE,
                          width: Dimensions.PADDING_SIZE_LARGE,
                          child: Image.asset(Images.qrCode),
                        ),
                      ),
                    ),
                  ),
                ],)
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 200);
}
