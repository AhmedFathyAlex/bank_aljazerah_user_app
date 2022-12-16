import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/add_money_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/view/base/animated_custom_dialog.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_loader.dart';
import 'package:six_cash/view/base/my_dialog.dart';
import 'package:six_cash/view/screens/deshboard/nav_bar_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  String selectedUrl;
  double value = 0.0;
  bool _isLoading = true;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();
    selectedUrl = '${Get.find<AddMoneyController>().addMoneyWebLink}';

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>_exitApp(context),
      child: Scaffold(
        backgroundColor: ColorResources.getBackgroundColor(),
        appBar: CustomAppbar(title: 'add_money'.tr),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: selectedUrl,
                    gestureNavigationEnabled: true,
                    userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.future.then((value) => controllerGlobal = value);
                      _controller.complete(webViewController);
                    },
                    onPageStarted: (String url) {
                      if(url.contains(AppConstants.BASE_URL)) {
                        bool _isSuccess = url.contains('success');
                        bool _isFailed = url.contains('fail');
                        print('Page started loading: $url');
                        setState(() {
                          _isLoading = true;
                        });
                        if (_isSuccess) {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => NavBarScreen()), (route) => false);
                          Get.find<ProfileController>().profileData(reload:true);
                          showAnimatedDialog(context, MyDialog(
                            icon: Icons.done,
                            title: 'payment_done'.tr,
                            description: 'your_payment_successfully_done'.tr,
                          ), dismissible: false, isFlip: true);
                        } else if (_isFailed) {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => NavBarScreen()), (route) => false);
                          showAnimatedDialog(context, MyDialog(
                            icon: Icons.clear,
                            title: 'payment_failed'.tr,
                            description: 'your_payment_failed'.tr,
                            isFailed: true,
                          ), dismissible: false, isFlip: true);
                        } else if (url == '${AppConstants.BASE_URL}/cancel') {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => NavBarScreen()), (route) => false);
                          showAnimatedDialog(context, MyDialog(
                            icon: Icons.clear,
                            title: 'payment_cancelled'.tr,
                            description: 'your_payment_cancelled'.tr,
                            isFailed: true,
                          ), dismissible: false, isFlip: true);
                        }
                      }
                    },
                    onPageFinished: (String url) {
                      print('Page finished loading: $url');
                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),

                  _isLoading ? Center(
                    child: CustomLoader(color: Theme.of(context).primaryColor),
                  ) : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => NavBarScreen()), (route) => false);
      showAnimatedDialog(context, MyDialog(
        icon: Icons.clear,
        title: 'payment_cancelled'.tr,
        description: 'your_payment_cancelled'.tr,
        isFailed: true,
      ), dismissible: false, isFlip: true);
      return Future.value(true);
    }
  }
}
