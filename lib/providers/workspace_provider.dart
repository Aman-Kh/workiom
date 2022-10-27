import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_projects/constants/genertal_const.dart';
import 'package:flutter_projects/constants/preference_keys.dart';
import 'package:flutter_projects/models/editions_model.dart';
import 'package:flutter_projects/models/password_settings.dart';
import 'package:flutter_projects/models/register_model.dart';
import 'package:flutter_projects/models/tenant_model.dart';
import 'package:flutter_projects/models/tenant_setting.dart';
import 'package:flutter_projects/models/user_model.dart';
import 'package:flutter_projects/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkSpaceProvider extends BaseProvider {
  Dio dio = Dio();

  PasswordSettings _passwordSettings = PasswordSettings.defaultSettings();
  PasswordSettings get passwordSettings=>_passwordSettings;
  set passwordSettings(PasswordSettings value)
  {
    _passwordSettings = value;
    notifyListeners();
  }

  bool _showPassSignIn = true;
  bool get showPassSignIn => _showPassSignIn;
  void changePassViewSignIn() {
    _showPassSignIn = !_showPassSignIn;
    notifyListeners();
  }

  Future<int?> getEditionIds() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      Response response = await dio.get(
          '$baseUrl/api/services/app/TenantRegistration/GetEditionsForSelect');
      if (response != null && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["result"] != null &&
              response.data["result"]["editionsWithFeatures"] != null) {
            //print( response.data["result"]["editionsWithFeatures"]);
            var editionsWithFeatures = <EditionsWithFeatures>[];
            response.data["result"]["editionsWithFeatures"].forEach((v) {
              editionsWithFeatures!.add(EditionsWithFeatures.fromJson(v));
            });

            if(editionsWithFeatures != null && editionsWithFeatures.length>0) {
              var edition =  editionsWithFeatures.first.edition;
              if(edition != null ) {
                await pref.setInt(editionID, edition.id!);
                return edition.id;
              }
            }
          }
            return null;
          }
          return null;
        }
      return null;
    } on DioError catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print("RESPONSE:${e.response}");
        }
        return null;
      }
      if (e.stackTrace != null) {
        if (kDebugMode) {
          print(e.stackTrace.toString());
        }
        return null;
      }
      return null;
    }
  }

  Future<PasswordSettings?> getPasswordComplexitySetting() async {
    try {
      //SharedPreferences pref = await SharedPreferences.getInstance();
      Response response = await dio.get(
          '$baseUrl/api/services/app/Profile/GetPasswordComplexitySetting');
      if (response != null && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["result"] != null &&
              response.data["result"]["setting"] != null) {
            _passwordSettings = PasswordSettings.fromJson(response.data["result"]["setting"]);
            print(_passwordSettings);
            print("getPasswordComplexitySetting");
            return _passwordSettings;
          }
          return null;
        }
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print("RESPONSE:${e.response}");
        }
        return null;
      }
      if (e.stackTrace != null) {
        if (kDebugMode) {
          print(e.stackTrace.toString());
        }
        return null;
      }
      return null;
    }
    return null;
  }

  Future<TenantSetting?> checkIfTenantIsAvailable(String tenantName) async {
    try {
      var body =  {
        "tenancyName": tenantName
      };
      Response response = await dio.post('$baseUrl/api/services/app/Account/IsTenantAvailable',data: jsonEncode(body),);
      if (response != null && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["result"] != null) {
            var tenantSettings = TenantSetting.fromJson(response.data["result"]);
            return tenantSettings;
          }
          return null;
        }
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print("RESPONSE:${e.response}");
        }
        return null;
      }
      if (e.stackTrace != null) {
        if (kDebugMode) {
          print(e.stackTrace.toString());
        }
        return null;
      }
      return null;
    }
    return null;
  }

  Future<RegisterModel?> registerNewUser(String firstName, String lastName, String workSpaceName) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString(userEmail);
    var password = pref.getString(userPassword);
    var editionId = pref.getInt(editionID);
    var body =
    {
        "adminEmailAddress": email,
        "adminFirstName": firstName,
        "adminLastName": lastName,
        "adminPassword": password,
        "captchaResponse": null,
        "editionId": editionId,
        "name": workSpaceName,
        "tenancyName": workSpaceName
      };
    Response response = await dio.post('$baseUrl/api/services/app/TenantRegistration/RegisterTenant?ianaTimeZone=Europe/Istanbul',data: jsonEncode(body),);
    print(response);
    if (response != null && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["result"] != null) {
          var registerModel = RegisterModel.fromJson(response.data["result"]);
          return registerModel;
        }
        return null;
      }
    }
    return null;
  }

  Future<String?> getAccesstoken(String firstName, String lastName, String workSpaceName) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _email = pref.getString(userEmail);
    var _password = pref.getString(userPassword);
    var _tenantName = pref.getString(tenantName);
    var body =
    {
      "ianaTimeZone": "Europe/Istanbul",
      "password": _password,
      "rememberClient": false,
      "returnUrl": null,
      "singleSignIn": false,
      "tenantName": _tenantName,
      "userNameOrEmailAddress": _email
    };
    Response response = await dio.post('$baseUrl/api/TokenAuth/Authenticate',data: jsonEncode(body),);
    if (response != null && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["result"] != null) {
          if(response.data["result"]["accessToken"]  != null) {
            var _accessToken = response.data["result"]["accessToken"];
            pref.setString(accessToken, _accessToken);
            return _accessToken;
          }
          else
            return null;
        }
        return null;
      }
    }
    return null;
  }


  Future<bool> getCurrentLoginInformations() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _accessToken = pref.getString(accessToken);
    print(_accessToken);
    var user = User();
    var tenant = Tenant();
    Response response = await dio.get('$baseUrl/api/services/app/Session/GetCurrentLoginInformations',
        options: Options(headers: {
        "Authorization":
        "Bearer $_accessToken",
        }));
    if (response != null && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["result"] != null) {
          if (response.data["result"]["user"] != null) {
            user = User.fromJson(response.data["result"]["user"]);
            if(user!= null && user.name!.isNotEmpty) {
              pref.setString(userName, user.name.toString());
            }
          }
          if (response.data["result"]["tenant"] != null) {
            tenant = Tenant.fromJson(response.data["result"]["tenant"]);
            if(tenant != null && tenant.tenancyName!.isNotEmpty) {
              pref.setString(tenantName, tenant.tenancyName.toString());
            }
          }
          if (user != null && tenant != null) {
            return true;
          }
          else
            return false;
        }
        return false;
      }
      return false;
    }
    return false;
  }
}
