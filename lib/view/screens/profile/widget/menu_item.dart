import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
class MenuItem extends StatelessWidget {
  const MenuItem({
    Key key,
    @required this.image,
    @required this.title,
    this.iconData,
  }) : super(key: key);
  final String image;
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(children: [
        SizedBox(
          width: Dimensions.PROFILE_PAGE_ICON_SIZE,
          height: Dimensions.PROFILE_PAGE_ICON_SIZE,
          child: image != null ?
          Image.asset(image,fit: BoxFit.contain) : Icon(iconData),
        ),
        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

        Text(title,style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
        Spacer(),

        Icon(Icons.arrow_forward_ios_rounded,size: Dimensions.RADIUS_SIZE_DEFAULT,),
      ],),
    );
  }
}