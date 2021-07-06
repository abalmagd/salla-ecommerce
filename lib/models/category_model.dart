class Categories {
  bool status;
  String message;
  CategoryData data;

  Categories.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CategoryData.fromJson(json['data']) :
    null;
  }
}

class CategoryData {
  int currentPage;
  List<CategoryDatum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  CategoryData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CategoryDatum>[];
      json['data'].forEach((v) {
        data.add(new CategoryDatum.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}
// TODO: Separate this class into its own model (check home_model.dart)
class CategoryDatum {
  int id;
  String name;
  String image;

  CategoryDatum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
