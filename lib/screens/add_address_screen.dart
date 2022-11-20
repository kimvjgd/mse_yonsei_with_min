import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/auth_input_decor.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/repo/helper/generate_post_key.dart';
import 'package:mse_yonsei/repo/post_network_repository.dart';
import 'package:mse_yonsei/screens/my_collection_screen.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {


  String userKey = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //칸 form의 상태를 저장해준다.
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _urlEditingController = TextEditingController();

  @override
  void dispose() {
    _nameEditingController.dispose();
    _urlEditingController.dispose();
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
                right: 0,
                left: 0,
                child: Background(file_name: 'homebackground')),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Text('   Name',style: TextStyle(fontSize: 30,color: Colors.white),),
                  _nameTextField('Write the name of page...'),
                  SizedBox(height: 30,),
                  Text('   Url',style: TextStyle(fontSize: 30,color: Colors.white),),
                  _urlTextField(
                      'Write the url address\nEx) https://www.@@@@@@.com'),
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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        style: TextStyle(color: Colors.white70),
        cursorColor: Colors.deepOrangeAccent,
        controller: _urlEditingController,
        decoration: textInputDecor(hint),
        validator: (text) {
          if (text!.isNotEmpty && text.contains('.')) {
            return null;
          } else {
            return '올바른 url 주소가 아닙니다.';
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
          if(_urlEditingController.text.contains('://')) {
            url = _urlEditingController.text.trim();
          } else {
            url = 'https://${_urlEditingController.text.trim()}';
          }
          final String postKey = getNewPostKey(Provider.of<UserModelState>(context, listen: false).userModel);

          await PostNetwokRepository().sendData(userKey, postKey, _nameEditingController.text.trim(), '', url, '', '','');
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
