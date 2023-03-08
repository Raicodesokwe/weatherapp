import 'package:bhubtesttwo/data/weather_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api_repository.dart';

class WeatherBlocCubit extends Cubit<WeatherBlocState> {
  final ApiRepository _repository;
  WeatherBlocCubit(this._repository) : super(InitWeatherBlocState());

  String? weather = '';
  Future<void> getWeatherList({double? lat, double? lon}) async {
    emit(LoadingWeatherListBlocState());
    try {
      final response = await _repository.getWeatherList(lat: lat, lon: lon);
      weather = response[0].main;
      emit(ListWeatherBlocState(response, weather!));
    } on Exception catch (e) {
      emit(ErrorWeatherBlocState('Failed to get the weather report'));
    }
  }
}
