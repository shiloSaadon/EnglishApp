import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/pages/loading_page.dart';
import 'package:web_application/services/cliesnt.dart';
import 'package:web_application/widgets/loggin_form.dart';
import 'package:web_application/widgets/password_field.dart';
import 'package:web_application/widgets/user_name_filed.dart';

import '../../utilis.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  Client client = Client();
  String erroreMessage = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 7),
              blurRadius: 10,
              spreadRadius: -3,
              color: Colors.grey,
            ),
          ]),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height / 30,
              ),
            ),
          ),
          LogginForm(),
          buildOrRow(),
          buildSocialBtnRow(),
        ],
      ),
    );
  }

  Widget buildOrRow() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        '- OR -',
        style: TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget buildSocialBtnRow() {
    return GestureDetector(
      onTap: () {
        print("google click!");
      },
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: mainColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0)
          ],
        ),
        child: Icon(
          FontAwesomeIcons.google,
          color: Colors.white,
        ),
      ),
    );
  }
}
