import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/auth_input_decor.dart';
import 'package:mse_yonsei/constants/screen_size.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/repo/helper/generate_post_key.dart';
import 'package:mse_yonsei/repo/post_network_repository.dart';
import 'package:mse_yonsei/screens/my_collection_screen.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:provider/provider.dart';

class EditAddressScreen extends StatefulWidget {
  final String postKey;
  final String name;
  final String url;
  final String phoneNumber;

  EditAddressScreen(
      {Key? key,
      required this.postKey,
      required this.name,
      required this.url,
      required this.phoneNumber})
      : super(key: key);

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  int _height = 80;
  int _textSize = 40;
  String userKey = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //칸 form의 상태를 저장해준다.
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _urlEditingController = TextEditingController();
  final TextEditingController _callEditingController = TextEditingController();

  @override
  void dispose() {
    _nameEditingController.dispose();
    _urlEditingController.dispose();
    _callEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _nameEditingController.text = widget.name;
    _callEditingController.text = widget.phoneNumber;
    _urlEditingController.text = widget.url;

    userKey =
        Provider.of<UserModelState>(context, listen: false).userModel.userKey;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Add Button',
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
            Form(
              key: _formKey,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size!.height / 20,
                  ),
                  Text(
                    '   Name',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  _nameTextField('Write the name of page...'),
                  SizedBox(
                    height: size!.height / 20,
                  ),
                  Text(
                    '   Url',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  _urlTextField(
                      'Write the url address\nEx) https://www.@@@@@@.com'),
                  SizedBox(
                    height: size!.height / 20,
                  ),
                  Text(
                    '   Call #',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  _callTextField('Write the phone number ex) 010xxxxxxxx'),
                  SizedBox(
                    height: size!.height / 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _addButton(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _nameTextField(String hint) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size!.height / 40, horizontal: 7),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.white70),
        cursorColor: Colors.deepOrangeAccent,
        controller: _nameEditingController,
        decoration: textInputDecor(hint),
        validator: (text) {
          if (text!.isNotEmpty && text.length > 1) {
            return null;
          } else {
            return '2자 이상을 입력해주세요.';
          }
        },
      ),
    );
  }

  Padding _urlTextField(String hint) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size!.height / 40, horizontal: 7),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.white70),
        cursorColor: Colors.deepOrangeAccent,
        controller: _urlEditingController,
        decoration: textInputDecor(hint),
        validator: (text) {
          if (text != '') {
            if (text!.contains('.')) {
              return null;
            } else {
              return '올바른 url 주소가 아닙니다.';
            }
          }
        },
      ),
    );
  }

  Padding _callTextField(String hint) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size!.height / 40, horizontal: 7),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        style: TextStyle(color: Colors.white70),
        cursorColor: Colors.deepOrangeAccent,
        controller: _callEditingController,
        decoration: textInputDecor(hint),
        validator: (text) {
          if (text != '') {
            if (text!.isNotEmpty) {
              return null;
            } else if (text.contains('-')) {
              return '-말고 숫자만 적어주세요.';
            }
          }
        },
      ),
    );
  }

  TextButton _addButton(BuildContext context) {
    String url = '';

    return TextButton(
      onPressed: () async {
        await PostNetwokRepository().deleteDate(userKey, widget.postKey);
        if (_formKey.currentState!.validate()) {
          if (_urlEditingController.text.contains('://')) {
            url = _urlEditingController.text.trim();
          } else {
            url = 'https://${_urlEditingController.text.trim()}';
          }
          // final String postKey = getNewPostKey(Provider.of<UserModelState>(context, listen: false).userModel);
          await PostNetwokRepository().sendData(
              userKey,
              widget.postKey,
              _nameEditingController.text.trim(),
              _callEditingController.text.trim(),
              url,
              '',
              '',
              '');
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyCollectionScreen()));
        }
      },
      child: Text(
        'Edit',
        style: TextStyle(color: Colors.white, fontSize: size!.height / 15),
      ),
    );
  }
}
