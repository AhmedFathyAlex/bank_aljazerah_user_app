
import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

enum KycVerification {
  APPROVE,
  PENDING,
  DENIED,
  NEED_APPLY,
}


class UserInfo {
  UserInfo({
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.image,
    this.type,
    this.gender,
    this.occupation,
    this.twoFactor,
    this.fcmToken,
    this.balance,
    this.uniqueId,
    this.qrCode,
    this.kycStatus,
  });

  String fName;
  String lName;
  String phone;
  String email;
  String image;
  int type;
  String gender;
  String occupation;
  bool twoFactor;
  String fcmToken;
  double balance;
  String uniqueId;
  String qrCode;
  KycVerification kycStatus;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    fName: json["f_name"],
    lName: json["l_name"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"],
    type: json["type"],
    gender: json["gender"],
    occupation: json["occupation"],
    twoFactor: json["two_factor"]== 1 ? true : false,
    fcmToken: json["fcm_token"],
    balance: json["balance"].toDouble() ?? 0.0,
    uniqueId: json["unique_id"],
    qrCode: json["qr_code"],
    kycStatus:  _getStatusType('${json['is_kyc_verified']}'),
  );


}

KycVerification _getStatusType(String value) {
  switch(value) {
    case '0': {
      return KycVerification.PENDING;
    }
    break;

    case '1': {
      return KycVerification.APPROVE;
    }
    break;

    case '2': {
      return KycVerification.DENIED;

    }
    break;

    default: {
      return KycVerification.NEED_APPLY;
    }
    break;
  }
}


