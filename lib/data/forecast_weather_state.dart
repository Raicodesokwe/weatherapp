import '../models/forecast_model.dart';

abstract class ForecastWeatherBlocState {}

class InitForecastWeatherBlocState extends ForecastWeatherBlocState {}

class LoadingForecastState extends ForecastWeatherBlocState {}

class ErrorForecastBlocState extends ForecastWeatherBlocState {
  final String errorMessage;
  ErrorForecastBlocState(this.errorMessage);
}

class ResponseForecastBlocState extends ForecastWeatherBlocState {
  List<ListElement> response;
  String dayoneTemp;

  String daytwoTemp;
  String daythreeTemp;
  String dayfourTemp;

  String? dayOneWeather;
  String? dayTwoWeather;
  String? dayThreeWeather;
  String? dayFourWeather;
  DateTime dateOne;
  DateTime dateTwo;
  DateTime dateThree;
  DateTime dateFour;

  ResponseForecastBlocState(
      this.response,
      this.dayoneTemp,
      this.daytwoTemp,
      this.daythreeTemp,
      this.dayfourTemp,
      this.dayOneWeather,
      this.dayTwoWeather,
      this.dayThreeWeather,
      this.dayFourWeather,
      this.dateOne,
      this.dateTwo,
      this.dateThree,
      this.dateFour);
}
