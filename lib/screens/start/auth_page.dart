import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/flash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/auth_input_decor.dart';
import 'package:mse_yonsei/constants/constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:mse_yonsei/constants/firestore_keys.dart';
import 'package:mse_yonsei/constants/material_color.dart';
import 'package:mse_yonsei/main.dart';
import 'package:mse_yonsei/model/firebase_auth_state.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  String userKey = '';

  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  bool _isShowSignUp = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  TextEditingController _signUpEmailController = TextEditingController();
  TextEditingController _signUpPasswordController = TextEditingController();
  TextEditingController _signUpCfPasswordController = TextEditingController();
  TextEditingController _signUpStudentNumController = TextEditingController();
  TextEditingController _loginEmailController = TextEditingController();
  TextEditingController _loginPasswordController = TextEditingController();

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);

    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _signUpCfPasswordController.dispose();
    _signUpStudentNumController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                AnimatedPositioned(
                    duration: defaultDuration,
                    width: _size.width * 0.88,
                    height: _size.height,
                    left: _isShowSignUp ? -_size.width * 0.76 : 0,
                    child: Container(
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: ExtendedImage.asset(
                                'assets/images/homebackground.png',
                                fit: BoxFit.cover,
                              )),
                          _loginForm(context),
                        ],
                      ),
                    )),
                AnimatedPositioned(
                    duration: defaultDuration,
                    height: _size.height,
                    width: _size.width * 0.88,
                    left:
                        _isShowSignUp ? _size.width * 0.12 : _size.width * 0.88,
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: ExtendedImage.asset(
                                'assets/images/homebackground.png',
                                fit: BoxFit.cover,
                              )),
                          _signupForm(context),
                        ],
                      ),
                    )),
                AnimatedPositioned(
                    duration: defaultDuration,
                    top: _size.height * 0.1,
                    left: 0,
                    right: _isShowSignUp
                        ? -_size.width * 0.06
                        : _size.width * 0.06,
                    child: CircleAvatar(
                      radius: 25,
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _isShowSignUp
                            ? SvgPicture.asset(
                                'assets/images/animation_logo.svg',
                                color: Colors.white,
                              )
                            : SvgPicture.asset(
                                'assets/images/animation_logo.svg',
                                color: Colors.white,
                              ),
                      ),
                    )),
                AnimatedPositioned(
                    duration: defaultDuration,
                    width: _size.width,
                    bottom: _size.height * 0.1,
                    right: _isShowSignUp
                        ? -_size.width * 0.06
                        : _size.width * 0.06,
                    child: Center(
                        child: Text(
                      _isShowSignUp
                          ? '학번을 잘못 기재하시면\n\n자동 탈퇴 됨을 유의하세요.'
                          : '연세대학교 신소재공학과\n\n학생들만 사용 부탁드립니다.',
                      style: TextStyle(
                          color: _isShowSignUp
                              ? Colors.orangeAccent
                              : Colors.deepOrange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ))),
                AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: _isShowSignUp
                        ? _size.height / 2 - 80
                        : _size.height * 0.3,
                    left: _isShowSignUp ? 0 : _size.width * 0.44 - 80,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _isShowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignUp ? Colors.redAccent : Colors.white,
                      ),
                      child: Transform.rotate(
                        angle: -_animationTextRotate.value * pi / 180,
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () async {
                            if (_isShowSignUp) {
                              updateView();
                            } else {
                              // 로그인 클릭되면
                              if (_loginFormKey.currentState!.validate()) {
                                await Provider.of<FirebaseAuthState>(context,
                                        listen: false)
                                    .login(context,
                                        email:
                                            _loginEmailController.text.trim(),
                                        password: _loginPasswordController.text
                                            .trim());
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()));
                              }
                              // else {
                              //   Navigator.of(context).pushReplacement(
                              //       MaterialPageRoute(
                              //           builder: (context) => StartScreen()));
                              // }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: defaultPadding * 0.75),
                            width: 160,
                            child: Text(
                              "Log In".toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    )),
                AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: !_isShowSignUp
                        ? _size.height / 2 - 80
                        : _size.height * 0.3,
                    right: _isShowSignUp ? _size.width * 0.44 - 80 : 0,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: !_isShowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignUp ? Colors.white : Colors.redAccent,
                      ),
                      child: Transform.rotate(
                        angle: (90 - _animationTextRotate.value) * pi / 180,
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () async {
                            if (_isShowSignUp) {
                              if (_signupFormKey.currentState!.validate()) {
                                await Provider.of<FirebaseAuthState>(context,
                                        listen: false)
                                    .registerUser(context,
                                        email:
                                            _signUpEmailController.text.trim(),
                                        password: _signUpPasswordController.text
                                            .trim());

                                userKey = Provider.of<UserModelState>(context,
                                        listen: false)
                                    .userModel
                                    .userKey;
                                await FirebaseFirestore.instance
                                    .collection(COLLECTION_USERS)
                                    .doc(userKey)
                                    .collection('repo')
                                    .doc('first_$userKey')
                                    .set({'name': 'Welcome, new friend'});

                                await FirebaseFirestore.instance
                                    .collection(COLLECTION_USERS)
                                    .doc(userKey)
                                    .set({
                                  'stu_num':
                                      _signUpStudentNumController.text.trim(),
                                  'email': _signUpEmailController.text.trim(),
                                  'access': 'n',
                                });

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()));
                              } else {
                                print('@@@ else');
                              }
                            } else {
                              updateView();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: defaultPadding * 0.75),
                            width: 160,
                            child: Text(
                              "Sign Up".toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            );
          }),
    );
  }

  Padding _signupForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13),
      child: Form(
        key: _signupFormKey,
        child: Column(
          children: [
            Spacer(),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _signUpEmailController,
              textInputAction: TextInputAction.next,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white70),
              decoration: textInputDecor('Email'),
              validator: (text) {
                if (text!.isNotEmpty && text.contains("@")) {
                  return null;
                } else {
                  return '정확한 이메일 주소를 입력해주세요';
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: defaultPadding,
              ),
              child: TextFormField(
                controller: _signUpPasswordController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.white70),
                obscureText: true,
                decoration: textInputDecor('Password'),
                validator: (text) {
                  if (text!.isNotEmpty && text.length > 2) {
                    return null;
                  } else {
                    return '제대로 된 비밀번호 입력해주세요';
                  }
                },
              ),
            ),
            TextFormField(
              controller: _signUpCfPasswordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.white70),
              obscureText: true,
              decoration: textInputDecor('Confirm Password'),
              validator: (text) {
                if (text!.isNotEmpty &&
                    _signUpPasswordController.text == text) {
                  return null;
                } else {
                  return '입력한 값이 비밀번호와 일치하지 않습니다.';
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                controller: _signUpStudentNumController,
                decoration: textInputDecor('Student ID #'),
                validator: (text) {
                  if (text!.isNotEmpty) {
                    return null;
                  } else {
                    return '학번을 제대로 입력해주세요.';
                  }
                },
              ),
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }

  Padding _loginForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13),
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _loginEmailController,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.white70),
              cursorColor: Colors.white,
              decoration: textInputDecor('Email'),
              validator: (text) {
                if (text!.isNotEmpty && text.contains("@")) {
                  return null;
                } else {
                  return '정확한 이메일 주소를 입력해주세요';
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                controller: _loginPasswordController,
                style: TextStyle(color: Colors.white70),
                cursorColor: Colors.white,
                obscureText: true,
                decoration: textInputDecor('Password'),
                validator: (text) {
                  if (text!.isNotEmpty && text.length > 2) {
                    return null;
                  } else {
                    return '제대로 된 비밀번호 입력해주세요';
                  }
                },
              ),
            ),
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
                  "Forgot Password?",
                  style: TextStyle(color: Colors.white),
                )),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
