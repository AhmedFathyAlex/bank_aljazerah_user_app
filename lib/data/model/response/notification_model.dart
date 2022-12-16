class NotificationModel {
  int totalSize;
  int limit;
  int offset;
  List<Notifications> notifications;

  NotificationModel(
      {this.totalSize, this.limit, this.offset, this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int id;
  String title;
  String description;
  String image;
  int status;
  String createdAt;
  String receiver;

  Notifications(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.receiver});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    receiver = json['receiver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['receiver'] = this.receiver;
    return data;
  }
}
