import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mse_yonsei/constants/material_color.dart';
import 'package:mse_yonsei/home_page.dart';
import 'package:mse_yonsei/model/app_state.dart';
import 'package:mse_yonsei/model/firebase_auth_state.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/repo/user_network_repository.dart';
import 'package:mse_yonsei/screens/start/auth_page.dart';
import 'package:mse_yonsei/screens/start/start_screen.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';


// androidId: "com.dongpakka.mse_yonsei",
// iOSId: "com.dongpakka.mseYonsei",

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  Widget? _currentWidget;
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  UserModelState _userModelState = UserModelState();


  @override
  Widget build(BuildContext context) {
    // final appcastURL = 'https://www.mydomain.com/myappcast.xml';
    // final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

    _firebaseAuthState.watchAuthChange();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<FirebaseAuthState>.value(
            value: _firebaseAuthState),
        ChangeNotifierProvider<UserModelState>.value(value: _userModelState),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: app_color,
        ),
        debugShowCheckedModeBanner: false,
        home: Consumer<FirebaseAuthState>(builder: (BuildContext context,
            FirebaseAuthState? firebaseAuthState, Widget? child) {
          switch (firebaseAuthState!.firebaseAuthStatus) {
            case FirebaseAuthStatus.signout:
              _clearUserModel(context);
              _currentWidget = StartScreen();
              break;
            case FirebaseAuthStatus.signin:
              _initUserModel(firebaseAuthState, context);
              _currentWidget = MyHomePage();
              break;
            default:
              _currentWidget = AuthPage();
          }
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _currentWidget,
          );
        }),
      ),
    );
  }

  void _initUserModel(
      FirebaseAuthState firebaseAuthState, BuildContext context) {
    UserModelState userModelState = Provider.of(context,
        listen: false); // ????????? provider??? userModelState??? ?????? ???????????????..

    userModelState.currentStreamSub = userNetworkRepository
        .getUserModelStream(firebaseAuthState.firebaseUser!
            .uid) // getUserModelStream??? userModel??? stream?????? ?????? ????????????.
        .listen((userModel) {
      userModelState.userModel =
          userModel; // userModelState??? userModel??? getUserModelStream?????? ?????? ???????????? userModel??? ?????? ????????????.
    });
  }

  void _clearUserModel(BuildContext context) {
    UserModelState userModelState =
        Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }
}
