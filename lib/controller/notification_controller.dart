import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/model/response/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:six_cash/data/repository/notification_repo.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({@required this.notificationRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Notifications> _notificationList;
  List<Notifications> get notificationList => _notificationList;


  Future getNotificationList() async{
    _notificationList = [];
    Response response = await notificationRepo.getNotificationList();
    if(response.body != null && response.body != {} && response.statusCode == 200){
      response.body['notifications'].forEach((notify) {_notificationList.add(Notifications.fromJson(notify));});
      _isLoading = false;
      update();
    }else {
      ApiChecker.checkApi(response);
      _isLoading = false;
    }

  }
}