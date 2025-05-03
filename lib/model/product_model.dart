class ProductModel {
  int? status;
  Products? products;

  ProductModel({this.status, this.products});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    products =
        json['products'] != null ? Products.fromJson(json['products']) : null;
  }
}

class Products {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Products({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Products.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class Data {
  int? id;
  int? categoryId;
  String? imageOne;
  String? imageTwo;
  String? imageThree;
  String? name;
  String? description;
  int? price;
  int? offerPrice;
  int? quantity;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  CategoryData? categoryData;

  Data({
    this.id,
    this.categoryId,
    this.imageOne,
    this.imageTwo,
    this.imageThree,
    this.name,
    this.description,
    this.price,
    this.offerPrice,
    this.quantity,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.categoryData,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    imageOne = json['image_one'];
    imageTwo = json['image_two'];
    imageThree = json['image_three'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    offerPrice = json['offer_price'];
    quantity = json['quantity'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryData =
        json['category_data'] != null
            ? CategoryData.fromJson(json['category_data'])
            : null;
  }
}

class CategoryData {
  int? id;
  String? name;
  String? image;

  CategoryData({this.id, this.name, this.image});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
}
