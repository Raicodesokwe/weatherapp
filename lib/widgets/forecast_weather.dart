import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../data/forecast_weather_state.dart';
import '../data/forecast_weather_cubit.dart';

class ForecastWeather extends StatelessWidget {
  const ForecastWeather({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastBlocCubit, ForecastWeatherBlocState>(
        builder: (context, state) {
      if (state is InitForecastWeatherBlocState) {
        return Container();
      } else if (state is LoadingForecastState) {
        return Column(
          children: [
            Shimmer.fromColors(
                child: Container(
                  width: size.width * 0.8,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(7)),
                ),
                baseColor: Colors.blue.withOpacity(0.7),
                highlightColor: Colors.blue.withOpacity(0.3)),
            SizedBox(
              height: 50,
            )
          ],
        );
      } else if (state is ResponseForecastBlocState) {
        final dayOneWeather = state.dayOneWeather;
        final dayoneTemp = state.dayoneTemp;
        final dayTwoWeather = state.dayTwoWeather;
        final daytwoTemp = state.daytwoTemp;
        final dayThreeWeather = state.dayThreeWeather;
        final daythreeTemp = state.daythreeTemp;
        final dayFourWeather = state.dayFourWeather;
        final dayfourTemp = state.dayfourTemp;
        final dateOne = state.dateOne;
        final dateTwo = state.dateTwo;
        final dateThree = state.dateThree;
        final dateFour = state.dateFour;
        return Column(
          children: [
            Row(
              children: [
                Text(
                  '${DateFormat.E().format(dateOne)}',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                dayOneWeather == 'CLOUDS'
                    ? SvgPicture.asset(
                        'assets/images/cloudy.svg',
                        width: 25,
                        color: Colors.white,
                      )
                    : dayOneWeather == 'RAIN'
                        ? SvgPicture.asset(
                            'assets/images/rain.svg',
                            width: 25,
                            color: Colors.white,
                          )
                        : dayOneWeather == 'CLEAR'
                            ? SvgPicture.asset(
                                'assets/images/clear.svg',
                                width: 25,
                                color: Colors.white,
                              )
                            : Container(),
                Spacer(),
                Text(
                  '$dayoneTemp°',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  '${DateFormat.E().format(dateTwo)}',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                dayTwoWeather == 'CLOUDS'
                    ? SvgPicture.asset(
                        'assets/images/cloudy.svg',
                        width: 25,
                        color: Colors.white,
                      )
                    : dayTwoWeather == 'RAIN'
                        ? SvgPicture.asset(
                            'assets/images/rain.svg',
                            width: 25,
                            color: Colors.white,
                          )
                        : dayTwoWeather == 'CLEAR'
                            ? SvgPicture.asset(
                                'assets/images/clear.svg',
                                width: 25,
                                color: Colors.white,
                              )
                            : Container(),
                Spacer(),
                Text(
                  '$daytwoTemp°',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  '${DateFormat.E().format(dateThree)}',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                dayThreeWeather == 'CLOUDS'
                    ? SvgPicture.asset(
                        'assets/images/cloudy.svg',
                        width: 25,
                        color: Colors.white,
                      )
                    : dayThreeWeather == 'RAIN'
                        ? SvgPicture.asset(
                            'assets/images/rain.svg',
                            width: 25,
                            color: Colors.white,
                          )
                        : dayThreeWeather == 'CLEAR'
                            ? SvgPicture.asset(
                                'assets/images/clear.svg',
                                width: 25,
                                color: Colors.white,
                              )
                            : Container(),
                Spacer(),
                Text(
                  '$daythreeTemp°',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  '${DateFormat.E().format(dateFour)}',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                dayFourWeather == 'CLOUDS'
                    ? SvgPicture.asset(
                        'assets/images/cloudy.svg',
                        width: 25,
                        color: Colors.white,
                      )
                    : dayFourWeather == 'RAIN'
                        ? SvgPicture.asset(
                            'assets/images/rain.svg',
                            width: 25,
                            color: Colors.white,
                          )
                        : dayFourWeather == 'CLEAR'
                            ? SvgPicture.asset(
                                'assets/images/clear.svg',
                                width: 25,
                                color: Colors.white,
                              )
                            : Container(),
                Spacer(),
                Text(
                  '$dayfourTemp°',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ],
        );
      }
      return Container();
    });
  }
}
