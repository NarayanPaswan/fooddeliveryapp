class BannerModel {
  int? status;
  List<Banners>? banners;

  BannerModel({this.status, this.banners});

  BannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
  }
}

class Banners {
  int? id;
  String? name;
  String? imageOrLink;
  String? status;

  Banners({this.id, this.name, this.imageOrLink, this.status});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageOrLink = json['image_or_link'];
    status = json['status'];
  }
}
