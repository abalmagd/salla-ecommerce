class Response<T> {
  bool status = false;
  String message;
  T response;

  Response({
    String message,
    bool status,
    T response,
  }) {
    this.message = message;
    this.status = status;
    this.response = response;
  }

  Response.fromJson(Map<String, dynamic> json)
  {
    this.status = json['status'];
    this.message = json['message'];
    this.response = json['data'];
  }

  String getMessage() {
    return message;
  }

  void setMessage(String message) {
    this.message = message;
  }

  bool getStatus() {
    return status;
  }

  void setStatus(bool status) {
    this.status = status;
  }

  T getResponse() {
    return response;
  }

  void setResponse(T response) {
    this.response = response;
  }
}
