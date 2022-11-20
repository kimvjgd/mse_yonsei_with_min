import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:mse_yonsei/screens/setting_screen.dart';


class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

// ------------------ Custom config ------------------
class IntroScreenState extends State<IntroScreen> {

  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title:
        "개발자 소개",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'DonghyunKo'),
        // 저는 신소재공학과 재학중인 학생입니다. 학우들이 시간내어 쓴 좋은 정보를 에타에 많이 올려주지만 시간이 지나면 잊혀지는 것이 너무 안타까웠습니다. 신소재공학과 학생들에게
        // 좋은 정보가 공유되는 플랫폼이 있으면 좋겠다는 생각을 하였습니다. 그러다가 공지도 몹고 누구나 참여할 수 있는 단톡방, 특정 수업관련한 단톡방까지 만들게 되었네요...
        description:"""
저는 신소재공학과 재학중인 학생입니다. 학우들이 시간내어 쓴 좋은 정보들이 에타에 많이 올라와있지만 시간이 지나면 잊혀지는 것이 너무 안타까웠습니다. 연세대학교 신소재공학과 학생들 누구나 좋은 정보가 공유되는 플랫폼이 있으면 좋겠다는 생각을 하였습니다. 

그러다가 공지도 모으고 누구나 참여할 수 있는 단톡방, 특정 수업관련한 단톡방까지 만들게 되었네요... 

프로그래밍은 취미삼아 하는 것이기 때문에 많이 미흡합니다. 오류를 발견하시면 (설정-> 추가 및 수정 요청에 있는 문의 방법으로 알려주시면 감사하겠습니다.
        """,


        styleDescription: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'DonghyunKo'),
        marginDescription:
        EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        centerWidget: Text("",
            style: TextStyle(color: Colors.white)),
        backgroundImage: "assets/images/developer.png",
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );
    slides.add(
      new Slide(
        title: "자료 출처",
        styleTitle: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'DonghyunKo'),
        description:
        "주로 크롤링을 이용하여 정보를 찾았습니다. 대략적으로 오타나 잘못 연결된 사항들은 수정했지만 아직 정보 불일치가 있을 수 있다는 점 양해 부탁드립니다.",
        styleDescription: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'DonghyunKo'),
        backgroundImage: "assets/images/developer.png",
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
      ),
    );
    slides.add(
      new Slide(
        title: "디자이너 모집",
        styleTitle: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'DonghyunKo'),
        description:"혹시 보다 더 이쁜 폰트나 사진, 구조들이 있다면 말씀해주세요. 혹은 디자인에 관심이 있거나 취미 하신다면 언제든 연락주세요.\n\n단! 저작권에 위반되지 않아야하며 출처가 정확해야합니다.",
        styleDescription: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'DonghyunKo'),
        backgroundImage: "assets/images/developer.png",
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
    // Do what you want
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomeScreen()),
    // );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffF3B4BA),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffF3B4BA),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffF3B4BA),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0x33F3B4BA)),
      overlayColor: MaterialStateProperty.all<Color>(Color(0x33FFA8B0)),
    );
  }

  @override
  Widget build(BuildContext context) {

    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: this.renderNextBtn(),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot: Color(0x33FFA8B0),
      colorActiveDot: Color(0xffFFA8B0),
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}