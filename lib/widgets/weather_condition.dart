import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../data/weather_bloc_cubit.dart';
import '../data/weather_bloc_state.dart';

class WeatherCondition extends StatelessWidget {
  const WeatherCondition({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBlocCubit, WeatherBlocState>(
        builder: (context, state) {
      if (state is InitWeatherBlocState) {
        return Container();
      } else if (state is LoadingWeatherListBlocState) {
        return Column(
          children: [
            Shimmer.fromColors(
                child: Container(
                  width: size.width * 0.8,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(7)),
                ),
                baseColor: Colors.orange.withOpacity(0.7),
                highlightColor: Colors.orange.withOpacity(0.3)),
            SizedBox(
              height: 50,
            )
          ],
        );
      } else if (state is ListWeatherBlocState) {
        final weather = state.weather;
        return Text(
          weather.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
        );
      }
      return Container();
    });
  }
}
