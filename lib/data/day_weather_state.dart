import 'package:bhubtesttwo/models/weather_model.dart';

import '../models/forecast_model.dart';

abstract class DayWeatherBlocState {}

class InitDayWeatherBlocState extends DayWeatherBlocState {}

class LoadingDayWeatherState extends DayWeatherBlocState {}

class ErrorDayWeatherBlocState extends DayWeatherBlocState {
  final String errorMessage;
  ErrorDayWeatherBlocState(this.errorMessage);
}

class ResponseDayWeatherBlocState extends DayWeatherBlocState {
  WeatherModel response;
  String temp;
  String mintemp;
  String maxtemp;
  ResponseDayWeatherBlocState(
      this.response, this.temp, this.mintemp, this.maxtemp);
}
