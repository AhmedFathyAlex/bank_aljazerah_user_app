import 'package:flutter/cupertino.dart';

class EditProfileBody {
  String fName;
  String lName;
  String email;
  String gender;
  String occupation;

  EditProfileBody({@required this.fName,@required this.lName, this.email='',@required this.gender,@required this.occupation});

  EditProfileBody.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    gender = json['gender'];
    occupation = json['occupation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['occupation'] = this.occupation;
    return data;
  }
}