import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/auth_input_decor.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/repo/helper/generate_post_key.dart';
import 'package:mse_yonsei/repo/post_network_repository.dart';
import 'package:mse_yonsei/screens/my_collection_screen.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:provider/provider.dart';

class AddCallScreen extends StatefulWidget {
  const AddCallScreen({Key? key}) : super(key: key);

  @override
  _AddCallScreenState createState() => _AddCallScreenState();
}

class _AddCallScreenState extends State<AddCallScreen> {
  int _height = 80;
  int _textSize = 40;
  String userKey = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //칸 form의 상태를 저장해준다.
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _callEditingController = TextEditingController();

  @override
  void dispose() {
    _nameEditingController.dispose();
    _callEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    userKey = Provider.of<UserModelState>(context, listen: false).userModel.userKey;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                left: 0,
                right: 0,
                child: Background(file_name: 'homebackground')),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    '   Name',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  _nameTextField('Write the name of number...'),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '   Call #',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  _callTextField('Write the phone number ex) 010xxxxxxxx'),
                  SizedBox(
                    height: 30,
                  ),
                  Spacer(),
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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      child: TextFormField(
        onChanged: (text) {
          setState(() {});
        },
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

  Padding _callTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        style: TextStyle(color: Colors.white70),
        cursorColor: Colors.deepOrangeAccent,
        controller: _callEditingController,
        decoration: textInputDecor(hint),
        validator: (text) {
          if (text!.isNotEmpty) {
            return null;
          } else if (text.contains('-')) {
            return '-말고 숫자만 적어주세요.';
          }
          {
            return '올바른 phone number가 아닙니다.';
          }
        },
      ),
    );
  }

  TextButton _addButton(BuildContext context) {
    String url = '';

    return TextButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final String postKey = getNewPostKey(Provider.of<UserModelState>(context, listen: false).userModel);

          await PostNetwokRepository().sendData(userKey, postKey, _nameEditingController.text.trim(), _callEditingController.text.trim(), '', '', '','');

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyCollectionScreen()));
        }
      },
      child: Text(
        'Add',
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
    );
  }
}
