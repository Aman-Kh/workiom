import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_projects/constants/genertal_const.dart';
import 'package:flutter_projects/constants/preference_keys.dart';
import 'package:flutter_projects/models/editions_model.dart';
import 'package:flutter_projects/models/password_settings.dart';
import 'package:flutter_projects/models/tenant_setting.dart';
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
            /*await pref.setBool(requireDigit, _passwordSettings.requireDigit!);
            await pref.setInt(requiredLength, _passwordSettings.requiredLength!);
            await pref.setBool(requireLowercase, _passwordSettings.requireLowercase!);
            await pref.setBool(requireNonAlphanumeric, _passwordSettings.requireNonAlphanumeric!);
            await pref.setBool(requireUppercase, _passwordSettings.requireUppercase!);
             */
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
            var tenantSettings =
                TenantSetting.fromJson(response.data["result"]);
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
}
