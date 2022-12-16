import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';

class ContactShimmer extends StatelessWidget {
  const ContactShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  size = MediaQuery.of(context).size;
        return Shimmer.fromColors(baseColor: ColorResources.shimmerBaseColor, highlightColor:  ColorResources.shimmerLightColor,
            child: ListView.builder( itemCount: 10,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, item) =>
                Column(
                  children: [
                    ListTile(leading: CircleAvatar(foregroundColor: Colors.red),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:  Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                      child: Container(color: Colors.red, height: Dimensions.DIVIDER_SIZE_SMALL),
                    ),
                  ],
                ),
            ),
          );
  }
}
