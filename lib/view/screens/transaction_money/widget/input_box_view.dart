import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/localization_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/data/model/purpose_models.dart';
import 'package:six_cash/helper/currency_text_input_formatter.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_image.dart';
import 'package:six_cash/view/base/input_field_shimmer.dart';

class InputBoxView extends StatelessWidget {
  final TextEditingController inputAmountController;
  final FocusNode focusNode;
  final String transactionType;

  const InputBoxView({
    Key key,
    @required this.inputAmountController, this.focusNode, this.transactionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionMoneyController>(
        builder: (transactionMoneyController) {
          return  transactionMoneyController.isLoading ?
          InputFieldShimmer() :  Column(children: [
            Stack(children: [

              Container(color: Theme.of(context).cardColor,
                child: Column(
                  children: [ Container( width: context.width * 0.6,
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE),
                    child: TextField(inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(
                        Get.find<SplashController>().configModel.currencyPosition == 'left' ?
                        AppConstants.BALANCE_INPUT_LEN + (AppConstants.BALANCE_INPUT_LEN / 3).floor(
                        ) + Get.find<SplashController>().configModel.currencySymbol.length :

                        AppConstants.BALANCE_INPUT_LEN + (AppConstants.BALANCE_INPUT_LEN / 3).ceil(
                        ) + Get.find<SplashController>().configModel.currencySymbol.length,

                      ),

                      CurrencyTextInputFormatter(
                        decimalDigits: 0,
                        locale: Get.find<SplashController>().configModel.currencyPosition == 'left' ? 'en' : 'fr',
                        symbol:'${Get.find<SplashController>().configModel.currencySymbol}',
                      ),
                    ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: inputAmountController,
                      focusNode: focusNode,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      style: rubikMedium.copyWith(fontSize: 34, color: Theme.of(context).textTheme.titleLarge.color),
                      decoration: InputDecoration(
                        isCollapsed : true,
                        hintText:'${PriceConverter.balanceInputHint()}',
                        border : InputBorder.none, focusedBorder: UnderlineInputBorder(),
                        hintStyle: rubikMedium.copyWith(
                          fontSize: 34, color: Theme.of(context).textTheme.titleLarge.color.withOpacity(0.7),
                        ),

                      ),

                    ),
                  ),

                    Center( child: GetBuilder<ProfileController>(
                      builder: (profController)=> profController.isLoading ? Center(
                        child: CircularProgressIndicator(color: Theme.of(context).textTheme.titleLarge.color),
                      ) :
                      Text(
                        '${'available_balance'.tr} ${PriceConverter.availableBalance()}',
                        style: rubikRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.3),
                        ),
                      ),
                    ),),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),


                  ],
                ),
              ),

              if(transactionType == TransactionType.SEND_MONEY) Positioned(
                left: Get.find<LocalizationController>().isLtr ? Dimensions.PADDING_SIZE_LARGE : null,
                bottom: Get.find<LocalizationController>().isLtr ? Dimensions.PADDING_SIZE_EXTRA_LARGE : null,
                right:  Get.find<LocalizationController>().isLtr ? null : Dimensions.PADDING_SIZE_LARGE,
                child: CustomImage(
                  image:'${Get.find<SplashController>().configModel.baseUrls.purposeImageUrl
                  }/${transactionMoneyController.purposeList.isEmpty ? Purpose().logo :
                  transactionMoneyController.purposeList[transactionMoneyController.selectedItem].logo}',
                  height: 50, width: 50, fit: BoxFit.cover,
                  placeholder: Images.sendMoney_logo,
                ),
              ),

            ],),

            Container(
              height: Dimensions.DIVIDER_SIZE_MEDIUM,
              color: Theme.of(context).dividerColor,
            ),
          ],
          );
        }
    );
  }
}
