import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../data/day_weather_bloc_cubit.dart';
import '../data/day_weather_state.dart';

class DayWeather extends StatelessWidget {
  const DayWeather({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayWeatherBlocCubit, DayWeatherBlocState>(
        builder: (context, state) {
      if (state is InitDayWeatherBlocState) {
        return Container();
      } else if (state is LoadingDayWeatherState) {
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
      } else if (state is ResponseDayWeatherBlocState) {
        final temp = state.temp;
        return Text(
          '$temp°',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),
        );
      }
      return Container();
    });
  }
}
