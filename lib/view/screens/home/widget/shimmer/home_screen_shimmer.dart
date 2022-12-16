import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/app_bar_shimmer.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/banner_shimmer.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/web_site_shimmer.dart';
class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarShimmer(),
        Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey[200],
          child: Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.black12,
              ),
              Positioned(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 90,
                      margin: const  EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE,
                          vertical: Dimensions.PADDING_SIZE_LARGE),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SIZE_LARGE),
                        color: Colors.black26,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_LARGE,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: Dimensions.FONT_SIZE_LARGE,
                                  width: size.width*0.2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.black26,
                                  ),
                                ),

                                SizedBox(
                                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                ),
                                Container(
                                  height: Dimensions.FONT_SIZE_OVER_LARGE,
                                  width: size.width*0.2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.black26,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 90,
                            width: size.width *0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_LARGE),
                              color: Colors.black26,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),

                          ),
                        ],
                      ),
                    ),

                    /// Cards...
                    SizedBox(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.FONT_SIZE_EXTRA_SMALL),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: Colors.black26,
                                ),

                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Banner..
                    BannerShimmer(),
                    WebSiteShimmer(),

                  ],
                ),
              ),
            ],
          ),
        )
          ],
        ),
      ),
    );
  }
}
