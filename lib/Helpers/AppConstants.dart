import 'dart:ui';
import 'package:flutter/material.dart';
import 'LayoutHelper.dart';

const String API_KEY = "apiKey=43178e3ba06e4c4cb9976b08d5f0ef9f";
const String API_TOP_HEADLINES = "https://newsapi.org/v2/top-headlines?";
const String API_SEARCH = "https://newsapi.org/v2/everything?q=";
const String COUNTRY_CODE = "country=in&";

const Color BLUE_TEXT_COLOR = Color(0xFFF3C40C6);
const Color LIGHT_BLUE_TEXT_COLOR = Color(0xFFF5D9DFF);
const Color BLACK_TEXT_COLOR = Color(0xFF000000);

const TextStyle regularTxtStyleWithNoSize = TextStyle(
  color: Colors.black,
);

TextStyle smallTxtStyle = TextStyle(
  fontSize: LayoutHelper.instance.fontSize - 4,
  color: BLUE_TEXT_COLOR,
);

TextStyle smallTxtStyleBold = TextStyle(
    fontSize: LayoutHelper.instance.fontSize - 4,
    color: BLUE_TEXT_COLOR,
    fontWeight: FontWeight.w600);

TextStyle regularTxtStyle = TextStyle(
  fontSize: LayoutHelper.instance.fontSize - 2,
  color: BLUE_TEXT_COLOR,
);

TextStyle regularTxtStyleBlack = TextStyle(
  fontSize: LayoutHelper.instance.fontSize - 2,
  color: Colors.black,
);

TextStyle medTxtStyle = TextStyle(
  fontSize: LayoutHelper.instance.fontSize,
  color: BLUE_TEXT_COLOR,
);
TextStyle largeTxtStyle = TextStyle(
  fontSize: LayoutHelper.instance.fontSize + 2,
  color: BLACK_TEXT_COLOR,
);
TextStyle menuTxtStyleSemiBold = TextStyle(
    fontSize: LayoutHelper.instance.fontSize + 2,
    color: Colors.black,
    fontWeight: FontWeight.w600);

TextStyle medTxtStyleSemiBold = TextStyle(
    fontSize: LayoutHelper.instance.fontSize,
    color: BLUE_TEXT_COLOR,
    fontWeight: FontWeight.w600);

TextStyle medTxtStyleSemiBoldBlack = TextStyle(
    fontSize: LayoutHelper.instance.fontSize,
    color: Colors.black,
    fontWeight: FontWeight.w600);

TextStyle semiBoldTxtStyle = TextStyle(
    fontSize: LayoutHelper.instance.fontSize - 2,
    color: BLACK_TEXT_COLOR,
    fontWeight: FontWeight.w600);

TextStyle boldTxtStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: LayoutHelper.instance.fontSize + 2,
  color: BLACK_TEXT_COLOR,
);

TextStyle extraLightTxtStyle = TextStyle(
  fontSize: LayoutHelper.instance.fontSize,
  color: BLUE_TEXT_COLOR,
);
