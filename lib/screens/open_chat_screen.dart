import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/material_color.dart';
import 'package:mse_yonsei/constants/screen_size.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenChatScreen extends StatefulWidget {
  const OpenChatScreen({Key? key}) : super(key: key);

  @override
  _OpenChatScreenState createState() => _OpenChatScreenState();
}

class _OpenChatScreenState extends State<OpenChatScreen> {

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Open Chat'),backgroundColor: app_color,),
        body: Stack(
          children: [
            Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Background(file_name: 'homebackground')),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(height: 1,thickness: 1,color: Colors.white,),
                  ListTile(leading: Icon(Icons.account_tree_rounded,color: Colors.white,),title: Center(child: Text('수업관련 단톡방 만들기',style: TextStyle(color: Colors.white),)),onTap: (){
                    _launchURL('https://open.kakao.com/o/gCK4BrJd');
                  },),
                  Divider(height: 1,thickness: 1,color: Colors.white,),
                  ListTile(leading: Icon(Icons.volunteer_activism,color: Colors.white,),title: Center(child: Text('신소재 자유 사담방',style: TextStyle(color: Colors.white),)),onTap: (){
                    _launchURL('https://open.kakao.com/o/gDZhQrJd');
                  },),
                  Divider(height: 1,thickness: 1,color: Colors.white,),
                  ListTile(leading: Icon(Icons.add_comment_rounded,color: Colors.white,),title: Center(child: Text('건의 및 신고',style: TextStyle(color: Colors.white),)),onTap: (){
                    _launchURL('https://open.kakao.com/o/gxGhMrJd');
                  },),
                  Divider(height: 1,thickness: 1,color: Colors.white,),
                  SizedBox(height: size!.height/2.5,)
                ],
              ),
            ),
          ],
        )
    );
  }
}


/*
수업 단톡방 만들기 https://open.kakao.com/o/gCK4BrJd
자유 사담방 https://open.kakao.com/o/gDZhQrJd
건의 및 신고 https://open.kakao.com/o/gxGhMrJd
 */
