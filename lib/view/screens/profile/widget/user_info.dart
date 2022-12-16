import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/data/model/response/user_info.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_image.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/screens/kyc_verify/kyc_verify_screen.dart';
import 'package:six_cash/view/screens/profile/widget/bootom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'profile_shimmer.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ProfileController>(
      builder: (profileController) =>
      profileController.isLoading ? ProfileShimmer() :
      Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_LARGE,
          vertical: Dimensions.PADDING_SIZE_LARGE,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                profileController.userInfo != null?
                Row(
                  children: [
                    Container(
                      width: Dimensions.SIZE_PROFILE_AVATAR,
                      height: Dimensions.SIZE_PROFILE_AVATAR,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_PROFILE_AVATAR)),
                        border: Border.all(width: 1, color: Theme.of(context).highlightColor),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_PROFILE_AVATAR)),
                        child: CustomImage(
                          fit: BoxFit.cover,
                          image: "${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}/${
                              profileController.userInfo.image}",
                          placeholder: Images.avatar,
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            '${profileController.userInfo.fName} ${profileController.userInfo.lName}',
                            style: rubikMedium.copyWith(
                              color: Theme.of(context).textTheme.bodyText1.color,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            '${profileController.userInfo.phone}',
                            style: rubikMedium.copyWith(
                              color: Theme.of(context).textTheme.bodyText1.color.withOpacity(Get.isDarkMode ? 0.8 :0.5),
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                            textAlign: TextAlign.start, maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ):SizedBox(),

                InkWell(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    isDismissible: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_SIZE_LARGE)),
                    ),
                    builder: (context) => ProfileQRCodeBottomSheet(),
                  ),
                  child: GetBuilder<ProfileController>(builder: (controller) {
                    return Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).secondaryHeaderColor),
                      padding: EdgeInsets.all(10.0),
                      child: SvgPicture.string(controller.userInfo.qrCode, height: 24, width: 24,),
                    );
                  }),
                )
              ],
            ),

            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

            if(profileController.userInfo.kycStatus != KycVerification.APPROVE) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    profileController.userInfo.kycStatus == KycVerification.NEED_APPLY ?
                    'kyc_verification_is_not'.tr : profileController.userInfo.kycStatus == KycVerification.PENDING ?
                    'your_verification_request_is'.tr : 'your_verification_is_denied'.tr,
                    style: rubikRegular.copyWith(
                      color: Theme.of(context).errorColor,
                    ),
                    maxLines: 2,

                  ),
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),

                CustomInkWell(
                  onTap: () => Get.to(()=> KycVerifyScreen()),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      color: Theme.of(context).errorColor.withOpacity(0.8),
                    ),
                    child: Text(
                      profileController.userInfo.kycStatus == KycVerification.NEED_APPLY ?
                      'click_to_verify'.tr : profileController.userInfo.kycStatus == KycVerification.PENDING ?
                      'edit'.tr : 're_apply'.tr,
                      style: rubikMedium.copyWith(color: Theme.of(context).cardColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
