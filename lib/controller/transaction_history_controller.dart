import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/model/transaction_model.dart';
import 'package:six_cash/data/repository/transaction_history_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/app_constants.dart';

class TransactionHistoryController extends GetxController implements GetxService{
  final TransactionHistoryRepo transactionHistoryRepo;
  TransactionHistoryController({@required this.transactionHistoryRepo});


  bool _isSearching = false;
  int _pageSize;
  bool _isLoading = false;
  bool _firstLoading = true;
  bool get firstLoading => _firstLoading;
  int _offset = 1;
  int get offset =>_offset;

  List<int> _offsetList = [];
  List<int> get offsetList => _offsetList;

  List<Transactions> _transactionList  = [];
  List<Transactions> get transactionList => _transactionList;

  List<Transactions> _sendMoneyList = [];
  List<Transactions> get sendMoneyList => _sendMoneyList;

  List<Transactions> _cashInMoneyList = [];
  List<Transactions> get cashInMoneyList => _cashInMoneyList;

  List<Transactions> _addMoneyList = [];
  List<Transactions> get addMoneyList => _addMoneyList;

  List<Transactions> _receivedMoneyList = [];
  List<Transactions> get receivedMoneyList => _receivedMoneyList;

  List<Transactions> _cashOutList = [];
  List<Transactions> get cashOutList => _cashOutList;



  bool get isSearching => _isSearching;
  int get pageSize => _pageSize;
  bool get isLoading => _isLoading;
  ScrollController scrollController = ScrollController();
  bool isMoreDataAvailable = true;

  void showBottomLoader() {
    _isLoading = true;
    update();
  }


  Future getTransactionData(int offset, {bool reload = false}) async{
    if(reload) {
      _offsetList = [];
      _transactionList = [];
      _sendMoneyList = [];
      _cashInMoneyList = [];
      _addMoneyList = [];
      _receivedMoneyList =[];
      _cashOutList = [];
    }
    _offset = offset;
    if(!_offsetList.contains(offset)) {
      _offsetList.add(offset);

      Response response = await transactionHistoryRepo.getTransactionHistory(offset);
      if(response.body['transactions'] != null && response.body['transactions'] != {} && response.statusCode==200){
        _transactionList = [];
        _sendMoneyList = [];
        _cashInMoneyList = [];
        _addMoneyList = [];
        _receivedMoneyList =[];
        _cashOutList = [];
        response.body['transactions'].forEach((transactionHistory) {
          Transactions history = Transactions.fromJson(transactionHistory);
          if(history.transactionType == AppConstants.SEND_MONEY){
            _sendMoneyList.add(history);
          }else if(history.transactionType == AppConstants.CASH_IN){
            _cashInMoneyList.add(history);
          }else if(history.transactionType == AppConstants.ADD_MONEY){
            _addMoneyList.add(history);
          }else if(history.transactionType == AppConstants.RECEIVED_MONEY){
            _receivedMoneyList.add(history);
          }else if(history.transactionType == AppConstants.CASH_OUT){
            _cashOutList.add(history);
          }_transactionList.add(history);
        });
        _pageSize = TransactionModel.fromJson(response.body).totalSize;
      }else{
        ApiChecker.checkApi(response);
      }
    }
    _isLoading = false;
    _firstLoading = false;
    update();
  }
  int _transactionTypeIndex = 0;
  int get transactionTypeIndex => _transactionTypeIndex;

  void setIndex(int index) {
    _transactionTypeIndex = index;
    update();
  }

}