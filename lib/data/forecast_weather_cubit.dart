import 'package:bhubtesttwo/data/forecast_weather_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api_repository.dart';

class ForecastBlocCubit extends Cubit<ForecastWeatherBlocState> {
  final ApiRepository _repository;
  ForecastBlocCubit(this._repository) : super(InitForecastWeatherBlocState());

  String dayoneTemp = '';
  String daytwoTemp = '';
  String daythreeTemp = '';
  String dayfourTemp = '';
  String dayfiveTemp = '';
  String? dayOneWeather = '';
  String? dayTwoWeather = '';
  String? dayThreeWeather = '';
  String? dayFourWeather = '';
  String? dayFiveWeather = '';
  DateTime? dateOne;
  DateTime? dateTwo;
  DateTime? dateThree;
  DateTime? dateFour;
  Future<void> getWeatherForecastList({double? lat, double? lon}) async {
    emit(LoadingForecastState());
    try {
      final response = await _repository.getForecastList(lat: lat, lon: lon);
      dayoneTemp = response[10].main!.getTemp.round().toString();
      daytwoTemp = response[15].main!.getTemp.round().toString();
      daythreeTemp = response[23].main!.getTemp.round().toString();
      dayfourTemp = response[30].main!.getTemp.round().toString();
      dayOneWeather = response[10].weather![0].main.toString().split('.').last;
      dayTwoWeather = response[15].weather![0].main.toString().split('.').last;
      dayThreeWeather =
          response[23].weather![0].main.toString().split('.').last;
      dayFourWeather = response[30].weather![0].main.toString().split('.').last;
      dateOne = response[10].dtTxt;
      dateTwo = response[15].dtTxt;
      dateThree = response[23].dtTxt;
      dateFour = response[30].dtTxt;
      emit(ResponseForecastBlocState(
          response,
          dayoneTemp,
          daytwoTemp,
          daythreeTemp,
          dayfourTemp,
          dayOneWeather,
          dayTwoWeather,
          dayThreeWeather,
          dayFourWeather,
          dateOne!,
          dateTwo!,
          dateThree!,
          dateFour!));
    } on Exception catch (e) {
      emit(ErrorForecastBlocState(e.toString()));
    }
  }
}
