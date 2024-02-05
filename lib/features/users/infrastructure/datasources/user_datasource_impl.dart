import 'package:crud_firebase/config/constants/env.dart';
import 'package:crud_firebase/config/helper/helper.dart';
import 'package:crud_firebase/features/users/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class UserDatasourceImpl extends UserDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: "https://${Environment.databaseName}.firebaseio.com"),
  );

  @override
  Future<void> createUser(
    String firstName,
    String lastName,
    String email,
  ) async {
    try {
      final id = const Uuid().v4();
      final data = {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      };
      await dio.patch("/users/$id.json", data: data);
    } catch (e) {
      throw handleError(e);
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await dio.delete("/users/$id.json");
    } catch (e) {
      throw handleError(e);
    }
  }

  @override
  Future<void> editUser(
    String id,
    String firstName,
    String lastName,
    String email,
  ) async {
    try {
      final data = {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      };
      await dio.patch("/users/$id.json", data: data);
    } catch (e) {
      throw handleError(e);
    }
  }

  @override
  Future<List<UserEntity>> getUsers() async {
    try {
      final response = await dio.get("/users.json");
      if (response.data == null) {
        return [];
      }
      final data = response.data as Map<String, dynamic>;
      final List<UserEntity> users = [];
      data.forEach((key, value) {
        users.add(UserEntity.fromJson(value));
      });
      return users;
    } catch (e) {
      throw handleError(e);
    }
  }
}
