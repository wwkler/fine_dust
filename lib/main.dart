import 'package:fine_dust_practice/component/home_Screen.dart';
import 'package:fine_dust_practice/const/const.dart';
import 'package:fine_dust_practice/model/stat_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

void main() async {
  await Hive.initFlutter();

  // Adapter 등록
  Hive.registerAdapter(StatModelAdapter());
  Hive.registerAdapter(ItemCodeAdapter());

  // PM10, PM25 ... 이름을 가진 Box를 연다.
  for (ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(
        navigateRoute: const HomeScreen(),
        duration: Duration(milliseconds: 5000),
        backgroundColor: BLUE_COLOR,
        text: WavyAnimatedText(
          "내안의 미먼 앱",
          textStyle: kanitFont.copyWith(color: Colors.black),
        ),
        imageSrc: "assets/imgs/dust-g8634dece3_1280.jpg", 
        logoSize: 200,
      ),
    ),
  );
}
