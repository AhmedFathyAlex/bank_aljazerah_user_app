import 'package:six_cash/data/api/api_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:six_cash/data/model/response/requested_money_model.dart';
import 'package:six_cash/data/repository/requested_money_repo.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';


class RequestedMoneyController extends GetxController implements GetxService {
  final RequestedMoneyRepo requestedMoneyRepo;
  RequestedMoneyController({@required this.requestedMoneyRepo});



  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<RequestedMoney> _requestedMoneyList = [];
  List<RequestedMoney> _ownRequestList = [];

  List<RequestedMoney> get requestedMoneyList => _requestedMoneyList;
  List<RequestedMoney> get ownRequestList => _ownRequestList;

  List<RequestedMoney> _pendingRequestedMoneyList =[];
  List<RequestedMoney> _ownPendingRequestedMoneyList =[];

  List<RequestedMoney> get pendingRequestedMoneyList => _pendingRequestedMoneyList;
  List<RequestedMoney> get ownPendingRequestedMoneyList => _ownPendingRequestedMoneyList;

  List<RequestedMoney> _acceptedRequestedMoneyList =[];
  List<RequestedMoney> _ownAcceptedRequestedMoneyList =[];

  List<RequestedMoney> get acceptedRequestedMoneyList =>_acceptedRequestedMoneyList;
  List<RequestedMoney> get ownAcceptedRequestedMoneyList =>_ownAcceptedRequestedMoneyList;

  List<RequestedMoney> _deniedRequestedMoneyList =[];
  List<RequestedMoney> _ownDeniedRequestedMoneyList =[];

  List<RequestedMoney> get deniedRequestedMoneyList => _deniedRequestedMoneyList;
  List<RequestedMoney> get ownDeniedRequestedMoneyList => _ownDeniedRequestedMoneyList;

  int _offset = 1;
  int _pageSize;
  List<int> _offsetList = [];
  int get offset => _offset;
  List<int> get offsetList => _offsetList;
  int get pageSize => _pageSize;
  Future getRequestedMoneyList(int offset, {bool reload = false}) async{
    if(reload) {
      _offsetList = [];
      _requestedMoneyList = [];
      _pendingRequestedMoneyList =[];
      _acceptedRequestedMoneyList =[];
      _deniedRequestedMoneyList =[];
    }
    Response response = await requestedMoneyRepo.getRequestedMoneyList();
    if(response.body['requested_money'] != null && response.body['requested_money'] != {} && response.statusCode == 200){
      print('body req : ${response.body['requested_money']}');
      _requestedMoneyList =[];
      _pendingRequestedMoneyList =[];
      _acceptedRequestedMoneyList =[];
      _deniedRequestedMoneyList =[];
        response.body['requested_money'].forEach((requested) {
          RequestedMoney req = RequestedMoney.fromJson(requested);
          if(req.sender != null) {
            if(req.type == AppConstants.APPROVED){
              _acceptedRequestedMoneyList.add(req);
            }else if(req.type == AppConstants.PENDING){
              _pendingRequestedMoneyList.add(req);
            }else if(req.type == AppConstants.DENIED){
              _deniedRequestedMoneyList.add(req);
            }
            _requestedMoneyList.add(req);
          }
        });


      _isLoading = false;
      update();
    }else {
      ApiChecker.checkApi(response);
      _isLoading = false;
      update();
    }

  }

  Future getOwnRequestedMoneyList(int offset, {bool reload = false}) async{
    print('own request api call');
    if(reload) {
      _offsetList = [];
      _ownRequestList = [];
      _ownPendingRequestedMoneyList =[];
      _ownAcceptedRequestedMoneyList =[];
      _ownDeniedRequestedMoneyList =[];
    }
    Response response = await requestedMoneyRepo.getOwnRequestedMoneyList();

    if(response.body['requested_money'] != null && response.body['requested_money'] != {} && response.statusCode == 200){
      print('own request : ${response.body['requested_money']}');
      _ownRequestList =[];
      _ownPendingRequestedMoneyList =[];
      _ownAcceptedRequestedMoneyList =[];
      _ownDeniedRequestedMoneyList =[];
      response.body['requested_money'].forEach((requested) {

        RequestedMoney req = RequestedMoney.fromJson(requested);
        if(req.receiver != null){
          ownRequestList.add(req);
          if(req.type == AppConstants.APPROVED){
            _ownAcceptedRequestedMoneyList.add(req);
          }else if(req.type == AppConstants.PENDING){
            _ownPendingRequestedMoneyList.add(req);
          }else if(req.type == AppConstants.DENIED){
            _ownDeniedRequestedMoneyList.add(req);
          }
        }


      });
      _isLoading = false;
      update();
    }else {
      ApiChecker.checkApi(response);
      _isLoading = false;
      update();
    }

  }

  Future<void> acceptRequest(BuildContext context, int requestId, String pin) async {
    _isLoading = true;
    update();
    Response response = await requestedMoneyRepo.approveRequestedMoney(requestId, pin);
    print(response.status);

    if(response.statusCode == 200) {
      getRequestedMoneyList(offset);
      Get.back();
      Navigator.pop(context);
      _isLoading = false;
    }else {
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
   update();
  }
  Future<void> denyRequest(BuildContext context, int requestId, String pin ) async {
    _isLoading = true;
    update();
    Response response = await requestedMoneyRepo.denyRequestedMoney(requestId, pin);
    if(response.statusCode == 200) {
      getRequestedMoneyList(offset);
      showCustomSnackBar('request_denied_successfully'.tr,isError: false);
      Get.back();
      Navigator.pop(context);
      _isLoading = false;
    }else {
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }


  int _requestTypeIndex = 0;
  int get requestTypeIndex => _requestTypeIndex;

  void setIndex(int index) {
    _requestTypeIndex = index;
    update();
  }
  void showBottomLoader() {
    _isLoading = true;
    update();
  }
}