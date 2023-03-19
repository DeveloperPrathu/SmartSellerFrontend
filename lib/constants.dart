
import 'dart:ui';

import 'package:flutter/material.dart';

const DOMAIN_URL = "http:///10.0.2.2:8000";
// const HOST_URL = "http://10.0.2.2:8000";
const HOST_URL = "http://10.0.2.2:8000";
const BASE_URL = "$HOST_URL/api";
const UNAUTHENTICATED_USER = 'unauthenticated_user';

const EMAIL_REGEX = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

//THEME COLOR

const Map<int, Color> color = {
  50:Color.fromRGBO(128, 0, 128, .1),
  100:Color.fromRGBO(128, 0, 128, .2),
  200:Color.fromRGBO(128, 0, 128, .3),
  300:Color.fromRGBO(128, 0, 128, .4),
  400:Color.fromRGBO(128, 0, 128, .5),
  500:Color.fromRGBO(128, 0, 128, .6),
  600:Color.fromRGBO(128, 0, 128, .7),
  700:Color.fromRGBO(128, 0, 128, .8),
  800:Color.fromRGBO(128, 0, 128, .9),
  900:Color.fromRGBO(128, 0, 128, 1),
};

const PRIMARY_SWATCH = MaterialColor(0xff800080, color);
const SECONDARY_HEADER_COLOR = PRIMARY_SWATCH;

const INPUT_BORDER_COLOR = Color(0xffD9D9D9);

final OutlineInputBorder ENABLED_BORDER = OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: INPUT_BORDER_COLOR));
final OutlineInputBorder FOCUSED_BORDER = OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: PRIMARY_SWATCH, width: 2));
final OutlineInputBorder ERROR_BORDER = OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.red, width: 2));