import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/util/dimensions.dart';
class AppBarShimmer extends StatelessWidget {
  const AppBarShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350],
      highlightColor: Colors.grey[200],
      child: Container(
        padding: const EdgeInsets.only(
            top: 54,
            left: Dimensions.PADDING_SIZE_LARGE,
            right: Dimensions.PADDING_SIZE_LARGE,
            bottom: Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_LARGE),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: Dimensions.RADIUS_SIZE_OVER_LARGE,
              width: Dimensions.RADIUS_SIZE_OVER_LARGE,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius:
                BorderRadius.circular(Dimensions.RADIUS_SIZE_DEFAULT),
              ),
            ),
            const SizedBox(
              width: Dimensions.PADDING_SIZE_SMALL,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.FONT_SIZE_DEFAULT,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: Dimensions.FONT_SIZE_OVER_LARGE,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ],
            ),
            const Spacer(),
            Container(
              height: 45,width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
