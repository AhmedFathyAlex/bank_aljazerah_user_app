import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
class CustomCard extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;
  final Color color;
   CustomCard({this.image, this.text, this.onTap, this.color}) ;

  @override
  Widget build(BuildContext context) {
     return Container(
       margin: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_DEFAULT), color: color,
         boxShadow: [BoxShadow(color: ColorResources.getWhiteAndBlack().withOpacity(0.1), blurRadius: 40, offset: const Offset(0, 4))]),


       child: CustomInkWell(
         onTap: onTap,
         radius: Dimensions.RADIUS_SIZE_DEFAULT,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
             Container(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
               decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.7)),
               child: SizedBox(height: 25, width: 25,
                 child: Image.asset(image, fit: BoxFit.contain))),
             const SizedBox(height: 10),



             Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL+1),
               child: Text(text, textAlign: TextAlign.center, maxLines: 2, style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).textTheme.bodyText1.color),),
             )
           ],
         ),
       ),
     );
  }
}