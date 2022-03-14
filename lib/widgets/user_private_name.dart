import 'package:flutter/material.dart';
import 'package:web_application/models/login_info.dart';

import '../utilis.dart';

class UserPrivateNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.length < 2) {
            return 'private name must be al least 2 characters';
          }
          return null;
        },
        onChanged: (value) {
          LoginInfo.privateName = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.face,
              color: mainColor,
            ),
            labelText: 'Private name'),
      ),
    );
  }
}
