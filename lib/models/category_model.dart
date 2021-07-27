/*class CategoryData extends Response<Map> {
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

  CategoryData.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    currentPage = this.response['current_page'];
    if (this.response['data'] != null) {
      data = <CategoryDatum>[];
      this.response['data'].forEach((v) {
        data.add(new CategoryDatum.fromJson(v));
      });
    }
    firstPageUrl = this.response['first_page_url'];
    from = this.response['from'];
    lastPage = this.response['last_page'];
    lastPageUrl = this.response['last_page_url'];
    nextPageUrl = this.response['next_page_url'];
    path = this.response['path'];
    perPage = this.response['per_page'];
    prevPageUrl = this.response['prev_page_url'];
    to = this.response['to'];
    total = this.response['total'];
  }
}*/
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
  List<CategoryItem> data;
  int currentPage;
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
      data = <CategoryItem>[];
      json['data'].forEach((v) {
        data.add(new CategoryItem.fromJson(v));
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
class CategoryItem {
  int id;
  String name;
  String image;

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
