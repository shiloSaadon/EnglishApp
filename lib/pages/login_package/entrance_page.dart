import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/models/user_info.dart';
import 'package:web_application/pages/home_page.dart';
import 'package:web_application/pages/loading_page.dart';
import 'package:web_application/pages/login_package/login_widget.dart';
import 'package:web_application/pages/login_package/sign_up_widget.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_application/services/cache_controller.dart';
import 'package:web_application/services/cliesnt.dart';
import '../../utilis.dart';

class EntrancePage extends StatefulWidget {
  @override
  _EntrancePageState createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  bool isLoggin = true;
  Client client = Client();
  updateScreen(bool isLoggin) {
    setState(() {
      this.isLoggin = isLoggin;
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScreen();
    setup(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff2f3f7),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buildLogo(context),
                  this.isLoggin ? LoginWidget() : SignUpWidget(),
                  this.isLoggin ? buildSignUpBtn() : buildLogginBtn(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void setupScreen() {
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // disable landscape mode
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  void setup(BuildContext context) {
    context.read<WordsProvider>().setup();
    //LoginInfo.setup();
    //UserInfo.initialVars();
  }

  Widget buildLogo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        'LEARN ENGLISH',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height / 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildSignUpBtn() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => updateScreen(false),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Dont have an account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height / 40,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: mainColor,
                fontSize: MediaQuery.of(context).size.height / 40,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget buildLogginBtn() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => updateScreen(true),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'have an account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height / 40,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Loggin',
              style: TextStyle(
                color: mainColor,
                fontSize: MediaQuery.of(context).size.height / 40,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
