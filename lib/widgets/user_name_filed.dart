import 'package:flutter/material.dart';
import 'package:web_application/models/login_info.dart';

import '../utilis.dart';

class UserNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.length < 5) {
            return 'user name must be al least 5 characters';
          }
          return null;
        },
        onChanged: (value) {
          LoginInfo.name = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.portrait_rounded,
              color: mainColor,
            ),
            labelText: 'User name'),
      ),
    );
  }
}
