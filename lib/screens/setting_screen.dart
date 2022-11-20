import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/material_color.dart';
import 'package:mse_yonsei/model/firebase_auth_state.dart';
import 'package:mse_yonsei/screens/feedback_screen.dart';
import 'package:mse_yonsei/screens/info_screen.dart';
import 'package:mse_yonsei/screens/introduce_screen.dart';
import 'package:mse_yonsei/screens/start/start_screen.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool _checked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Provider.of<AppState>(context).app_color,
          title: Text(
            'Settings',
            style: TextStyle(fontFamily: 'DonghyunKo'),
          ),
        ),
        body: Stack(
          children: [
            Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Background(file_name: 'homebackground')),
            Opacity(
              opacity: 0.3,
              child: ListView(
                children: [
                  // SizedBox(height: size!.height*0.03,),
                  // Container(height: 3, color: univState.currentColor),
                  // _heightBox(1),
                  // _settingList('어플 세팅'),
                  // _appColordropButton(appState!),
                  // _dividerDropButton(appState),
                  // _heightBox(3),
                  // _dropButton(univState),
                  // _divider,
                  _settingList('개인 설정'),
                  // _checkableSettingList('학교', univState.currentColor),
                  _divider,
                  _gotoAnotherPage('개인 정보', InfoScreen()),
                  _divider,
                  _gotoAnotherPage('추가 및 수정 요청', FeedbackScreen()),
                  _divider,
                  _logoutPage('log out'),
                  _divider,
                  // _heightBox(30),
                  _settingList('우리 앱?'),
                  _gotoAnotherPage('앱 소개', IntroScreen()),
                  _divider,
                  _textBox('Version 1.0'),
                  // _divider,
                ],
              ),
            ),
          ],
        )
    );
  }

  Container _textBox(String title) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: null,
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black38),
        ),
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        minVerticalPadding: 0,
      ),
    );
  }

  Container _heightBox(double height) {
    return Container(
      height: height,
      color: Colors.white,
    );
  }

  Divider get _divider => Divider(
    thickness: 2,
    height: 0,
    color: Color(0xff003976),
  );

  Container _checkableSettingList(String title, Color color) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: color),
        ),
        trailing: CupertinoSwitch(
          value: _checked,
          onChanged: (onValue) {
            setState(() {
              _checked = onValue;
            });
          },
        ),
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  Container _settingList(String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        // color: Provider.of<AppState>(context).app_color,
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        minVerticalPadding: 0,
      ),
    );
  }

  Container _gotoAnotherPage(String title, Widget widget) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => widget));
        },
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: app_color),
        ),
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        minVerticalPadding: 0,
      ),
    );
  }
  Container _logoutPage(String title) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          Provider.of<FirebaseAuthState>(context, listen: false).signOut();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StartScreen()));
        },
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
        ),
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        minVerticalPadding: 0,
      ),
    );
  }


  ListTile _setting(String title) {
    return ListTile(
      minVerticalPadding: 0,
      title: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
        ),
      ),
      dense: false,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
    );
  }

// Container _appColordropButton(AppState appState) {
//   return Container(
//     color: Colors.white,
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: DropdownButton(
//         isExpanded: true,
//         value: _selectedAppColorValue,
//         // value: appState.app_color_list[_currentIndex],
//         items: appState.app_color_text_list.map((value) {
//           return DropdownMenuItem(
//             onTap: () {},
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   value,
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             value: value,
//           );
//         }).toList(),
//         onChanged: (value) {
//           setState(() {
//             _currentIndex = appState.app_color_text_list.indexOf(value.toString());
//             _selectedAppColorValue = appState.app_color_text_list[_currentIndex];
//             appState.setAppColor(_currentIndex);
//
//
//           });
//         },
//       ),
//     ),
//   );
// }

// Container _dividerDropButton(AppState appState) {
//   return Container(
//     color: Colors.white,
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: DropdownButton(
//         isExpanded: true,
//         value: _selectedDividerColorValue,
//         // value: appState.app_color_list[_currentIndex],
//         items: appState.divider_color_text_list.map((value) {
//           return DropdownMenuItem(
//             onTap: () {},
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   value,
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             value: value,
//           );
//         }).toList(),
//         onChanged: (value) {
//           setState(() {
//             _currentIndex = appState.divider_color_text_list.indexOf(value.toString());
//             _selectedDividerColorValue = appState.app_color_text_list[_currentIndex];
//             appState.setDividerColor(_currentIndex);
//           });
//         },
//       ),
//     ),
//   );
// }
}
