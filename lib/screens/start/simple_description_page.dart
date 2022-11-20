import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/material_color.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:provider/src/provider.dart';

class SimpleDescriptionPage extends StatelessWidget {
  const SimpleDescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Opacity(opacity:0.2,child: Background(file_name: 'yonsei_mse')),
            ListView(children: [
              ExtendedImage.asset(
                'assets/images/intro.jpg',
                fit: BoxFit.cover,
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      context.read<PageController>().animateToPage(2,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: Text('메인 페이지에서 클릭하고자 하는 항목을 꾹 눌러주세요. \n\n스크롤 할 때 실수로 누르는 것을 방지합니다.',style: TextStyle(color: app_color, fontSize: 24,
                        // fontStyle: FontStyle.italic,
                        fontFamily: 'DonghyunKo'),)),
              ),

            ],)
          ],
        ));
  }
}
