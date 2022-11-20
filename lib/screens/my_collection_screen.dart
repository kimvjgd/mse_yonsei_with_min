import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mse_yonsei/constants/material_color.dart';
import 'package:mse_yonsei/model/firestore/post_model.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/main_menu_floating_action_button.dart';
import 'package:mse_yonsei/repo/helper/generate_post_key.dart';
import 'package:mse_yonsei/repo/post_network_repository.dart';
import 'package:mse_yonsei/flutter_speed_dial_menu_button.dart';
import 'package:mse_yonsei/screens/add_address_screen.dart';
import 'package:mse_yonsei/screens/add_call_screen.dart';
import 'package:mse_yonsei/screens/edit_address_screen.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:mse_yonsei/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCollectionScreen extends StatefulWidget {
  const MyCollectionScreen({Key? key}) : super(key: key);

  @override
  _MyCollectionScreenState createState() => _MyCollectionScreenState();
}

class _MyCollectionScreenState extends State<MyCollectionScreen> {
  String userKey = '';

  bool _isShowDial = false;

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    userKey =
        Provider
            .of<UserModelState>(context, listen: false)
            .userModel
            .userKey;

    // return StreamProvider<List<PostModel>>.value(
    //     initialData: [],
    //     value: postNetworkRepository.getMyPosts(userKey),
    // );
    return FutureBuilder<List<PostModel>>(
        initialData: [PostModel(name: '인터넷 연결 상태를 확인해주세요.')],
        future: postNetworkRepository.getMyOwnPosts(userKey),
        builder: (context, snapshot) {
          List<PostModel> _list = [];
          for (int i = 0; i < snapshot.data!.length; i++) {
            _list.add(snapshot.data![i]);
          }
          _list.sort((a, b) => a.name!.compareTo(b.name!));
          // if(!snapshot.hasData) {
          //   return MyProgressIndicator(progressSize: 30);
          // }
          return Scaffold(
            appBar: AppBar(
              title: Text('MyPage'),
              backgroundColor: app_color,
            ),
            body: Stack(
              children: [
                Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Background(file_name: 'homebackground')),
                ListView.builder(
                  itemBuilder: (context, index) =>
                      Column(
                        children: [
                          InkWell(
                            onTap: () =>
                                showSimpleDialog(context, _list[index]),
                            child: ListTile(
                              title: Text(
                                _list[index].name!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Divider(
                            height: 2,
                            thickness: 1,
                            color: Colors.white,
                          )
                        ],
                      ),
                  itemCount: _list.length,
                )
              ],
            ),
            floatingActionButton: _getFloatingActionButton(),
          );
        });
  }

  Widget _getFloatingActionButton() {
    return SpeedDialMenuButton(
      //if needed to close the menu after clicking sub-FAB
      isShowSpeedDial: _isShowDial,
      //manually open or close menu
      updateSpeedDialStatus: (isShow) {
        //return any open or close change within the widget
        this._isShowDial = isShow;
      },
      //general init
      isMainFABMini: false,
      mainMenuFloatingActionButton: MainMenuFloatingActionButton(
          backgroundColor: Colors.white24,
          mini: false,
          child: Icon(Icons.add),
          onPressed: () {},
          closeMenuChild: Icon(Icons.close),
          closeMenuForegroundColor: Colors.white,
          closeMenuBackgroundColor: Colors.red),
      floatingActionButtonWidgetChildren: <FloatingActionButton>[
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.add_box),
          onPressed: () {
            _isShowDial = false;
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => AddAddressScreen()));
          },
          backgroundColor: Colors.pink,
        ),
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.add_call),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => AddCallScreen()));
          },
          backgroundColor: Colors.teal,
        ),
        FloatingActionButton(
          mini: true,
          child: Container(),
          onPressed: () {},
          backgroundColor: Colors.grey,
        ),
      ],
      isSpeedDialFABsMini: true,
      paddingBtwSpeedDialButton: 30.0,
    );
  }

  void showSimpleDialog(BuildContext context, PostModel item) =>
      showDialog(
          context: context,
          builder: (_) {
            bool check = (item.lab_url != "" &&
                item.lab_name != "" && item.professor_name != "" &&
                item.professor_url != "") ? true : false;
            return SimpleDialog(
              backgroundColor: app_color,
              title: Container(
                  child: Text(
                    item.name!,
                    style: TextStyle(fontSize: 24, color: Colors.white70),
                  )),
              children: [
                Container(
                  height: 3,
                  color: Colors.amber,
                ),
                SizedBox(
                  height: 5,
                ),
                if (item.phone_number != null && item.phone_number != '')
                  InkWell(
                    child: ListTile(
                      leading: Icon(
                        Icons.call,
                        color: Colors.white70,
                      ),
                      title: Text(
                        'Call',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    onTap: () async {
                      await FlutterPhoneDirectCaller.callNumber(
                          item.phone_number!);
                      Navigator.pop(context);
                    },
                  ),
                if (item.url != null && item.url != '')
                  InkWell(
                    child: ListTile(
                      leading: Icon(
                        Icons.subdirectory_arrow_right_sharp,
                        color: Colors.white70,
                      ),
                      title: Text(
                        'Url',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    onTap: () {
                      _launchURL(item.url!);
                      Navigator.pop(context);
                    },
                  ),
                if (item.category == 'PROFESSOR')
                  Column(
                    children: [
                      InkWell(
                        child: ListTile(
                          leading: Icon(
                            Icons.account_balance,
                            color: Colors.white70,
                          ),
                          title: Text(
                            'Lab_url',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        onTap: () {
                          if (item.lab_url == null || item.lab_url == '') {
                            SnackBar snackBar = SnackBar(
                              backgroundColor: app_color,
                              content: Text(
                                '해당 연구실 url이 존재하지 않습니다.',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);
                          } else {
                            _launchURL(item.lab_url!);
                            Navigator.pop(context);
                          }
                        },
                      ),
                      InkWell(
                        child: ListTile(
                          leading: Icon(
                            Icons.account_box_outlined,
                            color: Colors.white70,
                          ),
                          title: Text(
                            'Prof._url',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        onTap: () {
                          if (item.professor_url == null ||
                              item.professor_url == '') {
                            SnackBar snackBar = SnackBar(
                              backgroundColor: app_color,
                              content: Text(
                                '해당 교수님 url이 존재하지 않습니다.',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);
                          } else {
                            _launchURL(item.professor_url!);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        (check==false)?
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) =>
                                EditAddressScreen(
                                    postKey: item.postKey.toString(),
                                    name: item.name.toString(),
                                    url: item.url.toString(),
                                    phoneNumber: item.phone_number
                                        .toString()))):{};
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            child: Icon(
                              CupertinoIcons.arrow_2_circlepath,
                              color: check == false ? Colors.deepOrangeAccent : Colors.blueGrey
                            )),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            child: Icon(
                              Icons.delete_rounded,
                              color: Colors.redAccent,
                            )),
                      ),
                      onTap: () async {
                        // postKey를 불러와야 하는데...
                        final String postKey = item.postKey!;
                        // final String postKey = getNewPostKey(Provider.of<UserModelState>(context, listen: false).userModel);
                        await PostNetwokRepository().deleteDate(
                            userKey, postKey);
                        Navigator.pop(context);
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            );
          }
      );
}

