class Meta {
  String status;
  int statusCode;
  int currentPage;
  int totalPage;

  Meta({this.status, this.statusCode, this.currentPage, this.totalPage});

  Meta.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    currentPage = json['current_page'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['current_page'] = this.currentPage;
    data['total_page'] = this.totalPage;
    return data;
  }
}
