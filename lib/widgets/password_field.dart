import 'package:flutter/material.dart';
import 'package:web_application/models/login_info.dart';

import '../utilis.dart';

class PasswordField extends StatefulWidget {
  bool isSignUp;
  PasswordField({this.isSignUp = false});
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool secureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: secureText,
            validator: (value) {
              if (value == null || value.length < 8) {
                return 'Password must be al least 8 characters';
              } else if (value == LoginInfo.name) {
                return "user name and password must be different";
              } else if (widget.isSignUp && value != LoginInfo.verifyPassword) {
                return "Incompatible passwords";
              }
              return null;
            },
            onChanged: (value) {
              LoginInfo.password = value;
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: mainColor,
                ),
                labelText: 'Password',
                suffix: InkWell(
                    onTap: updateScreen,
                    child: Icon(
                      secureText ? Icons.visibility : Icons.visibility_off,
                      size: 20,
                    ))),
          ),
        ],
      ),
    );
  }

  void updateScreen() {
    setState(() {
      this.secureText = !secureText;
    });
  }
}
