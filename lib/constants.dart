import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/homepage.dart';

List<WeatherIcon> dayWeatherList = [
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xffDDEBBE), Color(0xff508AE1)]),
      '01d',
      'clear sky',
      Color(0xff2F2E62)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff6EF8E6), Color(0xff72EFED)]),
      '02d',
      'few clouds',
      Color(0xff2F2E62)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff619AB8), Color(0xff65D1CF)]),
      '03d',
      'scattered clouds',
      Color(0xff2F2E62)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff5A8DAB), Color(0xff7CC5DE)]),
      '04d',
      'broken clouds',
      Color(0xff2F2E62)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff0080C8), Color(0xff00CFF4)]),
      '09d',
      'shower rain',
      Color(0xff2F2E62)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff5ADBFD), Color(0xff5ACBFA)]),
      '10d',
      'rain',
      Color(0xff2F2E62)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff005C69), Color(0xff2A7CB3)]),
      '11d',
      'thunderstorm',
      Color(0xff2F2E62)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff677FA5), Color(0xff9ABCE5)]),
      '13d',
      'snow',
      Color(0xff2F2E62)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xffD6E1E6), Color(0xff133A38)]),
      '50d',
      'mist',
      Color(0xff2F2E62)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff2A4F79), Color(0xff061D52)]),
      '01n',
      'clear sky',
      Color(0xffB3BDE7)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff013779), Color(0xff01142B)]),
      '02n',
      'few clouds',
      Color(0xffB3BDE7)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff416378), Color(0xff000813)]),
      '03n',
      'scattered clouds',
      Color(0xffB3BDE7)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff23292E), Color(0xff0D2C43)]),
      '04n',
      'broken clouds',
      Color(0xffB3BDE7)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff1E2A64), Color(0xff164C78)]),
      '09n',
      'shower rain',
      Color(0xffB3BDE7)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff3A8ED2), Color(0xff000622)]),
      '10n',
      'rain',
      Color(0xffB3BDE7)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff005C69), Color(0xff2A7CB3)]),
      '11n',
      'thunderstorm',
      Color(0xffB3BDE7)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xff677FA5), Color(0xff000622)]),
      '13n',
      'snow',
      Color(0xffB3BDE7)),
  WeatherIcon(
      WeatherIcon.getGradientFromColors([Color(0xffD6E1E6), Color(0xff000622)]),
      '50n',
      'mist',
      Color(0xffB3BDE7)),
];

List<WeatherIcon> nightWeatherList = [];

Map<String, IconData> mapFAIcons = {
  "01d": FontAwesomeIcons.solidSun,
  '01n': FontAwesomeIcons.moon,
  '02d': FontAwesomeIcons.cloudSun,
  '02n': FontAwesomeIcons.cloudMoon,
  '03d': FontAwesomeIcons.cloud,
  '03n': FontAwesomeIcons.cloud,
  '04d': FontAwesomeIcons.cloud,
  '04n': FontAwesomeIcons.cloud,
  '09d': FontAwesomeIcons.cloudShowersHeavy,
  '09n': FontAwesomeIcons.cloudShowersHeavy,
  '10d': FontAwesomeIcons.cloudRain,
  '10n': FontAwesomeIcons.cloudRain,
  '11d': FontAwesomeIcons.bolt,
  '11n': FontAwesomeIcons.bolt,
  '13d': FontAwesomeIcons.snowflake,
  '13n': FontAwesomeIcons.snowflake,
  '50d': FontAwesomeIcons.smog,
  '50n': FontAwesomeIcons.smog,
};
