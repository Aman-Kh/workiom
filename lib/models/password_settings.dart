import 'package:flutter_projects/constants/constants.dart';

class PasswordSettings {
  bool? requireDigit;
  bool? requireLowercase;
  bool? requireNonAlphanumeric;
  bool? requireUppercase;
  int? requiredLength;

  PasswordSettings(
      {this.requireDigit,
      this.requireLowercase,
      this.requireNonAlphanumeric,
      this.requireUppercase,
      this.requiredLength});

  PasswordSettings.fromJson(Map<String, dynamic> json) {
    requireDigit = json['requireDigit'];
    requireLowercase = json['requireLowercase'];
    requireNonAlphanumeric = json['requireNonAlphanumeric'];
    requireUppercase = json['requireUppercase'];
    requiredLength = json['requiredLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requireDigit'] = requireDigit;
    data['requireLowercase'] = requireLowercase;
    data['requireNonAlphanumeric'] = requireNonAlphanumeric;
    data['requireUppercase'] = requireUppercase;
    data['requiredLength'] = requiredLength;
    return data;
  }

  factory PasswordSettings.defaultSettings() {
    return PasswordSettings(
      requireDigit: false,
      requiredLength: 0,
      requireLowercase: false,
      requireNonAlphanumeric: false,
      requireUppercase: false
    );
  }
}
