import 'package:cirilla/models/product_model.dart';

class Home {
  bool status;
  String message;
  Data data;

  Home.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] ?? null; //TODO:
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Banners> banners;
  List<Product> products;
  String ad;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
    ad = json['ad'];
  }
}

class Banners {
  int id;
  String image;
  Category category;
  Null product;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'] != null ? new Category.fromJson(json['category']) : null;
    product = json['product'];
  }
}
// TODO: Separate this class into its own model
class Category {
  int id;
  String image;
  String name;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}