import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_application/games/simple_he_to_en.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/models/user_info.dart';
import 'package:web_application/pages/first_page.dart';
import 'package:web_application/pages/learning_mode.dart';
import 'package:web_application/pages/login_package/entrance_page.dart';
import 'package:web_application/pages/practice_mode.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_application/widgets/category_card.dart';
import 'package:web_application/widgets/dashboardFolder/dashboard.dart';

import '../utilis.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WordsProvider wordsProvider;
  @override
  Widget build(BuildContext context) {
    if (LoginInfo.name == "") Navigator.pop(context);
    wordsProvider = context.read<WordsProvider>();
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .35,
            decoration: BoxDecoration(
              color: Colors.blue[800],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        alignment: Alignment.center,
                        height: 47,
                        width: 47,
                        decoration: BoxDecoration(
                          color: Color(0xFF1A65CF),
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                            onTap: () => logout(context),
                            child: Icon(
                              Icons.logout,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  Text(
                    "Welcome back!",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      " ${UserInfo.userName}",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: relativeWidth(width: 650, context: context),
                      height: relativeHeigth(heigth: 1050, context: context),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: openPage()),
                    ),
                  )
                ],
              ),
            ),
          ),
          SafeArea(child: ClipRect(child: Dashboard()))
        ],
      ),
    );
  }

  void logout(BuildContext context) async {
    LoginInfo.name = "";
    LoginInfo.password = "";
    await saveCerdetional();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EntrancePage(),
      ),
      (route) => false,
    );
  }

  BoxDecoration background() {
    return BoxDecoration(
        image: DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage("assets/app_background.jpg"),
    ));
  }

  List<Widget> openPage() {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategoryCard(
            title: "pass the words",
            svgSrc: "assets/icons/passWords.png",
            press: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => FirstPage())),
          ),
          CategoryCard(
              title: "Start practice",
              svgSrc: "assets/icons/practice.png",
              press: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => PracticeMode()))),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategoryCard(
            title: "Start learning",
            svgSrc: "assets/icons/learning.png",
            press: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => LearningMode())),
          ),
          CategoryCard(
            title: "Playground",
            svgSrc: "assets/icons/playGround.png",
            press: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SimpleHeToEn())),
          ),
        ],
      ),
    ];
  }
}
