import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart' as fpd;
import 'package:client/core/http/http_error.dart';
import 'package:client/features/auth/models/user_model.dart';
import 'package:client/core/constants/server_constant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<fpd.Either<HttpError, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverURL}auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'password': password}),
      );

      final responseBodyMap =
          json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 201) {
        return fpd.Right(UserModel.fromMap(responseBodyMap));
      } else {
        return fpd.Left(HttpError((responseBodyMap['detail'])));
      }
    } catch (e) {
      return fpd.Left(HttpError(e.toString()));
    }
  }

  Future<fpd.Either<HttpError, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverURL}auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      final responseBodyMap =
          json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return fpd.Right(
          UserModel.fromMap(
            responseBodyMap['user'],
          ).copyWith(token: responseBodyMap['token']),
        );
      } else {
        return fpd.Left(HttpError(responseBodyMap['detail']));
      }
    } catch (e) {
      return fpd.Left(HttpError(e.toString()));
    }
  }

  Future<fpd.Either<HttpError, UserModel>> getCurrentUser({
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${ServerConstant.serverURL}auth/'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      final responseBodyMap =
          json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return fpd.Right(
          UserModel.fromMap(
            responseBodyMap,
          ).copyWith(token: token),
        );
      } else {
        return fpd.Left(HttpError(responseBodyMap['detail']));
      }
    } catch (e) {
      return fpd.Left(HttpError(e.toString()));
    }
  }
}
