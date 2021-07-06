class Product {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;
  List<dynamic> images;
  bool inFavorites;
  bool inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'] ?? null;
    inFavorites = json['in_favorites'] ?? null;
    inCart = json['in_cart'] ?? null;
  }
}