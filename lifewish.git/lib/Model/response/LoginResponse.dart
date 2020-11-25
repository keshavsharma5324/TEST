import 'ResponseMeta.dart';
import '../User.dart';

abstract class ApiResponse {
  Meta meta;
  Data data;
  List<Error> error;
}

class LoginResponse implements ApiResponse {
  @override
  Meta meta;

  @override
  Data data;

  @override
  List<Error> error;

  LoginResponse({this.meta, this.data, this.error});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = new List<Error>();
      json['error'].forEach((v) {
        error.add(new Error.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  User user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Error {
  String key;
  String message;

  Error({this.key, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['message'] = this.message;
    return data;
  }
}
