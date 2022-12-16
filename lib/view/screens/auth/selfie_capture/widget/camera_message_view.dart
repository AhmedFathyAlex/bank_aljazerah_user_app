import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';

class CameraMessageView extends StatelessWidget {
  const CameraMessageView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
              Dimensions.RADIUS_SIZE_VERY_SMALL)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'take_a_selfie'.tr,
            style: rubikRegular.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            ),
          ),
          const SizedBox(
            height: Dimensions.PADDING_SIZE_SMALL,
          ),
          Text(
            'place_your_face_inside_the_frame'.tr,
            style: rubikLight.copyWith(
              color: ColorResources.getOnboardGreyColor(),
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
            ),
          ),
        ],
      ),
    );
  }
}
