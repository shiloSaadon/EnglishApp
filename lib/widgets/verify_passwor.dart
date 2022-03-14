import 'package:flutter/material.dart';
import 'package:web_application/models/login_info.dart';

import '../utilis.dart';

class VerifyPasswordField extends StatefulWidget {
  @override
  _VerifyPasswordFieldState createState() => _VerifyPasswordFieldState();
}

class _VerifyPasswordFieldState extends State<VerifyPasswordField> {
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
              if (value != LoginInfo.password) {
                return "Incompatible passwords";
              }
              return null;
            },
            onChanged: (value) {
              LoginInfo.verifyPassword = value;
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: mainColor,
                ),
                labelText: 'Verify password',
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
