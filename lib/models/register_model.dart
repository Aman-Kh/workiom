class RegisterModel {
  int? tenantId;
  String? tenancyName;
  String? name;
  String? userName;
  String? emailAddress;
  bool? isTenantActive;
  bool? isActive;
  bool? isEmailConfirmationRequired;

  RegisterModel(
      {this.tenantId,
        this.tenancyName,
        this.name,
        this.userName,
        this.emailAddress,
        this.isTenantActive,
        this.isActive,
        this.isEmailConfirmationRequired});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    tenantId = json['tenantId'];
    tenancyName = json['tenancyName'];
    name = json['name'];
    userName = json['userName'];
    emailAddress = json['emailAddress'];
    isTenantActive = json['isTenantActive'];
    isActive = json['isActive'];
    isEmailConfirmationRequired = json['isEmailConfirmationRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenantId'] = this.tenantId;
    data['tenancyName'] = this.tenancyName;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['emailAddress'] = this.emailAddress;
    data['isTenantActive'] = this.isTenantActive;
    data['isActive'] = this.isActive;
    data['isEmailConfirmationRequired'] = this.isEmailConfirmationRequired;
    return data;
  }
}