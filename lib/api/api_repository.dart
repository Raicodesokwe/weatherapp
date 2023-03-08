import 'package:dio/dio.dart';

import '../models/forecast_model.dart';
import '../models/weather_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final apiProvider = ApiProvider(Dio());
  Dio dio = Dio();
  ApiRepository(this.dio) {
    dio = Dio();

    /// Dependency Injection
    dio.options.baseUrl;
  }
  Future<WeatherModel> getWeather({double? lat, double? lon}) =>
      apiProvider.getWeather(lat: lat, lon: lon);
  Future<List<Weather>> getWeatherList({double? lat, double? lon}) =>
      apiProvider.getWeatherList(lat: lat, lon: lon);
  Future<List<ListElement>> getForecastList({double? lat, double? lon}) =>
      apiProvider.getForecast(lat: lat, lon: lon);
}
