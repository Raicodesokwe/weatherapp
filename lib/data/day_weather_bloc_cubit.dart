import 'package:bhubtesttwo/data/day_weather_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api_repository.dart';

class DayWeatherBlocCubit extends Cubit<DayWeatherBlocState> {
  final ApiRepository _repository;
  DayWeatherBlocCubit(this._repository) : super(InitDayWeatherBlocState());
  String? temp = '';
  String? mintemp = '';
  String? maxtemp = '';
  Future<void> getWeather({double? lat, double? lon}) async {
    emit(LoadingDayWeatherState());
    try {
      final response = await _repository.getWeather(lat: lat, lon: lon);
      temp = response.getTemp.round().toString();
      maxtemp = response.getMaxTemp.round().toString();
      mintemp = response.getMinTemp.round().toString();
      emit(ResponseDayWeatherBlocState(response, temp!, mintemp!, maxtemp!));
    } on Exception catch (e) {
      emit(ErrorDayWeatherBlocState(e.toString()));
    }
  }

  // Future<void> getWeatherForecastList({double? lat, double? lon}) async {
  //   emit(LoadingForecastListBlocState());
  //   try {
  //     final response = await _repository.getForecastList(lat: lat, lon: lon);

  //     emit(ForecastWeatherBlocState(response));
  //   } on Exception catch (e) {
  //     emit(ErrorWeatherBlocState(e.toString()));
  //   }
  // }
}
