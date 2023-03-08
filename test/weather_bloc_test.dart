import 'package:bhubtesttwo/api/api_provider.dart';
import 'package:bhubtesttwo/api/api_repository.dart';
import 'package:bhubtesttwo/data/weather_bloc_cubit.dart';
import 'package:bhubtesttwo/data/weather_bloc_state.dart';
import 'package:bhubtesttwo/models/weather_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  var baseUrl;
  var appid;
  List<dynamic> data = [
    {"id": 801, "main": "Clouds", "description": "few clouds", "icon": "02d"}
  ];
  List<Weather> response = [
    Weather(id: 801, main: 'Clouds', description: "few clouds", icon: "02d")
  ];
  setUp(() {
    dio.httpClientAdapter = dioAdapter;
    baseUrl = "https://api.openweathermap.org/data/2.5/";
    appid = '1e0a239976f73a9fc7fcdee83d3fe361';
  });
  group('The day\'s weather', () {
    blocTest<WeatherBlocCubit, WeatherBlocState>('bloc empty data',
        setUp: () {
          return dioAdapter.onGet(
            baseUrl,
            (server) => server.reply(200, []),
          );
        },
        build: () => WeatherBlocCubit(ApiRepository(Dio())),
        act: (bloc) => bloc.getWeatherList(lat: -4.0729, lon: 39.6684),
        wait: const Duration(milliseconds: 500),
        expect: () =>
            [isA<LoadingWeatherListBlocState>(), isA<ListWeatherBlocState>()]);
    blocTest<WeatherBlocCubit, WeatherBlocState>('data not empty',
        setUp: () async {
          dioAdapter.onGet(
            baseUrl,
            (server) => server.reply(200, data),
          );
        },
        build: () => WeatherBlocCubit(ApiRepository(Dio())),
        act: (bloc) => bloc.getWeatherList(lat: -4.0729, lon: 39.6684),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              isA<LoadingWeatherListBlocState>(),
              isA<ListWeatherBlocState>()
                ..having((p0) => p0.weather, 'description', 'clouds')
            ]);
  });
}
