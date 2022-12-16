import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/screens/home/widget/banner_view.dart';
import 'package:six_cash/view/screens/home/widget/custom_card.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_screen.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';

class FirstCardPortion extends StatelessWidget {
  const FirstCardPortion({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            height: Dimensions.MAIN_BACKGROUND_CARD_WEIGHT,
            color: Theme.of(context).primaryColor,
          ),
          Positioned(
            child: Column(
              children: [
                Container(
                  width: double.infinity, height: Dimensions.ADD_MONEY_CARD,
                  margin: const  EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE,
                    vertical: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_LARGE),
                    color: Theme.of(context).cardColor,
                  ),


                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE,
                        ),

                        child: GetBuilder<ProfileController>(
                          builder: (profileController) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'your_balance'.tr, style: rubikLight.copyWith(
                                  color: ColorResources.getBalanceTextColor(),
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                ),),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                                profileController.userInfo !=  null ?
                                Text(
                                  PriceConverter.balanceWithSymbol(balance: profileController.userInfo.balance.toString()),
                                  style: rubikMedium.copyWith(
                                    color: Theme.of(context).textTheme.titleLarge.color,
                                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                 ),
                                ) :
                                Text(
                                  PriceConverter.convertPrice(0.00),
                                  style: rubikMedium.copyWith(
                                    color: Theme.of(context).textTheme.titleLarge.color,
                                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                  ),
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: Dimensions.ADD_MONEY_CARD,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_LARGE),
                          color: Theme.of(context).secondaryHeaderColor,
                        ),


                        child: CustomInkWell(
                          onTap: () => Get.to(TransactionMoneyBalanceInput(transactionType: 'add_money')),
                          radius: Dimensions.RADIUS_SIZE_LARGE,
                          child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                SizedBox(height: 34, child: Image.asset(Images.wolet_logo)),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                                Text(
                                  'add_money'.tr, style: rubikRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  color: Theme.of(context).textTheme.bodyText1.color,
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Cards...
                SizedBox(
                  height: Dimensions.TRANSACTION_TYPE_CARD_HEIGHT,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.FONT_SIZE_EXTRA_SMALL),
                    child: Row(
                      children: [
                        Expanded(child: CustomCard(
                          image: Images.sendMoney_logo, text: 'send_money'.tr.replaceAll(' ', '\n'),
                          color: Theme.of(context).secondaryHeaderColor,
                          onTap: ()=> Get.to(()=> TransactionMoneyScreen(
                            fromEdit: false,
                            transactionType: TransactionType.SEND_MONEY,
                          )),
                        )),

                        Expanded(child: CustomCard(
                          image: Images.cashOut_logo, text: 'cash_out'.tr.replaceAll(' ', '\n'),
                          color: ColorResources.getCashOutCardColor(),
                          onTap: ()=> Get.to(()=> TransactionMoneyScreen(
                            fromEdit: false,
                            transactionType: TransactionType.CASH_OUT,
                          )),
                        )),

                        Expanded(child: CustomCard(
                          image: Images.requestMoneyLogo, text: 'request_money'.tr,
                          color: ColorResources.getRequestMoneyCardColor(),
                          onTap: ()=> Get.to(()=> TransactionMoneyScreen(
                            fromEdit: false,
                            transactionType: TransactionType.REQUEST_MONEY,
                          )),
                        )),

                        Expanded(child: CustomCard(
                          image: Images.request_list_image2,
                          text: 'requests'.tr,
                          color: ColorResources.getReferFriendCardColor(),
                          onTap: () => Get.toNamed(RouteHelper.getRequestedMoneyRoute(from: 'other')),
                        ),
                        ),
                      ],
                    ),
                  ),
                ),



                BannerView(),

              ],
            ),
          ),
        ],
      ),
    );
  }

}
