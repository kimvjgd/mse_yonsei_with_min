import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/app_color.dart';

class AppState extends ChangeNotifier {


  final List<MaterialColor> _app_color_list = [
    app_blue,
    app_green,
    app_red,
    app_black,
  ];

  final List<MaterialAccentColor> _divider_list = [
    Colors.redAccent,
    Colors.lightGreenAccent,
    Colors.limeAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
  ];

  final List<String> _app_colort_text_list = [
    'app_blue',
    'app_green',
    'app_red',
    'app_black',
  ];

  final List<String> _divider_text_list = [
    'redAccent',
    'lightGreenAccent',
    'limeAccent',
    'orangeAccent',
    'purpleAccent',
  ];


  MaterialColor app_color = app_blue;
  MaterialAccentColor divider_color = Colors.lightGreenAccent;
  final Color button_color = Colors.blueGrey.withOpacity(0.1);
  final Color button_text_color = Colors.white.withOpacity(0.5);
  final String app_fontFamily = 'DonghyunEn';
  List<String> get divider_color_text_list => _divider_text_list;
  List<MaterialAccentColor> get divider_color_list => _divider_list;

  List<String> get app_color_text_list => _app_colort_text_list;

  void setAppColor(int index) async{
    app_color = _app_color_list[index];
    // userData.write(APP_COLOR, app_color);
    notifyListeners();
  }
  void setDividerColor(int index) {
    divider_color = divider_color_list[index];
    notifyListeners();
  }

  void initAppColor(MaterialColor color) {
    app_color = color;
    notifyListeners();
  }
}