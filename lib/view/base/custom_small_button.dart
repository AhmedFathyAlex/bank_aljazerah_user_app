
import 'package:flutter/material.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

class CustomSmallButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color backgroundColor;
  final Color textColor;
  final double textSize;
  CustomSmallButton({
    this.backgroundColor,
    @required this.onTap,
    this.text,
    @required this.textColor,
    this.textSize = Dimensions.FONT_SIZE_LARGE,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_DEFAULT),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
        ),
      ),
      child:  Text(
        text,
        style: rubikRegular.copyWith(
          color: textColor,
          fontSize: textSize,
        ),
      ),
    );
  }
  //Dimensions.FONT_SIZE_EXTRA_LARGE
}
