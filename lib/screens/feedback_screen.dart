import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/material_color.dart';
import 'package:mse_yonsei/constants/screen_size.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '추가 및 수정 요청',
          style: TextStyle(fontFamily: 'DonghyunKo', color: Colors.white),
        ),
        backgroundColor: app_color,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Background(file_name: 'homebackground')),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Yonsei MSE',
                    style: TextStyle(
                        fontFamily: 'DonghyunEn',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(height: 10),
                  _buildText('추후에 종합하여 많은 수정사항을 \n보내주신 분께 소정의 기프티콘을 드립니다.\n'),
                  _buildText(
                      '따라서 수정사항 or 추가일정을 보낼때 \n본인의 카톡아이디를 남겨주시기 바랍니다.\n'),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '문의\n\n',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        _buildText('email : mseyonseiapp@gmail.com\n'),
                        _buildTextButton(
                            context, 'kakao talk : Clicked Here\n'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size!.height * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.white),
    );
  }

  Widget _buildTextButton(BuildContext context, String text) {
    return TextButton(
        onPressed: () {
          _launchURL('https://open.kakao.com/o/gxGhMrJd');
        },
        child: RichText(
            text: TextSpan(text: 'KakaoTalk : ', children: [
          TextSpan(
              text: 'CLICK HERE',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline))
        ])));
  }
}
