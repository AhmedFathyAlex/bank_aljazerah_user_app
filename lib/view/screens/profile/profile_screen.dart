import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/animated_custom_dialog.dart';
import 'package:six_cash/view/base/appbar_home_element.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/base/logout_dialog.dart';
import 'package:six_cash/view/screens/profile/widget/menu_item.dart' as widget;
import 'package:six_cash/view/screens/profile/widget/profile_holder.dart';
import 'package:six_cash/view/screens/profile/widget/status_menu.dart';
import 'package:six_cash/view/screens/profile/widget/user_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final splashController = Get.find<SplashController>();
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppbarHomeElement(title: 'profile'.tr),
      body: GetBuilder<AuthController>(builder: (authController){
        return ModalProgressHUD(
          inAsyncCall: authController.isLoading,
          progressIndicator: CircularProgressIndicator(color: Theme.of(context).primaryColor),
          child: SingleChildScrollView(
            child: Column(
              children: [
                UserInfo(),

                ProfileHeader(title: 'setting'.tr),

                Column(children: [

                  CustomInkWell(
                    child: widget.MenuItem(image: Images.edit_profile,title: 'edit_profile'.tr),
                    onTap:() => Get.toNamed(RouteHelper.getEditProfileRoute()),
                  ),

                  CustomInkWell(
                    child: widget.MenuItem(image: Images.request_list_image2,title: 'requests'.tr),
                    onTap:()=>Get.toNamed(RouteHelper.getRequestedMoneyRoute()),
                  ),

                  CustomInkWell(
                    child: widget.MenuItem(image: Images.my_requested_list_image,title: 'send_requests'.tr),
                    onTap:()=>Get.toNamed(RouteHelper.getRequestedMoneyRoute(from: 'won')),
                  ),

                  CustomInkWell(
                    child: widget.MenuItem(image: Images.pinChange_logo,title: 'change_pin'.tr),
                    onTap:()=> Get.toNamed(RouteHelper.getChangePinRoute()),
                  ),

                  CustomInkWell(
                    child: widget.MenuItem(image: Images.language_logo, title: 'change_language'.tr),
                    onTap:()=> Get.toNamed(RouteHelper.getChoseLanguageRoute()),
                  ),

                  if(Get.find<SplashController>().configModel.twoFactor)
                    GetBuilder<ProfileController>(builder: (profileController){
                      return profileController.isLoading ? TwoFactorShimmer() :
                      StatusMenu(
                        title: 'two_factor_authentication'.tr,
                        leading: Image.asset(Images.two_factor_authentication,width: 28.0),
                      );
                    }),

                  if(authController.isBiometricSupported) StatusMenu(
                    title: 'biometric_login'.tr, leading: Icon(Icons.fingerprint, size: 25), isAuth: true,
                  ),

                  CustomInkWell(
                    child: widget.MenuItem(
                      iconData: Icons.delete, image: null, title: 'delete_account'.tr,
                    ),
                    onTap: () {
                      showAnimatedDialog(context,
                          CustomDialog(
                            icon: Icons.question_mark_sharp,
                            title: 'are_you_sure_to_delete_account'.tr,
                            description: 'it_will_remove_your_all_information'.tr,
                            onTapFalseText: 'no'.tr,
                            onTapTrueText: 'yes'.tr,
                            isFailed: true,
                            onTapFalse: () => Get.back(),
                            onTapTrue: () => Get.find<AuthController>().removeUser(),
                            bigTitle: true,
                          ),
                          dismissible: false,
                          isFlip: true);
                    },
                  ),


                  GetBuilder<ProfileController>(builder: (profileController){
                    return Container(
                      padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                      child: Row( children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Image.asset(Images.change_theme,width: Dimensions.PROFILE_PAGE_ICON_SIZE,),
                        ),

                        Text('dark_mode'.tr,style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),

                        Spacer(),

                        Transform.scale(
                          scale: 1,
                          child: Switch(
                            onChanged: profileController.toggleSwitch,
                            value: profileController.isSwitched,
                            activeColor: Colors.black26,
                            activeTrackColor: Colors.grey,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.black,
                          ),
                        ),
                      ],),
                    );
                  },)

                ],
                ),

                ProfileHeader(title: '6cash_support'.tr),

                Column(children: [
                  if(((splashController.configModel.companyEmail != null) || (splashController.configModel.companyPhone != null)))
                    CustomInkWell(
                      child: widget.MenuItem(image: Images.support_logo,title: '24_support'.tr),
                      onTap: () => Get.toNamed(RouteHelper.getSupportRoute()),
                    ),

                  CustomInkWell(
                    child: widget.MenuItem(image: Images.question_logo, title: 'faq'.tr),
                    onTap:()=> Get.toNamed(RouteHelper.faq),
                  )
                ],),

                ProfileHeader(title: 'policies'.tr),

                Column(children: [

                  CustomInkWell(
                    child: widget.MenuItem(image: Images.about_us,title: 'about_us'.tr),
                    onTap:()=> Get.toNamed(RouteHelper.about_us),
                  ),

                  CustomInkWell(
                    child: widget.MenuItem(image: Images.terms,title: 'terms'.tr),
                    onTap:()=> Get.toNamed(RouteHelper.terms),
                  ),

                  CustomInkWell(
                    child: widget.MenuItem(image: Images.privacy, title: 'privacy_policy'.tr),
                    onTap:()=> Get.toNamed(RouteHelper.privacy),
                  )
                ],),

                ProfileHeader(title:'account'.tr),

                Column( children: [
                  CustomInkWell(
                    child: widget.MenuItem(image: Images.log_out,title: 'logout'.tr),
                    onTap:() => Get.find<ProfileController>().logOut(context),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                ],)
              ],
            ),
          ),
        );
      },)

    );
  }
}





