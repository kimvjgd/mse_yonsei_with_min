import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mse_yonsei/model/firestore/user_model.dart';

class UserModelState extends ChangeNotifier {
  UserModel _userModel = UserModel(userKey: '',email: '', stu_num: '', access: '');
  StreamSubscription<UserModel>? _currentStreamSub;         // usermodel을 stream으로 계속 불러옵니다.    logout누르면 stream이 logout을 읽어와줌
  UserModel get userModel => _userModel;

  set userModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  set currentStreamSub(StreamSubscription<UserModel> currentStreamSub) => _currentStreamSub = currentStreamSub;

  clear() {             // for logout
    if(_currentStreamSub != null)
      _currentStreamSub!.cancel();
    _currentStreamSub = null;
    _userModel = UserModel(userKey: '',email: '', stu_num: '', access: '');
  }
}