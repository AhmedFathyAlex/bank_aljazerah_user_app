class BannerModel {
  String title;
  String image;
  String url;

  BannerModel({this.title, this.image, this.url});

  BannerModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}