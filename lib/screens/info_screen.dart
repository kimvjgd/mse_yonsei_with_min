import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/material_color.dart';
import 'package:mse_yonsei/constants/screen_size.dart';
import 'package:mse_yonsei/model/firestore/user_model.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:provider/provider.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModelState _userModelState = Provider.of(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('개인 정보'),
        ),
        body: Stack(
          children: [
            Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Background(file_name: 'homebackground')),
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Opacity(
                opacity: 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Id : ${_userModelState.userModel.email}',
                      style: TextStyle(
                          color: Colors.white, fontSize: size!.height * 0.03),
                    ),
                    SizedBox(
                      height: size!.height * 0.05,
                    ),
                    Text(
                      'Stu_Num : ${_userModelState.userModel.stu_num}',
                      style: TextStyle(
                          color: Colors.white, fontSize: size!.height * 0.03),
                    ),
                    SizedBox(
                      height: size!.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Access : ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size!.height * 0.03),
                        ),
                    _userModelState.userModel.access == 'n'?
                    Text(
                      'n',
                      style: TextStyle(
                          color: Colors.red, fontSize: size!.height * 0.1),
                    ):                    Text(
                      'y',
                      style: TextStyle(
                          color: Colors.blue, fontSize: size!.height * 0.1),
                    ),
                      ],
                    ),
                    SizedBox(height: size!.height*0.07,),
                    TextButton(
                        onPressed: () async {
                          showFlash(
                              context: context,
                              duration: Duration(seconds: 4),
                              builder: (context, controller) {
                                return Flash.dialog(
                                    controller: controller,
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    alignment: Alignment.bottomCenter,
                                    margin: EdgeInsets.only(bottom: 30),
                                    backgroundGradient: LinearGradient(colors: [app_color, Colors.deepPurpleAccent]),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Please contact to\n\nmseyonseiapp@gmail.com ',
                                        style:
                                        TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    ));
                              });
                        },
                        child: Text(
                          "For Changing your Info?\nClick Here!",
                          style: TextStyle(color: Colors.cyanAccent,fontSize: 20,fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: size!.height*0.2,)
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
