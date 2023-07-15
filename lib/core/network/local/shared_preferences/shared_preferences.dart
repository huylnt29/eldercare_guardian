import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../network_key.dart';
import 'shared_preferences_request_model.dart';

// ignore: avoid_classes_with_only_static_members
class SharedPreferencesHelper {
  SharedPreferencesHelper._();

  static SharedPreferencesHelper get instance => SharedPreferencesHelper._();

  static late SharedPreferences _pref;

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  String getAccessTokenKey() {
    try {
      return _pref.getString(NetworkKey.accessToken) ?? '';
    } catch (e) {
      return '';
    }
  }

  String? getAccount() {
    try {
      return _pref.getString(NetworkKey.account);
    } catch (e) {
      return null;
    }
  }

  String? getUserProfileId() {
    try {
      return _pref.getString(NetworkKey.userProfileId);
    } catch (e) {
      return null;
    }
  }

  //Set authKey
  Future<void> setAccessToken(String apiTokenKey) async {
    await _pref.setString(NetworkKey.accessToken, apiTokenKey);
  }

  Future<bool> setUserProfileId(String value) async {
    try {
      return _pref.setString(NetworkKey.userProfileId, value);
    } catch (e) {
      return false;
    }
  }

  Future<void> removeAccessToken() async {
    await _pref.remove(NetworkKey.accessToken);
  }

  String? getString(String key) {
    return _pref.getString(key);
  }

  Future<void> setInt({
    required SharedPreferencesRequest<int> sharedPreferencesRequest,
  }) async {
    await _pref.setInt(
        sharedPreferencesRequest.key, sharedPreferencesRequest.value);
  }

  int? getInt({required String key}) {
    return _pref.getInt(key);
  }

  Future<void> setStringList({
    required SharedPreferencesRequest<List<String>> sharedPreferencesRequest,
  }) async {
    await _pref.setStringList(
        sharedPreferencesRequest.key, sharedPreferencesRequest.value);
  }

  List<String>? getStringList({
    required String key,
  }) {
    // final prefs = await SharedPreferences.getInstance();
    return _pref.getStringList(key);
  }

  Future<void> setBool({
    required SharedPreferencesRequest<bool> sharedPreferencesRequest,
  }) async {
    final data = await _pref.setBool(
        sharedPreferencesRequest.key, sharedPreferencesRequest.value);
    log('save: $data');
  }

  bool? getBool({required String key}) {
    return _pref.getBool(key);
  }

  Future<bool> setObject({
    required SharedPreferencesRequest<Map<String, dynamic>> request,
  }) async {
    final data = await _pref.setString(request.key, jsonEncode(request.value));
    return data;
  }

  Future<void> setString({
    required SharedPreferencesRequest<String> sharedPreferencesRequest,
  }) async {
    await _pref.setString(
        sharedPreferencesRequest.key, sharedPreferencesRequest.value);
  }

  // Map<String, dynamic> getObject({
  //   required String key,
  // }) {
  //   final object = _pref.getString(key);
  //   if (object?.isNullOrEmpty()) return {};
  //   return jsonDecode(object!) as Map<String, dynamic>;
  // }

  Future<void> cleanAllData() async {
    await _pref.clear();
  }

  Future<List<T>> getListObject<T>({
    required String key,
  }) async {
    // final prefs = await SharedPreferences.getInstance();
    if (_pref.getString(key) == null) {
      return [] as List<T>;
    }
    return jsonDecode(_pref.getString(key) ?? '');
  }
}
