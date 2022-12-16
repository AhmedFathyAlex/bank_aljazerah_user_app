class TransactionModel {
  int totalSize;
  int limit;
  int offset;
  List<Transactions> transactions;

  TransactionModel(
      {this.totalSize, this.limit, this.offset, this.transactions});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.transactions != null) {
      data['transactions'] = this.transactions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String transactionType;
  String transactionId;
  double debit;
  double credit;
  UserInfo userInfo;
  String createdAt;
  double amount;
  Receiver receiver;
  Sender sender;

  Transactions(
      {this.transactionType,
        this.transactionId,
        this.debit,
        this.credit,
        this.userInfo,
        this.createdAt,
        this.receiver,
        this.sender,
        this.amount});

  Transactions.fromJson(Map<String, dynamic> json) {
    transactionType = json['transaction_type'];
    transactionId = json['transaction_id'];
    debit = json['debit'].toDouble();
    credit = json['credit'].toDouble();
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
    sender = json['sender'] != null
        ? new Sender.fromJson(json['sender'])
        : null;
    createdAt = json['created_at'];
    amount = json['amount'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_type'] = this.transactionType;
    data['transaction_id'] = this.transactionId;
    data['debit'] = this.debit;
    data['credit'] = this.credit;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo.toJson();
    }
    data['created_at'] = this.createdAt;
    data['amount'] = this.amount;
    return data;
  }
}

class UserInfo {
  String phone;
  String name;

  UserInfo({this.phone, this.name});

  UserInfo.fromJson(Map<String, dynamic> json) {
    phone = json['phone'] ?? '';
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['name'] = this.name;
    return data;
  }
}

class Sender {
  String phone;
  String name;

  Sender({this.phone, this.name});

  Sender.fromJson(Map<String, dynamic> json) {
    phone = json['phone'] ?? '';
    name = json['name'] ?? '';
  }
}

class Receiver {
  String phone;
  String name;
  Receiver({this.phone, this.name});

  Receiver.fromJson(Map<String, dynamic> json) {
    phone = json['phone'] ?? '';
    name = json['name'] ?? '';
  }
}