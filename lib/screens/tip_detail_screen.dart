import 'package:flutter/material.dart';
import 'package:mse_yonsei/model/firestore/tip_model.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:url_launcher/url_launcher.dart';

class TipDetailScreen extends StatelessWidget {
  final TipModel tipModel;

  const TipDetailScreen({Key? key, required this.tipModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    void _launchURL(String url) async =>
        await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

    return Scaffold(
      appBar: AppBar(
        title: Text(tipModel.name!),
      ),
      body: Stack(children: [
        Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Background(file_name: 'homebackground')),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 5,),
          child: ListView(
            children: [
              Row(
                children: [
                  Text(
                    '작성자 : ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(tipModel.writer!,style: TextStyle(fontSize: 17, color: Colors.white),)
                ],
              ),
              SizedBox(height: 4,),
              Row(
                children: [
                  Text(
                    '작성일자 : ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text('${tipModel.postTime!.year}년 ${tipModel.postTime!.month}월 ${tipModel.postTime!.day}일',style: TextStyle(fontSize: 17, color: Colors.white),)
                ],
              ),
              SizedBox(height: 20,),
              Text(tipModel.description!.replaceAll("\\n", "\n"),style: TextStyle(fontSize: 17, color: Colors.white),),
              SizedBox(height: 20,),
              if(tipModel.url != null && tipModel.url != '')
                InkWell(
                    onTap: (){
                      _launchURL('https://open.kakao.com/o/gCK4BrJd');
                    },
                    child: Container(child: Text('본문의 해당 링크로 이동하기',style: TextStyle(decoration: TextDecoration.underline, color: Colors.white, fontSize: 17),),)),
            ],
          ),
        ),
      ]),
    );
  }
}
