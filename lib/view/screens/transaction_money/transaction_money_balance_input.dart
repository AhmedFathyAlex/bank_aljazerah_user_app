import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/add_money_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/data/model/purpose_models.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/data/model/withdraw_model.dart';
import 'package:six_cash/helper/email_checker.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_loader.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_confirmation.dart';
import 'package:six_cash/view/screens/transaction_money/widget/input_box_view.dart';
import 'package:six_cash/view/screens/transaction_money/widget/purpose_widget.dart';
import 'widget/field_item_view.dart';
import 'widget/for_person_widget.dart';
import 'widget/next_button.dart';

class TransactionMoneyBalanceInput extends StatefulWidget {
  final String transactionType;
  final ContactModel contactModel;
   TransactionMoneyBalanceInput({Key key, this.transactionType ,this.contactModel}) : super(key: key);
  @override
  State<TransactionMoneyBalanceInput> createState() => _TransactionMoneyBalanceInputState();
}

class _TransactionMoneyBalanceInputState extends State<TransactionMoneyBalanceInput> {
  final TextEditingController _inputAmountController = TextEditingController();
  String _selectedMethodId;
  List<MethodField> _fieldList;
  List<MethodField> _gridFieldList;
  Map<String, TextEditingController> _textControllers =  Map();
  Map<String, TextEditingController> _gridTextController =  Map();
  final FocusNode _inputAmountFocusNode = FocusNode();

  void setFocus() {
    _inputAmountFocusNode.requestFocus();
    Get.back();
  }

  @override
  void initState() {
    super.initState();
    if(widget.transactionType == TransactionType.WITHDRAW_REQUEST) {
      Get.find<TransactionMoneyController>().getWithdrawMethods();
    }
  }
 
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final SplashController splashController = Get.find<SplashController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: CustomAppbar(title: widget.transactionType.tr),

          body: GetBuilder<TransactionMoneyController>(
              builder: (transactionMoneyController) {
                if(widget.transactionType == TransactionType.WITHDRAW_REQUEST &&
                    transactionMoneyController.withdrawModel == null) {
                  return CustomLoader(color: Theme.of(context).primaryColor);
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(widget.transactionType != TransactionType.ADD_MONEY &&
                          widget.transactionType != TransactionType.WITHDRAW_REQUEST)
                        ForPersonWidget(contactModel: widget.contactModel),


                      if(widget.transactionType == TransactionType.WITHDRAW_REQUEST)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_DEFAULT,
                            horizontal: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          child: Column(children: [
                            Container(
                              height: context.height * 0.05,
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
                                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.4)),
                              ),

                              child: DropdownButton<String>(
                                menuMaxHeight: Get.height * 0.5,
                                hint: Text(
                                  'select_a_method'.tr,
                                  style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                value: _selectedMethodId,
                                items: transactionMoneyController.withdrawModel.withdrawalMethods.map((withdraw) =>
                                    DropdownMenuItem<String>(
                                      value: withdraw.id.toString(),
                                      child: Text(
                                        withdraw.methodName ?? 'no method',
                                        style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                      ),
                                    )
                                ).toList(),

                                onChanged: (id) {
                                  _selectedMethodId = id;
                                  _gridFieldList = [];
                                  _fieldList = [];

                                  transactionMoneyController.withdrawModel.withdrawalMethods.firstWhere((_method) =>
                                  _method.id.toString() == id).methodFields.forEach((_method) {
                                    _gridFieldList.addIf(_method.inputName.contains('cvv') || _method.inputType == 'date', _method);
                                  });


                                  transactionMoneyController.withdrawModel.withdrawalMethods.firstWhere((_method) =>
                                  _method.id.toString() == id).methodFields.forEach((_method) {
                                    _fieldList.addIf(!_method.inputName.contains('cvv') && _method.inputType != 'date', _method);
                                  });

                                  _textControllers = _textControllers =  Map();
                                  _gridTextController = _gridTextController =  Map();

                                  _fieldList.forEach((_method) => _textControllers[_method.inputName] = TextEditingController());
                                  _gridFieldList.forEach((_method) => _gridTextController[_method.inputName] = TextEditingController());

                                  transactionMoneyController.update();
                                },

                                isExpanded: true,
                                underline: SizedBox(),
                              ),
                            ),

                            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                            if(_fieldList != null && _fieldList.isNotEmpty) ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _fieldList.length,
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: 10,
                              ),

                              itemBuilder: (context, index) => FieldItemView(
                                methodField:_fieldList[index],
                                textControllers: _textControllers,
                              ),
                            ),

                            if(_gridFieldList != null && _gridFieldList.isNotEmpty)

                              GridView.builder(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: 10,
                                ),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: _gridFieldList.length,

                                itemBuilder: (context, index) => FieldItemView(
                                  methodField: _gridFieldList[index],
                                  textControllers: _gridTextController,
                                ),
                              ),

                          ],),
                        ),

                      InputBoxView(
                        inputAmountController: _inputAmountController,
                        focusNode: _inputAmountFocusNode,
                        transactionType: widget.transactionType,
                      ),


                      if(widget.transactionType == TransactionType.CASH_OUT)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_LARGE,
                            vertical:Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          child: Row( children: [
                            Text(
                              'save_future_cash_out'.tr,
                              style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                            ),
                            Spacer(),

                            Padding(
                              padding: EdgeInsets.zero,
                              child: CupertinoSwitch(
                                value: transactionMoneyController.isFutureSave,
                                onChanged: transactionMoneyController.cupertinoSwitchOnChange,
                              ),
                            ),

                          ],),
                        ),




                      widget.transactionType == TransactionType.SEND_MONEY &&
                          transactionMoneyController.purposeList.isNotEmpty ?
                      MediaQuery.of(context).viewInsets.bottom > 10 ?
                      Container(
                        color: Colors.white.withOpacity(0.92),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE,
                          vertical: Dimensions.PADDING_SIZE_SMALL,
                        ),
                        child: Row(children: [

                          transactionMoneyController.purposeList.isEmpty ?
                          Center(child: CircularProgressIndicator(
                            color: Theme.of(context).textTheme.titleLarge.color,
                          )) : SizedBox(),

                          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                          Text('change_purpose'.tr, style: rubikRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                          ))
                        ],),
                      ): PurposeWidget(): SizedBox(),

                    ],
                  ),
                );
              }
          ),

          floatingActionButton: GetBuilder<TransactionMoneyController>(
              builder: (transactionMoneyController) {
                return  FloatingActionButton(

                  onPressed:() {
                    double amount;
                    if(_inputAmountController.text.isEmpty){
                      showCustomSnackBar('please_input_amount'.tr,isError: true);
                    }else{
                      String balance =  _inputAmountController.text;
                      if(balance.contains('${splashController.configModel.currencySymbol}')) {
                        balance = balance.replaceAll('${splashController.configModel.currencySymbol}', '');
                      }
                      if(balance.contains(',')){
                        balance = balance.replaceAll(',', '');
                      }
                      if(balance.contains(' ')){
                        balance = balance.replaceAll(' ', '');
                      }
                      amount = double.parse(balance);
                      if(amount == 0) {
                        showCustomSnackBar('transaction_amount_must_be'.tr,isError: true);
                      }else {
                        final bool _inSufficientBalance = widget.transactionType != TransactionType.REQUEST_MONEY
                            && widget.transactionType != TransactionType.ADD_MONEY &&
                            PriceConverter.withSendMoneyCharge(amount) > profileController.userInfo.balance;

                        if(_inSufficientBalance) {
                          showCustomSnackBar('insufficient_balance'.tr, isError: true);

                        }else {
                          if(widget.transactionType == 'add_money'){
                            Get.find<AddMoneyController>().addMoney(context, amount.toString());
                          }
                          else if(widget.transactionType == TransactionType.WITHDRAW_REQUEST) {

                            String _message;
                            WithdrawalMethod _withdrawMethod = transactionMoneyController.withdrawModel.withdrawalMethods.
                            firstWhere((_method) => _selectedMethodId == _method.id.toString());

                            List<MethodField> _list = [];
                            String _validationKey;

                            _withdrawMethod.methodFields.forEach((_method) {
                              if(_method.inputType == 'email') {
                                _validationKey  = _method.inputName;
                              }
                              if(_method.inputType == 'date') {
                                _validationKey  = _method.inputName;
                              }

                            });


                            _textControllers.forEach((key, textController) {
                              _list.add(MethodField(
                                inputName: key, inputType: null,
                                inputValue: textController.text,
                                placeHolder: null,
                              ));

                              if((_validationKey == key) && EmailChecker.isNotValid(textController.text)) {
                                print('mail is : ${textController.text}');
                                _message = 'please_provide_valid_email'.tr;
                              }else if((_validationKey == key) && textController.text.contains('-')) {
                                _message = 'please_provide_valid_date'.tr;
                              }

                              if(textController.text.isEmpty && _message == null) {
                                _message = 'please fill ${key.replaceAll('_', ' ')} field';
                              }
                            });

                            _gridTextController.forEach((key, textController) {
                              _list.add(MethodField(
                                inputName: key, inputType: null,
                                inputValue: textController.text,
                                placeHolder: null,
                              ));

                              if((_validationKey == key) && textController.text.contains('-')) {
                                _message = 'please_provide_valid_date'.tr;
                              }
                            });

                            if(_message != null) {
                              showCustomSnackBar(_message);
                              _message = null;

                            }
                            else{


                              Get.to(() => TransactionMoneyConfirmation(
                                inputBalance: amount,
                                transactionType: TransactionType.WITHDRAW_REQUEST,
                                contactModel: null,
                                withdrawMethod: WithdrawalMethod(
                                  methodFields: _list,
                                  methodName: _withdrawMethod.methodName,
                                  id: _withdrawMethod.id,
                                ),
                                callBack: setFocus,
                              ));
                            }

                          }

                          else{
                            Get.to(()=> TransactionMoneyConfirmation(
                              inputBalance: amount,
                              transactionType:widget.transactionType,
                              purpose: transactionMoneyController.purposeList.isEmpty
                                  ? Purpose().title : transactionMoneyController.purposeList[transactionMoneyController.selectedItem].title,
                              contactModel: widget.contactModel,
                              callBack: setFocus,

                            ));
                          }
                        }
                      }

                    }
                  },
                  child: NextButton(isSubmittable: true),
                  backgroundColor: Theme.of(context).secondaryHeaderColor,
                );
              }
          )

      ),
    );
  }
}




