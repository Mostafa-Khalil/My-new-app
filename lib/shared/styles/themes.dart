 import 'package:darsh/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme =  ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor:defaultColor,
  ),
  appBarTheme: AppBarTheme(
    backwardsCompatibility:false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    color: HexColor('333739'),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey,
    elevation: 50,
    backgroundColor:HexColor('333739'),
    selectedIconTheme: IconThemeData(
      color:Colors.deepOrange,
    ),
  ),
  textTheme: TextTheme(
    bodyText1:TextStyle(
      fontSize:17,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  appBarTheme: AppBarTheme(
    backwardsCompatibility:false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    color: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    elevation: 0,

  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 50,
    backgroundColor: Colors.white,
    selectedIconTheme: IconThemeData(
      color:Colors.deepOrange,
    ),
  ),
  textTheme: TextTheme(
    bodyText1:TextStyle(
      fontSize:17,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
);