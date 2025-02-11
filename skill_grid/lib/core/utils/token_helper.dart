import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/core/error/failure.dart';

class TokenHelper {
  final TokenSharedPrefs _tokenSharedPrefs;

  TokenHelper({required TokenSharedPrefs tokenSharedPrefs})
    : _tokenSharedPrefs = tokenSharedPrefs;

  Future<String?> getUserIdFromToken() async {
    final Either<Failure, String> token = await _tokenSharedPrefs.getToken();

    return token.fold(
      (failure) {
        return null;
      },
      (token) {
        try {
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          return decodedToken["userId"];
        } catch (e) {
          return null;
        }
      },
    );
  }

  Future<String?> getRoleFromToken() async {
    final Either<Failure, String> token = await _tokenSharedPrefs.getToken();

    return token.fold(
      (failure) {
        return null;
      },
      (token) {
        try {
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          return decodedToken["role"];
        }
        catch(e) {
          return null;
        }
      }
    );
  }
}
