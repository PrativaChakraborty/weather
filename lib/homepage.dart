import 'dart:async';
import 'dart:ui';

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/constants.dart';
import 'package:weather/daily_weather_model.dart';
import 'package:weather/hourly_forecast_model.dart';
import 'package:weather/location.dart';
import 'package:weather/weatherAPI.dart';
import 'package:date_calc/date_calc.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  Future<DailyWeatherResponse> dailyweather;
  HourlyWeatherResponse weatherData;
  var selectedIndex = 0;
  WeatherIcon currentWeather;
  WeatherIcon nightCurrentWeather;
  WeatherIcon nightCurrentWeather1;

  @override
  void initState() {
    super.initState();
    _fetchApi();
    _controller = TabController(length: 3, initialIndex: 0, vsync: this);
  }

  _fetchApi() async {
    weatherData = await WeatherServices.getHourlyForecast();
    selectedWeatherData = weatherData.list.where((element) {
      return DateCalc.now()
          .addDay(_controller.index)
          .isSameDay(DateTime.fromMillisecondsSinceEpoch(element.dt * 1000));
    }).toList();
    setState(() {});
    _controller.addListener(() {
      _updateWeatherData();
    });
  }

  _updateWeatherData() async {
    print("start");
    selectedWeatherData.clear();
    setState(() {});

    // await Future.delayed(Duration(milliseconds: 100), () {
    setState(() {
      selectedWeatherData.addAll(weatherData.list.where((element) {
        return DateCalc.now()
            .addDay(_controller.index)
            .isSameDay(DateTime.fromMillisecondsSinceEpoch(element.dt * 1000));
      }).toList());
      // });

      print("end");
    });
  }

  List<HourlyList> selectedWeatherData = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: weatherData != null
            ? Stack(
                children: [
                  Positioned.fill(
                    child: TabBarView(
                      controller: _controller,
                      children: List.generate(3, (index) {
                        return buildMainContainer(
                            context,
                            weatherData.list.where((element) {
                              return DateCalc.now().addDay(index).isSameDay(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      element.dt * 1000));
                            }).toList());
                      }),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          TabBar(
                            controller: _controller,
                            indicatorColor: Colors.transparent,
                            tabs: List.generate(3, (index) {
                              String date = DateTimeFormat.format(
                                  DateCalc.now().addDay(index),
                                  format: 'D, M j');
                              return buildText(date);
                            }),
                            labelStyle: TextStyle(fontWeight: FontWeight.w700),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey[600],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.18,
                            child: LiveList(
                                scrollDirection: Axis.horizontal,
                                itemCount: selectedWeatherData.length,
                                showItemInterval: Duration(milliseconds: 0),
                                showItemDuration: Duration(milliseconds: 350),
                                reAnimateOnVisibility: true,
                                itemBuilder: (
                                  context,
                                  index,
                                  Animation<double> animation,
                                ) {
                                  return FadeTransition(
                                    opacity: Tween<double>(
                                      begin: 0,
                                      end: 1,
                                    ).animate(animation),
                                    // And slide transition
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: Offset(0, -0.1),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      // Paste you Widget
                                      child: buildContainer(
                                          selectedWeatherData[index]),
                                    ),
                                  );
                                }),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 25))
                        ],
                      ))
                ],
              )
            : Container(
                color: Colors.lightBlue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Getting Weather Details',
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SpinKitChasingDots(color: Colors.white)
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildContainer(HourlyList data) {
    String time = DateTimeFormat.format(
        DateCalc.fromDateTime(
            DateTime.fromMillisecondsSinceEpoch(data.dt * 1000)),
        format: 'h:i A');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                time,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                mapFAIcons[data.weather[0].icon],
                color: Colors.grey[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Text(
                '${data.main.temp.toInt()}°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildMainContainer(
      BuildContext context, List<HourlyList> weatherData) {
    List<DateTime> dates = weatherData
        .map((e) => DateTime.fromMillisecondsSinceEpoch(e.dt * 1000))
        .toList();

    final closetsDateTimeToNow = dates.reduce((a, b) =>
        a.difference(DateTime.now()).abs() < b.difference(DateTime.now()).abs()
            ? a
            : b);
    int currentIndex = dates.indexOf(closetsDateTimeToNow);
    var i = dayWeatherList.indexWhere((element) =>
        weatherData[currentIndex].weather[0].icon == element.iconPath);
    WeatherIcon weather = dayWeatherList[i];
    return Container(
      decoration: BoxDecoration(
        gradient: weather.weatherGradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.location_on,
                  color: weather.fontcolor,
                ),
                Text(
                  'Naihati',
                  style: GoogleFonts.ubuntu(
                      color: weather.fontcolor,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  child: FaIcon(
                    FontAwesomeIcons.search,
                    color: weather.fontcolor,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Location()));
                  },
                ),
              ],
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          // FractionallySizedBox(
          //   heightFactor: 0.02,
          // ),

          Container(
            child: Center(
              child: Image(
                image: AssetImage('assets/images/${weather.iconPath}.png'),
                height: 200,
                width: 200,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Center(
            child: Text(weatherData[currentIndex].weather[0].description,
                style: GoogleFonts.ubuntu(
                  color: weather.fontcolor.withOpacity(0.8),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  weatherData[currentIndex].main.temp.toInt().toString(),
                  style: GoogleFonts.ubuntu(
                      color: weather.fontcolor, fontSize: 100),
                ),
              ),
              Text(
                "°",
                style: TextStyle(color: weather.fontcolor, fontSize: 70),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FaIcon(
                  FontAwesomeIcons.wind,
                  color: secondaryFontColor,
                  size: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '${weatherData[currentIndex].wind.speed} km/h',
                  style: GoogleFonts.ubuntu(
                      color: secondaryFontColor, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FaIcon(
                  FontAwesomeIcons.tint,
                  color: secondaryFontColor,
                  size: 15,
                ),
              ),
              Text(
                '${weatherData[currentIndex].main.humidity} %',
                style:
                    GoogleFonts.ubuntu(color: secondaryFontColor, fontSize: 15),
              ),
            ],
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.1,
          // ),
          Spacer(),
        ],
      ),
    );
  }

  Widget buildText(String date) {
    return Text(
      date,
    );
  }
}

class CardsView extends StatelessWidget {
  const CardsView({
    Key key,
    @required this.selectedWeatherData,
  }) : super(key: key);

  final List<HourlyList> selectedWeatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      child: LiveList(
          scrollDirection: Axis.horizontal,
          itemCount: selectedWeatherData.length,
          showItemInterval: Duration(milliseconds: 150),
          showItemDuration: Duration(milliseconds: 350),
          itemBuilder: (
            context,
            index,
            Animation<double> animation,
          ) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              // And slide transition
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, -0.1),
                  end: Offset.zero,
                ).animate(animation),
                // Paste you Widget
                child: buildContainer(selectedWeatherData[index]),
              ),
            );
          }),
    );
  }

  Widget buildContainer(HourlyList data) {
    String time = DateTimeFormat.format(
        DateCalc.fromDateTime(
            DateTime.fromMillisecondsSinceEpoch(data.dt * 1000)),
        format: 'h:i A');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                time,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                mapFAIcons[data.weather[0].icon],
                color: Colors.grey[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Text(
                '${data.main.temp.toInt()}°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class WeatherIcon {
  LinearGradient weatherGradient;
  String iconPath;
  String weatherCondition;
  Color fontcolor;
  WeatherIcon(this.weatherGradient, this.iconPath, this.weatherCondition,
      this.fontcolor);
  static LinearGradient getGradientFromColors(List<Color> colors) {
    return LinearGradient(
        colors: colors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
  }
}

Color fontcolor = Color(0xff2F2E62);
Color secondaryFontColor = Colors.grey[600].withOpacity(0.8);
