import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:weather/hourly_forecast_model.dart';
import 'dart:async';

import 'daily_weather_model.dart';

const appId = '6e9ca79c8cfa4fe4f5890d97ecd56407';

class WeatherServices {
  static Future<DailyWeatherResponse> getDailyForecast() async {
    String url =
        'https://openweathermap.org/data/2.5/forecast/daily?id=1258546&cnt=7&lang=en&appid=439d4b804bc8187953eb36d2a8c26a02&_=1620381466772';
    var response = await http.get(Uri.parse(url));
    DailyWeatherResponse dailyWeatherResponse =
        dailyWeatherResponseFromJson(response.body);
    return dailyWeatherResponse;
  }

  static Future<HourlyWeatherResponse> getHourlyForecast() async {
    String url =
        'https://openweathermap.org/data/2.5/forecast/hourly?id=1258546&lang=en&appid=439d4b804bc8187953eb36d2a8c26a02&_=1620381466772';
    var response = await http.get(Uri.parse(url));
    HourlyWeatherResponse hourlyWeatherResponse =
        hourlyWeatherResponseFromJson(response.body);
    return hourlyWeatherResponse;
  }
}
