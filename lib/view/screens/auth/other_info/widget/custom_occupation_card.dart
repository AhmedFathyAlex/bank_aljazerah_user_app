import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';

class CustomOccupationCard extends StatelessWidget {
  final String icon, text;
  final bool check;
  CustomOccupationCard({this.icon, this.text, this.check});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: Dimensions.PADDING_SIZE_DEFAULT,
            top: Dimensions.PADDING_SIZE_DEFAULT,
            bottom: Dimensions.PADDING_SIZE_LARGE,
          ),
          height: 75,
          width: 84,
          decoration: BoxDecoration(
            color: ColorResources.getOccupationCardColor(),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
            boxShadow: [
              BoxShadow(
                color: ColorResources.getShadowColor().withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 26.81,
                width: 26.81,
                child: Image.asset(icon),
              ),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: rubikRegular.copyWith(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Visibility(
            visible: check,
            child: Container(
              height: 16,width: 16,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check,color: Colors.white,size: 12,),
            ),
          ),
        ),
      ],
    );
  }
}
