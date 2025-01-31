import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_grid/core/error/failure.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  static const String tokenKey = "token";
  static const String roleKey = "role";

  // Save token and role
  Future<Either<Failure, void>> saveTokenRole(String token, String role) async {
    try {
      await _sharedPreferences.setString(tokenKey, token);
      await _sharedPreferences.setString(roleKey, role);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Get token
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString(tokenKey);
      return Right(token ?? "");
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Get role
  Future<Either<Failure, String>> getRole() async {
    try {
      final role = _sharedPreferences.getString(roleKey);
      return Right(role ?? "");
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  /// Clear token and role (for logout)
  Future<Either<Failure, void>> clear() async {
    try {
      await _sharedPreferences.remove(tokenKey);
      await _sharedPreferences.remove(roleKey);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}

