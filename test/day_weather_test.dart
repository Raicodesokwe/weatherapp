import 'package:bhubtesttwo/api/api_repository.dart';
import 'package:bhubtesttwo/data/day_weather_bloc_cubit.dart';
import 'package:bhubtesttwo/data/day_weather_state.dart';
import 'package:bhubtesttwo/data/forecast_weather_state.dart';
import 'package:bhubtesttwo/data/forecast_weather_cubit.dart';

import 'package:bloc_test/bloc_test.dart';
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
    blocTest<DayWeatherBlocCubit, DayWeatherBlocState>('bloc empty data',
        setUp: () {
          return dioAdapter.onGet(
            baseUrl,
            (server) => server.reply(200, ''),
          );
        },
        build: () => DayWeatherBlocCubit(ApiRepository(Dio())),
        act: (bloc) => bloc.getWeather(lat: -4.0729, lon: 39.6684),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              isA<LoadingDayWeatherState>(),
              isA<ResponseDayWeatherBlocState>()
            ]);
    blocTest<DayWeatherBlocCubit, DayWeatherBlocState>('data not empty',
        setUp: () async {
          dioAdapter.onGet(
            baseUrl,
            (server) => server.reply(200, []),
          );
        },
        build: () => DayWeatherBlocCubit(ApiRepository(Dio())),
        act: (bloc) => bloc.getWeather(lat: -4.0729, lon: 39.6684),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              isA<LoadingDayWeatherState>(),
              isA<ResponseDayWeatherBlocState>()
                ..having((p0) => p0.temp, 'description', '279.97')
            ]);
  });
}
