import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'example.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/tasks")
  Future<List<Task>> getTasks();
}

class Task {
  String id;
  String name;
  String avatar;
  String createdAt;
  Task();

  Task.fromJson(Map json){
    id = json["id"];
    name = json["name"];
    avatar = json["avatar"];
    createdAt = json["createdAt"];
  }
}

