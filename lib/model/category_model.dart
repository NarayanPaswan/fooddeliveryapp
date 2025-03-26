class CategoryModel {
  int? status;
  List<Categories>? categories;

  CategoryModel({this.status, this.categories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }
}

class Categories {
  int? id;
  String? name;
  String? image;
  String? status;

  Categories({this.id, this.name, this.image, this.status});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
  }
}
