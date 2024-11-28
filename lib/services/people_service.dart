import 'package:dio/dio.dart';
import 'package:op_flutter_challenge/models/people.dart';
import 'package:op_flutter_challenge/models/swapi_response.dart';
import 'package:op_flutter_challenge/services/dio_client.dart';

class PeopleService {
  final dio = Dio();

  Future<SWAPIResponse<Person>> getPeople(int page, String search) async {
    final dio = DioClient.instance;
    final response = await dio
        .get('/people', queryParameters: {"page": page, "search": search});
    return SWAPIResponse.fromJson(
      response.data,
      (item) => Person.fromJson(item),
    );
  }

  Future<SWAPIResponse<Person>> searchPeople(String query) async {
    final dio = DioClient.instance;
    final response =
        await dio.get('/people', queryParameters: {"search": query});
    return SWAPIResponse.fromJson(
      response.data,
      (item) => Person.fromJson(item),
    );
  }
}
