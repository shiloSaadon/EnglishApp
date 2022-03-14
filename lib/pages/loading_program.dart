import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:web_application/services/cliesnt.dart';
import 'package:provider/provider.dart';
import 'package:web_application/utilis.dart';

import 'loading_page.dart';

class LoadingProgram extends StatefulWidget {
  @override
  _LoadingProgramState createState() => _LoadingProgramState();
}

class _LoadingProgramState extends State<LoadingProgram> {
  late WordsProvider wordsProvider;
  late BuildContext ctn;
  @override
  Widget build(BuildContext context) {
    if (LoginInfo.name == "") Navigator.pop(context);
    ctn = context;
    wordsProvider = context.read<WordsProvider>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: FutureBuilder<bool>(
            future: createUserData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                //Future.microtask(() => Navigator.of(context)
                //    .push(MaterialPageRoute(builder: (_) => LoadingPage())));
                return LoadingPage();
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 20),
                    child: Text(
                      'preparing your new account..',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                ];
              }
              return Container(
                width: relativeWidth(width: 650, context: context),
                height: relativeHeigth(heigth: 1050, context: context),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: children),
              );
            },
          ),
        ),
      ),
    );
  }

  BoxDecoration background() {
    return BoxDecoration(
        image: DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage("assets/app_background.jpg"),
    ));
  }

  Future<bool> createUserData() async {
    var client = Client();
    await client.startDefaultProgram();
    return true;
  }
}
