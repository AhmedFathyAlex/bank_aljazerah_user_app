import 'package:six_cash/controller/transaction_history_controller.dart';
import 'package:six_cash/data/model/transaction_model.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/base/appbar_home_element.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/screens/history/widget/transaction_view_screen.dart';

class HistoryScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final Transactions transactions;
  HistoryScreen({Key key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<TransactionHistoryController>().setIndex(0);
    return Scaffold(
      appBar: AppbarHomeElement(title: 'history'.tr),
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Get.find<TransactionHistoryController>().getTransactionData(1,reload: true);
            return true;
          },
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            slivers: [

              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                      child: Container(padding: EdgeInsets.symmetric( vertical: Dimensions.PADDING_SIZE_SMALL), height: 50, alignment: Alignment.centerLeft,
                        child: GetBuilder<TransactionHistoryController>(
                          builder: (historyController){
                            return ListView(
                              shrinkWrap: true,
                                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  TransactionTypeButton(text: 'all'.tr, index: 0, transactionHistoryList : historyController.transactionList),
                                  SizedBox(width: 10),

                                  TransactionTypeButton(text: 'send_money'.tr, index: 1, transactionHistoryList: historyController.sendMoneyList),
                                  SizedBox(width: 10),

                                  TransactionTypeButton(text: 'cash_in'.tr, index: 2, transactionHistoryList: historyController.cashInMoneyList),
                                  SizedBox(width: 10),

                                  TransactionTypeButton(text: 'add_money'.tr, index: 3, transactionHistoryList: historyController.addMoneyList),
                                  SizedBox(width: 10),

                                  TransactionTypeButton(text: 'received_money'.tr, index: 4, transactionHistoryList: historyController.receivedMoneyList),
                                  SizedBox(width: 10),

                                  TransactionTypeButton(text: 'cash_out'.tr, index: 5, transactionHistoryList: historyController.cashOutList),

                                ]);
                          },

                        ),
                      ))),
              SliverToBoxAdapter(
                child: Scrollbar(
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: TransactionViewScreen(scrollController: _scrollController,isHome: false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionTypeButton extends StatelessWidget {
  final String text;
  final int index;
  final List<Transactions> transactionHistoryList;

  TransactionTypeButton({@required this.text, @required this.index, @required this.transactionHistoryList});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Get.find<TransactionHistoryController>().transactionTypeIndex == index ? Theme.of(context).secondaryHeaderColor :  Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_LARGE),
          border: Border.all(width: .5,color: ColorResources.getGreyColor())
      ),
      child: CustomInkWell(
        onTap: () => Get.find<TransactionHistoryController>().setIndex(index),
        radius: Dimensions.RADIUS_SIZE_LARGE,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Text(text,
              style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,color: Get.find<TransactionHistoryController>().transactionTypeIndex == index
                  ? ColorResources.blackColor : Theme.of(context).textTheme.titleLarge.color)),
        ),
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
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}