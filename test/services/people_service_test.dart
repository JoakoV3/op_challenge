import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:op_flutter_challenge/services/dio_client.dart';
import 'package:op_flutter_challenge/services/people_service.dart';
import '../dio_test.mocks.mocks.dart';

void main() {
  late MockDio mockDio; // Mock de Dio
  late PeopleService peopleService;

  setUp(() {
    mockDio = MockDio();
    DioClient.setInstance(mockDio);
    peopleService = PeopleService();
  });

  group('PeopleService Tests', () {
    test('getPeople returns a valid SWAPIResponse', () async {
      final mockResponse = {
        "count": 1,
        "next": "https://swapi.dev/api/people/?page=2",
        "previous": null,
        "results": [
          {
            "name": "Luke Skywalker",
            "height": "172",
            "mass": "77",
            "hair_color": "blond",
            "skin_color": "fair",
            "eye_color": "blue",
            "birth_year": "19BBY",
            "gender": "male",
            "homeworld": "https://swapi.dev/api/planets/1/",
            "films": [],
            "species": [],
            "vehicles": [],
            "starships": [],
            "created": "2014-12-09T13:50:51.644000Z",
            "edited": "2014-12-20T21:17:56.891000Z",
            "url": "https://swapi.dev/api/people/1/"
          }
        ]
      };

      // Mock de la respuesta del servicio
      when(mockDio.get(
        '/people',
        queryParameters: {"page": 1, "search": ""},
      )).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/people'),
        ),
      );

      final result = await peopleService.getPeople(1, "");

      // Validaciones
      expect(result.count, 1);
      expect(result.results.first.name, "Luke Skywalker");
      expect(result.results.first.height, "172");
      expect(result.results.first.mass, "77");
      expect(result.results.first.eyeColor, "blue");
      expect(result.results.first.gender, "male");

      verify(mockDio.get('/people', queryParameters: {"page": 1, "search": ""}))
          .called(1);
    });

    test('searchPeople returns a valid SWAPIResponse', () async {
      final mockResponse = {
        "count": 1,
        "next": null,
        "previous": null,
        "results": [
          {
            "name": "Leia Organa",
            "height": "150",
            "mass": "49",
            "hair_color": "brown",
            "skin_color": "light",
            "eye_color": "brown",
            "birth_year": "19BBY",
            "gender": "female",
            "homeworld": "https://swapi.dev/api/planets/2/",
            "films": [],
            "species": [],
            "vehicles": [],
            "starships": [],
            "created": "2014-12-10T15:20:09.791000Z",
            "edited": "2014-12-20T21:17:50.315000Z",
            "url": "https://swapi.dev/api/people/5/"
          }
        ]
      };

      // Mock de la respuesta del servicio
      when(mockDio.get(
        '/people',
        queryParameters: {"search": "Leia"},
      )).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/people'),
        ),
      );

      final result = await peopleService.searchPeople("Leia");

      // Validaciones
      expect(result.count, 1);
      expect(result.results.first.name, "Leia Organa");
      expect(result.results.first.height, "150");
      expect(result.results.first.mass, "49");

      verify(mockDio.get('/people', queryParameters: {"search": "Leia"}))
          .called(1);
    });
  });
}
