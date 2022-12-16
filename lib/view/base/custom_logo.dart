
import 'package:flutter/material.dart';
import 'package:six_cash/util/images.dart';

class CustomLogo extends StatelessWidget {
  final double height,width;
   CustomLogo({
    this.height,this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(Images.logo),
        ),
      ),
    );
  }
}
