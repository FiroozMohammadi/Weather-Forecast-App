import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

void main() => runApp(
      const MaterialApp(
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final WeatherFactory wf = WeatherFactory('856822fd8e22db5e1ba48c0e7d69844a');
  // ignore: unused_field
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    wf.currentWeatherByCityName("London").then((w) {
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
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            _weather?.areaName ?? "",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          datTime(),
        ],
      ),
    );
  }

  Widget datTime() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(DateFormat("h:mm a").format(now)),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(DateFormat("EEEE").format(now),
                style: const TextStyle(fontSize: 14)),
            Text(
              " ${DateFormat("d.m.y").format(now)}",
              style: const TextStyle(fontSize: 14),
            ),
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
                      "https://cdn.jim-nielsen.com/ios/512/weather-2021-12-07.png"))),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
