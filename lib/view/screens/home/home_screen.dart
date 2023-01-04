import 'dart:developer';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/banner_controller.dart';
import 'package:six_cash/controller/home_controller.dart';
import 'package:six_cash/controller/notification_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/requested_money_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/controller/transaction_history_controller.dart';
import 'package:six_cash/controller/websitelink_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/screens/home/widget/app_bar_base.dart';
import 'package:six_cash/view/screens/home/widget/bottom_sheet/expandable_contant.dart';
import 'package:six_cash/view/screens/home/widget/bottom_sheet/persistent_header.dart';
import 'package:six_cash/view/screens/home/widget/first_card_portion.dart';
import 'package:six_cash/view/screens/home/widget/linked_website.dart';
import 'package:six_cash/view/screens/home/widget/secend_card_portion.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/web_site_shimmer.dart';
import 'package:six_cash/view/screens/home/widget/third_card_portion.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../util/color_resources.dart';
import '../../../util/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController tabController;

  bool isFirst = true;
  Future<void> _loadData(BuildContext context, bool reload) async {
    Get.find<ProfileController>().profileData(reload: reload);
    Get.find<BannerController>().getBannerList(reload);
    Get.find<RequestedMoneyController>()
        .getRequestedMoneyList(1, reload: reload);
    Get.find<RequestedMoneyController>()
        .getOwnRequestedMoneyList(1, reload: reload);
    Get.find<TransactionHistoryController>()
        .getTransactionData(1, reload: reload);
    Get.find<WebsiteLinkController>().getWebsiteList();
    Get.find<NotificationController>().getNotificationList();
    Get.find<TransactionMoneyController>().getPurposeList();
    Get.find<TransactionMoneyController>().fetchContact();
    Get.find<TransactionMoneyController>().getWithdrawMethods(isReload: reload);
  }

  @override
  void initState() {
    super.initState();
    _loadData(context, false);
    isFirst = false;
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  getCurrency() async {
    final response = await http.get(
      Uri.parse(
          'https://api.apilayer.com/currency_data/live?base=SYP&symbols=EUR,GBPchange?start_date=2023-01-03&end_date=2023-01-04'),
      // Send authorization headers to the backend.
      headers: {
        "apikey": "EaSpwAxiXftsCpyLq9kwSG1CsAida1a8",
      },
    );
    log(response.body.toString());
  }

  @override
  Widget build(BuildContext context) {
    getCurrency();

    log('home');
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        appBar: AppBarBase(),
        body: ExpandableBottomSheet(
            enableToggle: true,
            background: RefreshIndicator(
              onRefresh: () async {
                await _loadData(context, true);
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child:
                    GetBuilder<SplashController>(builder: (splashController) {
                  return Column(
                    children: [
                      splashController.configModel.themeIndex == '1'
                          ? GetBuilder<ProfileController>(
                              builder: (profile) => FirstCardPortion())
                          : splashController.configModel.themeIndex == '2'
                              ? SecondCardPortion()
                              : splashController.configModel.themeIndex == '3'
                                  ? ThirdCardPortion()
                                  : GetBuilder<ProfileController>(
                                      builder: (profile) => FirstCardPortion()),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      GetBuilder<WebsiteLinkController>(
                          builder: (websiteLinkController) {
                        return websiteLinkController.isLoading
                            ? WebSiteShimmer()
                            : websiteLinkController.websiteList.length > 0
                                ? LinkedWebsite()
                                : SizedBox();
                      }),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'تحويل العملة',
                            style: rubikLight.copyWith(
                              color: ColorResources.getBalanceTextColor(),
                              fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'السعر مقابل الليرة السورية',
                            style: rubikLight.copyWith(
                              color: ColorResources.getBalanceTextColor(),
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            TabBar(
                              indicatorColor: ColorResources.getPrimaryColor(),
                              controller: tabController,
                              tabs: [
                                Text(
                                  'دولار',
                                  style: rubikLight.copyWith(
                                    color: ColorResources.getBalanceTextColor(),
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                                Text(
                                  'يورو',
                                  style: rubikLight.copyWith(
                                    color: ColorResources.getBalanceTextColor(),
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                                Text(
                                  'جنيه استرليني',
                                  style: rubikLight.copyWith(
                                    color: ColorResources.getBalanceTextColor(),
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'ريال سعودي',
                                  style: rubikLight.copyWith(
                                    color: ColorResources.getBalanceTextColor(),
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 70,
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  ConvertCurrency(
                                    buyPrice: '2512.40',
                                    sellPrice: '2412.65',
                                  ),
                                  ConvertCurrency(
                                    buyPrice: '2,650.16 ',
                                    sellPrice: '2612.65',
                                  ),
                                  ConvertCurrency(
                                    buyPrice: '3,007.06',
                                    sellPrice: '2995.64',
                                  ),
                                  ConvertCurrency(
                                    buyPrice: '669.87',
                                    sellPrice: '629.52',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 200),
                    ],
                  );
                }),
              ),
            ),
            persistentContentHeight: 70,
            persistentHeader: CustomPersistentHeader(),
            expandableContent: CustomExpandableContant()),
      );
    });
  }
}

class ConvertCurrency extends StatelessWidget {
  final buyPrice;
  final sellPrice;
  const ConvertCurrency({
    Key key,
    this.buyPrice,
    this.sellPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, top: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'سعر الشراء',
              style: rubikLight.copyWith(
                color: ColorResources.getBalanceTextColor(),
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              ),
            ),
            Text(
              buyPrice,
              style: rubikLight.copyWith(
                color: ColorResources.getBalanceTextColor(),
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              ),
            ),
          ],
        ),
        VerticalDivider(
          color: Colors.grey,
          thickness: 2,
        ),
        Column(
          children: [
            Text(
              'سعر البيع',
              style: rubikLight.copyWith(
                color: ColorResources.getBalanceTextColor(),
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              ),
            ),
            Text(
              sellPrice,
              style: rubikLight.copyWith(
                color: ColorResources.getBalanceTextColor(),
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
