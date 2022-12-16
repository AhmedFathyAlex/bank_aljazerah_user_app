import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_image.dart';
import 'package:six_cash/view/base/contact_view.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_country_code_picker.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/transaction_money/widget/scan_button.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';

import '../auth/selfie_capture/camera_screen.dart';

class TransactionMoneyScreen extends StatefulWidget {
  final bool fromEdit;
  final String phoneNumber;
  final String transactionType;
  TransactionMoneyScreen({Key key, this.fromEdit, this.phoneNumber, this.transactionType}) : super(key: key);

  @override
  State<TransactionMoneyScreen> createState() => _TransactionMoneyScreenState();
}

class _TransactionMoneyScreenState extends State<TransactionMoneyScreen> {
  String customerImageBaseUrl = Get.find<SplashController>().configModel.baseUrls.customerImageUrl;

  String agentImageBaseUrl = Get.find<SplashController>().configModel.baseUrls.agentImageUrl;
  ScrollController _scrollController = ScrollController();
  String _countryCode = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countryCode = Get.find<AuthController>().getCustomerCountryCode();
    Get.find<TransactionMoneyController>().getSuggestList(type: widget.transactionType);
  }

  @override
  Widget build(BuildContext context) {
     final TextEditingController _searchController = TextEditingController();
     widget.fromEdit? _searchController.text = widget.phoneNumber: SizedBox();
     final transactionMoneyController = Get.find<TransactionMoneyController>();

    return Scaffold(
      appBar:  CustomAppbar(title: widget.transactionType.tr),

      body: CustomScrollView(
         controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverDelegate(
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT), color: ColorResources.getGreyBaseGray3(),
                    child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (inputText) => transactionMoneyController.searchContact(
                                searchTerm: inputText.toLowerCase(),
                              ),
                              keyboardType: widget.transactionType == TransactionType.CASH_OUT
                                  ? TextInputType.phone : TextInputType.name,
                              decoration: InputDecoration(
                                border: InputBorder.none, contentPadding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                                hintText: widget.transactionType == TransactionType.CASH_OUT
                                    ? 'enter_agent_number'.tr : 'enter_name_or_number'.tr,
                                hintStyle: rubikRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  color: ColorResources.getGreyBaseGray1(),
                                ),
                                prefixIcon: CustomCountryCodePiker(
                                  onInit: (code) => _countryCode = code.toString(),
                                  onChanged: (code) => _countryCode = code.toString(),
                                ),
                              ),
                            ),),

                          Icon(Icons.search, color: ColorResources.getGreyBaseGray1()),
                        ]),
                  ),
                  Divider(height: Dimensions.DIVIDER_SIZE_SMALL, color: Theme.of(context).backgroundColor),

                  Container(
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ScanButton(onTap: ()=> Get.to(()=> CameraScreen(
                            fromEditProfile: false,
                            isBarCodeScan: true,
                            transactionType: widget.transactionType,
                          ))),

                          InkWell(
                            onTap: () {
                              if(_searchController.text.isEmpty){
                                showCustomSnackBar('input_field_is_empty'.tr,isError: true);
                              }else {
                                String phoneNumber = _countryCode + _searchController.text.trim();
                                if (widget.transactionType == "cash_out") {
                                  Get.find<TransactionMoneyController>().checkAgentNumber(phoneNumber: phoneNumber).then((value) {
                                    if (value.isOk) {
                                      String _agentName = value.body['data']['name'];
                                      String _agentImage = value.body['data']['image'];
                                      Get.to(() => TransactionMoneyBalanceInput(transactionType: widget.transactionType,
                                          contactModel: ContactModel(
                                              phoneNumber: _countryCode + _searchController.text,
                                              name: _agentName,
                                              avatarImage: _agentImage))
                                      );
                                    }
                                  });
                                } else {
                                  Get.find<TransactionMoneyController>().checkCustomerNumber(phoneNumber: phoneNumber).then((value) {
                                    if (value.isOk) {
                                      String _customerName = value.body['data']['name'];
                                      String _customerImage = value.body['data']['image'];
                                      Get.to(() =>  TransactionMoneyBalanceInput(
                                          transactionType: widget.transactionType,
                                          contactModel: ContactModel(
                                              phoneNumber: _countryCode + _searchController.text,
                                              name: _customerName,
                                              avatarImage: _customerImage))
                                      );
                                    }
                                  });
                                }
                              }

                            },

                            child: GetBuilder<TransactionMoneyController>(
                                builder: (checkController) {
                                  return checkController.isButtonClick ? SizedBox(
                                      width: Dimensions.RADIUS_SIZE_OVER_LARGE,height:  Dimensions.RADIUS_SIZE_OVER_LARGE,
                                      child: Center(child: CircularProgressIndicator(color: Theme.of(context).textTheme.titleLarge.color)))
                                      : Container(width: Dimensions.RADIUS_SIZE_OVER_LARGE,height:  Dimensions.RADIUS_SIZE_OVER_LARGE,
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).secondaryHeaderColor),
                                      child: Icon(Icons.arrow_forward, color: ColorResources.blackColor));
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
                )
            ),
          ),

          SliverToBoxAdapter(
            child: Column( children: [
              transactionMoneyController.sendMoneySuggestList.isNotEmpty &&  widget.transactionType == 'send_money'?
              GetBuilder<TransactionMoneyController>(builder: (sendMoneyController) {
                return  Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_LARGE),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                        child: Text('suggested'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                      ),
                      Container(height: 80.0,
                        child: ListView.builder(itemCount: sendMoneyController.sendMoneySuggestList.length, scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index)=> CustomInkWell(
                              radius : Dimensions.RADIUS_SIZE_VERY_SMALL,
                              highlightColor: Theme.of(context).textTheme.titleLarge.color.withOpacity(0.3),
                              onTap: () {
                                sendMoneyController.suggestOnTap(index, widget.transactionType);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                                child: Column(children: [
                                  SizedBox(
                                    height: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,width:Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,
                                    child: ClipRRect(
                                      child: CustomImage(
                                        fit: BoxFit.cover,
                                        image: "$customerImageBaseUrl/${sendMoneyController.sendMoneySuggestList[index].avatarImage.toString()}",
                                        placeholder: Images.avatar,
                                      ),
                                     borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_OVER_LARGE),
                                    ),
                                  ), Padding(padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                                    child: Text(sendMoneyController.sendMoneySuggestList[index].name == null ? sendMoneyController.sendMoneySuggestList[index].phoneNumber : sendMoneyController.sendMoneySuggestList[index].name ,
                                        style: sendMoneyController.sendMoneySuggestList[index].name == null ? rubikLight.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL) : rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                                  )
                                ],
                                ),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                );
              }
              ) :
              ((transactionMoneyController.requestMoneySuggestList.isNotEmpty) && widget.transactionType == 'request_money') ?
              GetBuilder<TransactionMoneyController>(builder: (requestMoneyController) {
                return requestMoneyController.isLoading ? Center(child: CircularProgressIndicator()) : Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_LARGE),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                        child: Text('suggested'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                      ),
                      Container(height: 80.0,
                        child: ListView.builder(itemCount: requestMoneyController.requestMoneySuggestList.length, scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index)=> CustomInkWell(
                              radius : Dimensions.RADIUS_SIZE_VERY_SMALL,
                              highlightColor: Theme.of(context).textTheme.titleLarge.color.withOpacity(0.3),
                              onTap: () {
                                requestMoneyController.suggestOnTap(index, widget.transactionType);
                                },
                              child: Container(
                                margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                                child: Column(children: [
                                  SizedBox(
                                    height: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,width:Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,
                                    child: ClipRRect(
                                      child: CustomImage(image: "$customerImageBaseUrl/${requestMoneyController.requestMoneySuggestList[index].avatarImage.toString()}",
                                        fit: BoxFit.cover, placeholder: Images.avatar), borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_OVER_LARGE),
                                    ),
                                  ),

                                  Padding(padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                                    child: Text(requestMoneyController.requestMoneySuggestList[index].name == null ? requestMoneyController.requestMoneySuggestList[index].phoneNumber : requestMoneyController.requestMoneySuggestList[index].name ,
                                        style: requestMoneyController.requestMoneySuggestList[index].name == null ? rubikLight.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE) : rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                                  )
                                ],
                                ),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                );
              }
              ) :
              ((transactionMoneyController.cashOutSuggestList.isNotEmpty) && widget.transactionType == TransactionType.CASH_OUT)?
              GetBuilder<TransactionMoneyController>(builder: (cashOutController) {
                return cashOutController.isLoading ? Center(child: CircularProgressIndicator()) : Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_LARGE),
                      child: Text('recent_agent'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                    ),
                    ListView.builder(
                        itemCount: cashOutController.cashOutSuggestList.length, scrollDirection: Axis.vertical, shrinkWrap:true,physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index)=> CustomInkWell(
                          highlightColor: Theme.of(context).textTheme.titleLarge.color.withOpacity(0.3),
                          onTap: () => cashOutController.suggestOnTap(index, widget.transactionType),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              SizedBox(
                                height: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,width:Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,
                                child: ClipRRect(
                                  child: CustomImage(
                                    fit: BoxFit.cover,
                                    image: "$agentImageBaseUrl/${
                                        cashOutController.cashOutSuggestList[index].avatarImage.toString()}",
                                    placeholder: Images.avatar,
                                  ),
                                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_OVER_LARGE),
                                ),
                              ),
                              SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cashOutController.cashOutSuggestList[index].name == null ?'Unknown':cashOutController.cashOutSuggestList[index].name,style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,color: Theme.of(context).textTheme.bodyText1.color)),
                                  Text(cashOutController.cashOutSuggestList[index].phoneNumber != null ? cashOutController.cashOutSuggestList[index].phoneNumber : 'No Number',style: rubikLight.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,color: ColorResources.getGreyBaseGray1()),),
                                ],
                              )
                            ],
                            ),
                          ),
                        )

                    ),
                  ],
                );
              }
              ) : SizedBox(),

               if(widget.transactionType != AppConstants.CASH_OUT)
                GetBuilder<TransactionMoneyController>(
                  builder: (contactController) {
                    return ConstrainedBox(
                      constraints: contactController.filterdContacts.length > 0 ?
                      BoxConstraints(maxHeight: Get.find<TransactionMoneyController>().filterdContacts.length.toDouble() * 100) :
                      BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
                        child: ContactView(transactionType: widget.transactionType, contactController: contactController));
                  }
                ),
              ],),

          ),
        ],
      ),
    );
  }
}



class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 120 || oldDelegate.minExtent != 120 || child != oldDelegate.child;
  }
}
