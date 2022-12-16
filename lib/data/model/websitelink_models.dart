class WebsiteLinkModel {

  String name;
  String image;
  String url;

  WebsiteLinkModel(
      {
        this.name,
        this.image,
        this.url,});

  WebsiteLinkModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}
