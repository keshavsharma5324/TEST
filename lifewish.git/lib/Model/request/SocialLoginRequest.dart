class SocialLoginRequest {
  String firstName;
  String lastName;
  String email;
  String providerName;
  String providerId;
  String password;

  SocialLoginRequest(
      {this.firstName,
      this.lastName,
      this.email,
      this.providerName,
      this.providerId,
      this.password});

  SocialLoginRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    providerName = json['provider_name'];
    providerId = json['provider_id'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['provider_name'] = this.providerName;
    if (this.providerId != null) {
      data['provider_id'] = this.providerId;
    }
    if (this.password != null) {
      data['password'] = this.password;
    }
    return data;
  }
}
