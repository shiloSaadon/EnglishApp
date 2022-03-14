import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/pages/loading_page.dart';
import 'package:web_application/pages/loading_program.dart';
import 'package:web_application/services/cliesnt.dart';
import 'package:web_application/widgets/password_field.dart';
import 'package:web_application/widgets/user_name_filed.dart';
import 'package:web_application/widgets/user_private_name.dart';
import 'package:web_application/widgets/verify_passwor.dart';

import '../utilis.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  Client client = Client();
  String erroreMessage = "";

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          UserPrivateNameField(),
          UserNameField(),
          PasswordField(
            isSignUp: true,
          ),
          VerifyPasswordField(),
          showErrors(),
          buildSignUpButton(context),
        ]));
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

  Widget buildSignUpButton(BuildContext context) {
    return Center(
        child: Container(
      height: 1.4 * (MediaQuery.of(context).size.height / 20),
      width: 5 * (MediaQuery.of(context).size.width / 10),
      margin: EdgeInsets.only(bottom: 7),
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
        onPressed: () => signUpBtn(context),
        child: Text(
          "SignUp",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: MediaQuery.of(context).size.height / 40,
          ),
        ),
      ),
    ));
  }

  Future<List<dynamic>> register() async {
    List<dynamic> response = await client.register(
        LoginInfo.name, LoginInfo.password, LoginInfo.privateName);
    //UserInfo.setup();
    return response;
  }

  Future<void> signUpBtn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      bool isConnected = false;
      List<dynamic> response = await register();
      isConnected = response[0];
      print("$isConnected");
      saveCerdetional();
      if (isConnected) {
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoadingProgram()));
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
}
