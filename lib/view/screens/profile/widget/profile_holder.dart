import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key key,
    @required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).canvasColor,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, top: 30.0, bottom: 8.0,right: Dimensions.PADDING_SIZE_DEFAULT),
            child: Text(title,style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getGreyBaseGray1())),
          ),
        ),
        Container(
          height: Dimensions.DIVIDER_SIZE_SMALL,
          color: Theme.of(context).dividerColor,
        ),

      ],
    );
  }
}