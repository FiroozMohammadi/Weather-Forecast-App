import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_forecast_app/widgets.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final WeatherFactory wf = WeatherFactory(WeatherAPI);
  // ignore: unused_field
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    wf.currentWeatherByCityName("Afghanistan").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MyUI(),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          textWidgets(_weather?.areaName ?? "Afghanistan", 28, FontWeight.w600,
              const Color.fromARGB(255, 4, 80, 167)),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          datTime(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          weatherIconImage(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          textWidgets(
              "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
              70,
              FontWeight.w600,
              Colors.black),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.03,
          ),
          weatherInformation(),
        ],
      ),
    );
  }

  Widget datTime() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        textWidgets(DateFormat("h:mm a").format(now), 18, FontWeight.w500,
            Colors.black),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            textWidgets(DateFormat("EEEE").format(now), 18, FontWeight.w500,
                Colors.black),
            textWidgets(" ${DateFormat("d/m/y").format(now)}", 18,
                FontWeight.w500, Colors.black),
          ],
        )
      ],
    );
  }

  Widget weatherIconImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://static.vecteezy.com/system/resources/previews/007/488/951/original/light-snow-color-icon-winter-snowy-weather-cloud-and-snowflake-weather-forecast-isolated-illustration-vector.jpg"))),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.02,
        ),
        textWidgets(_weather?.weatherDescription ?? "", 18, FontWeight.w500,
            Colors.black),
      ],
    );
  }

  Widget weatherInformation() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.17,
      width: MediaQuery.sizeOf(context).width * 0.8,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textWidgets(
                  "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                  15,
                  FontWeight.normal,
                  Colors.black),
              textWidgets(
                  "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                  15,
                  FontWeight.normal,
                  Colors.black)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textWidgets(
                  "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
                  15,
                  FontWeight.normal,
                  Colors.black),
              textWidgets(
                  "Humidity: ${_weather?.humidity?.toStringAsFixed(0)} %",
                  15,
                  FontWeight.normal,
                  Colors.black)
            ],
          )
        ],
      ),
    );
  }
}
