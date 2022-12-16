import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';

class HtmlViewScreen extends StatelessWidget {
  final String title;
  final String url;
  HtmlViewScreen({@required this.url, @required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getBackgroundColor(),
      appBar: CustomAppbar(title: title),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Column(
          children: [
            Html(
              data: url ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
