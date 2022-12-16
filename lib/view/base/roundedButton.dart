import 'package:flutter/material.dart';

import '../../util/dimensions.dart';
import '../../util/styles.dart';
import 'custom_ink_well.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  final bool isSkip;
  const RoundedButton({Key key, this.buttonText = '', this.onTap, this.isSkip = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_EXTRA_LARGE),),
      child: CustomInkWell(
        onTap: onTap,
        radius: Dimensions.RADIUS_SIZE_EXTRA_LARGE,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: isSkip ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL),
          child: Text(
            buttonText,
            style: rubikRegular.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
            ),
          ),
        ),
      ),
    );
  }
}