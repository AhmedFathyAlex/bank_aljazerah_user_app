import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/requested_money_controller.dart';
import 'package:six_cash/data/model/response/requested_money_model.dart';
import 'package:six_cash/helper/date_converter.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/animated_custom_dialog.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';

import 'confirmation_dialog.dart';
class RequestedMoneyCard extends StatefulWidget {
  final RequestedMoney requestedMoney;
  final bool isHome;
  final bool isOwn;
  const RequestedMoneyCard({Key key, this.requestedMoney, this.isHome, this.isOwn}) : super(key: key);

  @override
  State<RequestedMoneyCard> createState() => _RequestedMoneyCardState();
}

class _RequestedMoneyCardState extends State<RequestedMoneyCard> {
  final TextEditingController reqPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   // print('own req : ====> ${widget.requestedMoney.receiver.name}');
    String _name;
    String _phoneNumber;
    try{
      if(widget.isOwn) {
        _name = widget.requestedMoney.receiver.name;
        _phoneNumber = widget.requestedMoney.receiver.phone;
      }else{
        _name = widget.requestedMoney.sender.name;
        _phoneNumber = widget.requestedMoney.sender.phone;
      }
    }catch(e){
      _name = 'user_unavailable'.tr;
      _phoneNumber = 'user_unavailable'.tr;
    }
    return !(_name == 'user_unavailable'.tr && _phoneNumber == 'user_unavailable'.tr) ? Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$_name',style: rubikMedium.copyWith(color: ColorResources.getTextColor(),fontSize: Dimensions.FONT_SIZE_LARGE) ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SUPER_EXTRA_SMALL),

                    Text('$_phoneNumber',style: rubikMedium.copyWith(color: ColorResources.getTextColor(),fontSize: Dimensions.FONT_SIZE_SMALL) ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SUPER_EXTRA_SMALL),

                    Text('${'amount'.tr} - ' + PriceConverter.balanceWithSymbol(balance: widget.requestedMoney.amount.toString()),style: rubikMedium.copyWith(color: Theme.of(context).textTheme.titleLarge.color,fontSize: Dimensions.FONT_SIZE_DEFAULT) ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(widget.requestedMoney.createdAt)), style: rubikLight.copyWith(color: ColorResources.getTextColor(),fontSize: Dimensions.FONT_SIZE_SMALL) ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    Row(
                      children: [
                        Text('${'note'.tr} - ', style: rubikSemiBold.copyWith(color: ColorResources.getTextColor(),fontSize: Dimensions.FONT_SIZE_LARGE)),
                        Text(widget.requestedMoney.note ?? 'no_note_available'.tr , maxLines: widget.isHome? 1:10,overflow: TextOverflow.ellipsis,style: rubikLight.copyWith(color: ColorResources.getHintColor(),fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                  ],
                ),
              ]),
              Spacer(),
              widget.requestedMoney.type == AppConstants.PENDING && !widget.isOwn ?
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_LARGE)), color: ColorResources.getAcceptBtn()
                  ),
                  child: CustomInkWell(
                      onTap: (){
                        showAnimatedDialog(context,
                            ConfirmationDialog(
                              passController: reqPasswordController,
                                icon: Images.success_icon,
                                isAccept: true,
                                description: '${'are_you_sure_want_to_accept'.tr} \n ${widget.requestedMoney.sender.name} \n ${widget.requestedMoney.sender.phone}',
                                onYesPressed: () {
                                  Get.find<RequestedMoneyController>().acceptRequest(context, widget.requestedMoney.id, reqPasswordController.text.trim()).then((value) =>  Get.find<RequestedMoneyController>().getRequestedMoneyList(1));
                                }
                            ),
                            dismissible: false,
                            isFlip: true);
                      },
                      radius: Dimensions.RADIUS_SIZE_EXTRA_LARGE,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Text('accept'.tr, style: TextStyle(color: Colors.white)),
                      )),
                ),
                SizedBox(width: 4),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_LARGE)), border: Border.all(width: 1,color: ColorResources.getRedColor())),
                  child: CustomInkWell(
                    onTap: (){
                      showDialog(context: context, builder: (BuildContext context){
                        return ConfirmationDialog(icon: Images.failed_icon,
                            passController: reqPasswordController,
                            description: '${'are_you_sure_want_to_denied'.tr} \n ${widget.requestedMoney.sender.name} \n ${widget.requestedMoney.sender.phone}',
                            onYesPressed: () {
                              Get.find<RequestedMoneyController>().isLoading?
                              Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)):Get.find<RequestedMoneyController>().denyRequest(context, widget.requestedMoney.id,  reqPasswordController.text.trim());
                            }
                        );});
                      Get.find<RequestedMoneyController>().getRequestedMoneyList(1);
                    },
                    radius: Dimensions.RADIUS_SIZE_EXTRA_LARGE,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      child: Text('deny'.tr ,style: TextStyle(color: ColorResources.getRedColor())),
                    ),
                  ),
                ),
              ],):Text(widget.requestedMoney.type, style: rubikRegular.copyWith(color: ColorResources.getAcceptBtn()),)
            ],
          ),
          SizedBox(height: 5),
          widget.isHome ? SizedBox() : Divider(height: .5,color: ColorResources.getGreyColor()),
        ],
      ),
    ) : SizedBox();
  }
}
