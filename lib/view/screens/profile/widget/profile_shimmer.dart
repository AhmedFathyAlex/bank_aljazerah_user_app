import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  size = MediaQuery.of(context).size;
    return Container(
      color: ColorResources.getWhiteAndBlack(),
      child: Shimmer.fromColors(baseColor: ColorResources.shimmerBaseColor, highlightColor:  ColorResources.shimmerLightColor,
          child : Container(

            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_DEFAULT),
            child: ListTile(
              leading: CircleAvatar(maxRadius: Dimensions.RADIUS_PROFILE_AVATAR),

              title:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(color: Colors.red, height: Dimensions.PADDING_SIZE_SMALL, width: size.width * 0.3),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Container(color: Colors.red, height: Dimensions.PADDING_SIZE_EXTRA_SMALL, width: size.width * 0.5),
                ],
              ),
            ),
          ),
      ),
    );
  }
}






