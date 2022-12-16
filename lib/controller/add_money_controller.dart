import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/model/agent_model.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/data/repository/add_money_repo.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMoneyController extends GetxController implements GetxService {
  final AddMoneyRepo addMoneyRepo;
  AddMoneyController({@required this.addMoneyRepo});

  List<AgentModel> _agentList;
 bool  _isLoading = false;
  List<String> filterdBankList= [];
  String _selectedBank;
  ContactModel _contact;
  String _addMoneyWebLink;
  List<AgentModel> get agentList => _agentList;
  bool get isLoading => _isLoading;
  ContactModel get contact => _contact;
  String get selectedBank => _selectedBank;
  String get addMoneyWebLink => _addMoneyWebLink;


  Future<void> addMoney(BuildContext context, String amount) async{
    _isLoading = true;
    Response response = await addMoneyRepo.addMoneyApi(amount : amount);
    if(response.statusCode == 200){
     _addMoneyWebLink =  response.body['link'];
     Get.toNamed(RouteHelper.add_money_web);
     _isLoading = false;

    }else{
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();


  }
  Future<bool> getBackScreen()async{
    Get.offAndToNamed(RouteHelper.navbar, arguments: false);
    return null;
  }

}