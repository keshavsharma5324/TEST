class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String emailVerifiedAt;
  Null phone;
  Null phoneVerifiedAt;
  Null photo;
  String locale;
  bool blocked;
  int type;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String token;
  bool passwordIsSet;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerifiedAt,
      this.phone,
      this.phoneVerifiedAt,
      this.photo,
      this.locale,
      this.blocked,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.token,
      this.passwordIsSet});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    phoneVerifiedAt = json['phone_verified_at'];
    photo = json['photo'];
    locale = json['locale'];
    blocked = json['blocked'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    token = json['token'];
    passwordIsSet = json['password_is_set'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['photo'] = this.photo;
    data['locale'] = this.locale;
    data['blocked'] = this.blocked;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['token'] = this.token;
    data['password_is_set'] = this.passwordIsSet;
    return data;
  }
}
