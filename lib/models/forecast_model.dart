// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.list,
  });

  List<ListElement>? list;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.visibility,
    this.pop,
    this.dtTxt,
  });

  int? dt;
  MainClass? main;
  List<WeatherForecast>? weather;

  int? visibility;
  double? pop;

  DateTime? dtTxt;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: MainClass.fromJson(json["main"]),
        weather: List<WeatherForecast>.from(
            json["weather"].map((x) => WeatherForecast.fromJson(x))),
        visibility: json["visibility"],
        pop: json["pop"].toDouble(),
        dtTxt: DateTime.parse(json["dt_txt"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main!.toJson(),
        "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
        "visibility": visibility,
        "pop": pop,
        "dt_txt": dtTxt!.toIso8601String(),
      };
}

class MainClass {
  MainClass({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;
  double get getTemp => temp! - 273.15;
  double get getMaxTemp => tempMax! - 273.15;
  double get getMinTemp => tempMin! - 273.15;
  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
      };
}

class WeatherForecast {
  WeatherForecast({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int? id;
  MainEnum? main;
  Description? description;
  Icon? icon;

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      WeatherForecast(
        id: json["id"],
        main: mainEnumValues.map[json["main"]],
        description: descriptionValues.map[json["description"]],
        icon: iconValues.map[json["icon"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": mainEnumValues.reverse[main],
        "description": descriptionValues.reverse[description],
        "icon": iconValues.reverse[icon],
      };
}

enum Description {
  FEW_CLOUDS,
  SCATTERED_CLOUDS,
  OVERCAST_CLOUDS,
  LIGHT_RAIN,
  BROKEN_CLOUDS,
  CLEAR_SKY
}

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "clear sky": Description.CLEAR_SKY,
  "few clouds": Description.FEW_CLOUDS,
  "light rain": Description.LIGHT_RAIN,
  "overcast clouds": Description.OVERCAST_CLOUDS,
  "scattered clouds": Description.SCATTERED_CLOUDS
});

enum Icon { THE_04_N, THE_10_D, THE_04_D, THE_10_N }

final iconValues = EnumValues({
  "04d": Icon.THE_04_D,
  "04n": Icon.THE_04_N,
  "10d": Icon.THE_10_D,
  "10n": Icon.THE_10_N
});

enum MainEnum { CLOUDS, RAIN, CLEAR }

final mainEnumValues = EnumValues({
  "Clear": MainEnum.CLEAR,
  "Clouds": MainEnum.CLOUDS,
  "Rain": MainEnum.RAIN
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
