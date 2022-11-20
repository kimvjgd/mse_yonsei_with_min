
import 'package:flutter/material.dart';
import 'package:mse_yonsei/screens/my_collection_screen.dart';
import 'package:mse_yonsei/screens/notice_screen.dart';
import 'package:mse_yonsei/screens/open_chat_screen.dart';
import 'package:mse_yonsei/screens/setting_screen.dart';
import 'package:mse_yonsei/screens/tip_screen.dart';

class NavigationDrawer extends StatelessWidget {
  final String notice_trigger;
  NavigationDrawer(this.notice_trigger);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(title: Text('MSE Yonsei', style: TextStyle(fontWeight: FontWeight.bold),)),
          ListTile(leading: Icon(Icons.account_box, color: Colors.black87,),title: Text('My Page',style: TextStyle(fontSize: 17),),onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>MyCollectionScreen()));
          },),
          ListTile(leading: Icon(Icons.account_tree, color: Colors.black87,),title: Text('Open Chat',style: TextStyle(fontSize: 17),),onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>OpenChatScreen()));
          },),
          ListTile(leading: Icon(Icons.assignment, color: Colors.black87,),title: Row(
            children: [
              Text('Notice',style: TextStyle(fontSize: 17),),
              if(notice_trigger == 'y')Spacer(),
              if(notice_trigger == 'y')Text('New', style: TextStyle(fontSize: 17, color: Colors.red),),
            ],
          ),onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>NoticeScreen()));
          },),
          ListTile(leading: Icon(Icons.addchart, color: Colors.black87,),title: Text('Tip Board',style: TextStyle(fontSize: 17),),onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>TipScreen()));
          },),
          ListTile(leading: Icon(Icons.settings, color: Colors.black87,),title: Text('Setting',style: TextStyle(fontSize: 17),),onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingScreen()));
          },),
        ],
      ),
    );
  }
}
