import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../models/login_info.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>['email', 'profile', 'openid'],
);

Future<LoginInfo> signInwithGoogle(BuildContext context) async {
  LoginInfo loginInfo = LoginInfo();

  try {
    // start sign in
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    print(googleSignInAuthentication.toString());
  } catch (Excepion) {
    print("errore: $Excepion");
  }
  return loginInfo;
}
