import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/pages/loading_page.dart';
import 'package:web_application/services/cliesnt.dart';
import 'package:web_application/widgets/password_field.dart';
import 'package:web_application/widgets/user_name_filed.dart';

import '../utilis.dart';

class LogginForm extends StatefulWidget {
  const LogginForm({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => LogginFormState();
}

class LogginFormState extends State<LogginForm> {
  final _formKey = GlobalKey<FormState>();
  Client client = Client();
  String erroreMessage = "";

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          UserNameField(),
          PasswordField(),
          buildForgetPasswordButton(),
          showErrors(),
          buildLoginButton(context),
        ]));
  }

  Widget buildLoginButton(BuildContext context) {
    return Center(
        child: Container(
      height: 1.4 * (MediaQuery.of(context).size.height / 20),
      width: 5 * (MediaQuery.of(context).size.width / 10),
      margin: EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.resolveWith((states) => 5.0),
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => mainColor),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
        ),
        onPressed: () => logginBtn(context),
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: MediaQuery.of(context).size.height / 40,
          ),
        ),
      ),
    ));
  }

  Future<List<dynamic>> login() async {
    print("cerdetional - ${LoginInfo.name} ${LoginInfo.password}");
    List<dynamic> response =
        await client.login(LoginInfo.name, LoginInfo.password);
    //UserInfo.setup();
    return response;
  }

  Future<void> logginBtn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      bool isConnected = false;
      List<dynamic> response = await login();
      isConnected = response[0];
      print("$isConnected");
      if (isConnected) {
        saveCerdetional();
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoadingPage()));
      } else {
        setState(() {
          this.erroreMessage = response[1];
        });
      }
    } else {
      setState(() {
        this.erroreMessage = "";
      });
    }
  }

  Container showErrors() {
    return Container(
      alignment: Alignment.topCenter,
      height: 20,
      padding: const EdgeInsets.only(bottom: 3),
      child: Text(
        erroreMessage,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget buildForgetPasswordButton() {
    return Container(
      margin: EdgeInsets.only(left: 8),
      alignment: Alignment.topLeft,
      child: TextButton(
          onPressed: () {},
          child: Text(
            "Forgot password ?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          )),
    );
  }
}
