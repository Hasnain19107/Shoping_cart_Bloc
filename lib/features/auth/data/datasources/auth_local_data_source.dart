import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUserSession(UserModel user);
  Future<UserModel?> getUserSession();
  Future<void> clearUserSession();
  Future<bool> hasUserSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _userKey = 'user_session';
  static const String _isLoggedInKey = 'is_logged_in';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveUserSession(UserModel user) async {
    try {
      await sharedPreferences.setString(_userKey, json.encode(user.toJson()));
      await sharedPreferences.setBool(_isLoggedInKey, true);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUserSession() async {
    try {
      final userData = sharedPreferences.getString(_userKey);
      if (userData != null && userData.isNotEmpty) {
        final userMap = json.decode(userData) as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearUserSession() async {
    try {
      await sharedPreferences.remove(_userKey);
      await sharedPreferences.setBool(_isLoggedInKey, false);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> hasUserSession() async {
    try {
      final isLoggedIn = sharedPreferences.getBool(_isLoggedInKey) ?? false;
      final userData = sharedPreferences.getString(_userKey);
      final hasValidSession =
          isLoggedIn && userData != null && userData.isNotEmpty;
      return hasValidSession;
    } catch (e) {
      return false;
    }
  }
}
