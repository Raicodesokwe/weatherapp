import 'package:bhubtesttwo/models/weather_model.dart';

import '../models/forecast_model.dart';

abstract class WeatherBlocState {}

class InitWeatherBlocState extends WeatherBlocState {}

class LoadingWeatherListBlocState extends WeatherBlocState {}

class ErrorWeatherBlocState extends WeatherBlocState {
  final String errorMessage;
  ErrorWeatherBlocState(this.errorMessage);
}

class ListWeatherBlocState extends WeatherBlocState {
  List<Weather> response;
  final String weather;
  ListWeatherBlocState(this.response, this.weather);
}
