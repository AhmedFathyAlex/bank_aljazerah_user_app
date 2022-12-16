import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    print('splash screen call');

    _onConnectivityChanged = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
      print('splash screen call 3');
      if(await ApiChecker.isVpnActive()) {
        showCustomSnackBar('you are using vpn', isVpn: true, duration: Duration(minutes: 10));
      }
      if(!_firstTime) {
        print('connection state : $result');
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;

        showCustomSnackBar(
          isNotConnected ? 'no_connection'.tr : 'connected'.tr,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          isError: isNotConnected,
        );

        if(!isNotConnected) {
          _route();
        }
      }else{
        print('splash screen call 2');

        _route();
      }

    });

  }


  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((value) {
      print('config call ');
      if(value.isOk)
      Timer(Duration(seconds: 1), () async {
        Get.find<SplashController>().initSharedData().then((value) {
          (Get.find<AuthController>().getCustomerName().isNotEmpty && (Get.find<SplashController>().configModel.companyName != null))?
          Get.offNamed(RouteHelper.getLoginRoute(countryCode: Get.find<AuthController>().getCustomerCountryCode(),phoneNumber: Get.find<AuthController>().getCustomerNumber())) :
          Get.offNamed(RouteHelper.getChoseLoginRegRoute());
        });

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Images.logo, height: 175),
          ],
        ),
      ),
    );
  }
}
