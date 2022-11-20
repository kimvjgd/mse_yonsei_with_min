import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/material_color.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:provider/provider.dart';


class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Container(child: Opacity(opacity:0.2,child: Background(file_name: 'yonsei_mse'))),
            ListView(children: [
              TextButton(
                  onPressed: () {
                    context.read<PageController>().animateToPage(2,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  child: Text("""Intro\n

개인이 취미로 만들었기 때문에 부족함이 많습니다.\n
혹시 오류가 있거나 디자인이나 기능면에서 변경하고자 하는 것이 있으면
세팅 화면에 기재된 메일이나 카톡으로 편하게 문의주세요.
""",style: TextStyle(color: app_color, fontSize: 24,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'DonghyunKo'),))


            ],)
                      ],
        ));
  }
}
