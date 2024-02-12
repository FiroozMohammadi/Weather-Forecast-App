import 'package:flutter/material.dart';

Widget textWidgets(
    String name, double fontSize, FontWeight fontWeight, Color color) {
  return Text(
    name,
    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
  );
}

const WeatherAPI =
    "4aad110c-c9d1-11ee-8309-0242ac130002-4aad11fc-c9d1-11ee-8309-0242ac130002";
