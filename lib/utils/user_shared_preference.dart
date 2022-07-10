import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
   late SharedPreferences _preferences;

  static const _keyUsername = 'username';
  static const _keyPassword = 'password';
  static const _keyEmail = 'email';
  static const _keyPhone = 'phone';
  static const _keyUid = 'uid';
  static const _keyRoles = 'roles';

   Future init() async =>
      _preferences = await SharedPreferences.getInstance();

   Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

   String? getUsername() => _preferences.getString(_keyUsername);
  Future setPhone(String phone) async =>
      await _preferences.setString(_keyPhone, phone);

   String? getPhone() => _preferences.getString(_keyPhone);
    Future setUid(String uid) async =>
      await _preferences.setString(_keyUid, uid);

   String? getUid() => _preferences.getString(_keyUid);


   Future setPassword(String password) async =>
      await _preferences.setString(_keyPassword, password);

   String? getPassword() => _preferences.getString(_keyPassword);

   Future setEmail(String email) async {
    // final birthday = dateOfBirth.toIso8601String();

    return await _preferences.setString(_keyEmail, email);
  }

   String? getEmail() => _preferences.getString(_keyEmail);

    Future setRoles(String roles) async =>
      await _preferences.setString(_keyRoles, roles);

   String? getRoles() => _preferences.getString(_keyRoles);

  
}