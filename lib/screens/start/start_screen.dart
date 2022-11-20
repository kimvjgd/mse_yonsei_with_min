import 'package:flutter/material.dart';
import 'package:mse_yonsei/screens/start/auth_page.dart';
import 'package:mse_yonsei/screens/start/intro_page.dart';
import 'package:mse_yonsei/screens/start/simple_description_page.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  PageController _pageController = PageController();



  @override
  Widget build(BuildContext context) {
    return ListenableProvider<PageController>.value(
      value: _pageController,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background(file_name: 'yonsei_mse'),
            Opacity(opacity:0.2,child: Background(file_name: 'yonsei_mse')),
            PageView(
              controller: _pageController,
              children: [
                IntroPage(),
                SimpleDescriptionPage(),
                AuthPage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
