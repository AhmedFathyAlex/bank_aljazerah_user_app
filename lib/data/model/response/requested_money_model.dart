class RequestedMoneyModel {
  int totalSize;
  int limit;
  int offset;
  List<RequestedMoney> requestedMoney;

  RequestedMoneyModel(
      {this.totalSize, this.limit, this.offset, this.requestedMoney});

  RequestedMoneyModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['requested_money'] != null) {
      requestedMoney = <RequestedMoney>[];
      json['requested_money'].forEach((v) {
        requestedMoney.add(new RequestedMoney.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.requestedMoney != null) {
      data['requested_money'] =
          this.requestedMoney.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestedMoney {
  int id;
  Sender sender;
  Receiver receiver;
  String type;
  double amount;
  String note;
  String createdAt;

  RequestedMoney(
      {this.id,
        this.sender,
        this.receiver,
        this.type,
        this.amount,
        this.note,
        this.createdAt});

  RequestedMoney.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    receiver =
    json['receiver'] != null ? new Receiver.fromJson(json['receiver']) : null;
    // json['sender'] != null ? new Sender.fromJson(json['sender']) : 'User Unavailable';
    // receiver =
    // json['receiver'] != null ? new Receiver.fromJson(json['receiver']) : 'User Unavailable';
    type = json['type'];
    amount = json['amount'].toDouble();
    note = json['note'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    if (this.sender != null) {
      data['receiver'] = this.sender.toJson();
    }
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Sender {
  String phone;
  String name;

  Sender({this.phone, this.name});

  Sender.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    // phone = json['phone'] != null ? json['phone'] : 'User Unavailable';
    // name = json['name'] != null ? json['phone'] : 'User Unavailable';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['name'] = this.name;
    return data;
  }
}
class Receiver {
  String phone;
  String name;

  Receiver({this.phone, this.name});

  Receiver.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    // phone = json['phone'] != null ? json['phone'] : 'User Unavailable';
    // name = json['name'] != null ? json['phone'] : 'User Unavailable';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['name'] = this.name;
    return data;
  }
}
