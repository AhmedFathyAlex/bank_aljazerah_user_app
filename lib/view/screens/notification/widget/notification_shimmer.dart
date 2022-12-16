import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/util/dimensions.dart';

class NotificationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size  =MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 10, padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[350],
          highlightColor: Colors.grey[200],
          child: Container(
            margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            color: Colors.black26,
            child: Row(
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,width: size.width*0.4,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 40,width: size.width*0.6,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                    height: Dimensions.NOTIFICATION_IMAGE_SIZE,
                    width: Dimensions.NOTIFICATION_IMAGE_SIZE,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_EXTRA_SMALL),
                      child: Container(color: Colors.black45,),
                    )
                )
              ],
            ),
          ),
        );
      },
    );
  }
}