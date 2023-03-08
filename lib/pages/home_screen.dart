import 'package:bhubtesttwo/data/day_weather_bloc_cubit.dart';

import 'package:bhubtesttwo/data/forecast_weather_cubit.dart';
import 'package:bhubtesttwo/data/weather_bloc_cubit.dart';
import 'package:bhubtesttwo/data/weather_bloc_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:shimmer/shimmer.dart';

import '../models/forecast_model.dart' as fm;
import '../widgets/day_weather.dart';
import '../widgets/forecast_weather.dart';
import '../widgets/min_max_temp.dart';
import '../widgets/weather_condition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? latitude;
  double? longitude;
  Future<List<fm.ListElement>>? washesCount;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getCurrentLocation();
    _updatePosition();
  }

  Future<void> _updatePosition() async {
    try {
      Position pos = await _determinePosition();
      List<Placemark> p =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      setState(() {
        latitude = pos.latitude;
        longitude = pos.longitude;
        final weatherReadings = context.read<WeatherBlocCubit>();
        final dayWeatherReadings = context.read<DayWeatherBlocCubit>();
        final forecastReadings = context.read<ForecastBlocCubit>();
        dayWeatherReadings.getWeather(lat: latitude, lon: longitude);
        weatherReadings.getWeatherList(lat: latitude, lon: longitude);
        forecastReadings.getWeatherForecastList(lat: latitude, lon: longitude);
      });
    } on Exception catch (e) {
      // TODO
      throw Exception(e.toString());
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Please open settings and turn on location then click the reload button'),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          onPrimary: Colors.white,
                          elevation: 7),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Ok',
                      ))
                ],
              ),
            );
          });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            Future.delayed(const Duration(seconds: 5))
                .then((value) => _updatePosition());
          });
          await _updatePosition();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                BlocBuilder<WeatherBlocCubit, WeatherBlocState>(
                    builder: (context, state) {
                  if (state is InitWeatherBlocState) {
                    return InkWell(
                      onTap: () {
                        print('pressed pressed');
                        _updatePosition();
                      },
                      child: Icon(
                        Icons.replay_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    );
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
                  } else if (state is ErrorWeatherBlocState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning,
                            size: 70,
                          ),
                          Text(
                            state.errorMessage,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24),
                          ),
                        ],
                      ),
                    );
                  } else if (state is ListWeatherBlocState) {
                    final weather = state.weather;
                    return Row(
                      children: [
                        weather == 'Clouds'
                            ? Align(
                                alignment: Alignment.topLeft,
                                child: SvgPicture.asset(
                                  'assets/images/cloudy.svg',
                                  width: size.width * 0.4,
                                  color: Colors.white,
                                ),
                              )
                            : weather == 'Rain'
                                ? Align(
                                    alignment: Alignment.topLeft,
                                    child: SvgPicture.asset(
                                      'assets/images/rain.svg',
                                      width: size.width * 0.4,
                                      color: Colors.white,
                                    ),
                                  )
                                : weather == 'Sun'
                                    ? Align(
                                        alignment: Alignment.topLeft,
                                        child: SvgPicture.asset(
                                          'assets/images/sun.svg',
                                          width: size.width * 0.4,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Container(),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            _updatePosition();
                          },
                          child: Icon(
                            Icons.replay_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                }),
                Row(
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        DayWeather(size: size),
                        WeatherCondition(size: size),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.13,
                ),
                MinMaxTemp(size: size),
                Divider(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),
                ForecastWeather(size: size),
              ],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage('assets/images/sunnysea.png')),
      ),
    ));
  }
}
