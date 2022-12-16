import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationView extends StatelessWidget {
  final String phoneNumber;
  const InformationView({Key key, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomLogo(
          height: 70,
          width: 70,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_LARGE),
          child: Text(
            'phone_number_verification'.tr,
            style: rubikMedium.copyWith(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE),
          child: Text(
            'verification_long_text'.tr,
            style: rubikLight.copyWith(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            phoneNumber != null ? Text(
              phoneNumber,
              style: rubikRegular.copyWith(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              ),
              textAlign: TextAlign.center,
            ) : 'No number',
           /*GetBuilder<ForgetPassController>(builder: (controller) =>  Text(
             controller.countryCode + controller.phoneNumberController.text,
             // '09886755',
             style: rubikRegular.copyWith(
               color: Theme.of(context).textTheme.bodyText1.color,
               fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
             ),
             textAlign: TextAlign.center,
           ),),*/
            const SizedBox(
              width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            InkWell(
              onTap: (){
                Get.back();
              },
              child: Text(
                '(Change Number)',
                style: rubikRegular.copyWith(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
