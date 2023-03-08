import 'package:bhubtesttwo/api/api_provider.dart';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  var baseUrl;
  var appid;
  setUp(() {
    dio.httpClientAdapter = dioAdapter;
    baseUrl = "https://api.openweathermap.org/data/2.5/";
    appid = '1e0a239976f73a9fc7fcdee83d3fe361';
  });
  group('The day\'s weather', () {
    test('Success case', () async {
      dioAdapter.onGet(
          baseUrl, (server) => server.reply(200, {'message': 'success'}),
          data: Matchers.any, queryParameters: {'appid': appid}, headers: {});
      final service = ApiProvider(
        dio,
      );
      final response = await service.getWeather(lat: -4.0729, lon: 39.6684);
      expect(response, isA());
    });
    test('Failure case', () async {
      dioAdapter.onGet(
          baseUrl,
          (server) => server.throws(
              400,
              DioError(
                  requestOptions: RequestOptions(
                path: baseUrl,
              ))),
          data: Matchers.any,
          queryParameters: {'appid': appid},
          headers: {});
      final service = ApiProvider(
        dio,
      );
      final response = await service.getWeather(lat: -4.0729, lon: 39.6684);
      expect(response, isA());
    });
    test('Success case two', () async {
      dioAdapter.onGet(
          baseUrl, (server) => server.reply(200, {'message': 'success'}),
          data: Matchers.any, queryParameters: {'appid': appid}, headers: {});
      final service = ApiProvider(
        dio,
      );
      final response = await service.getWeather(lat: -4.0729, lon: 39.6684);
      expect(response, isA());
    });
  });
}
