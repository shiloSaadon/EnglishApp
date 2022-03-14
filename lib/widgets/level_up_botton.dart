import 'dart:io';

import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/loadingUtilis.dart';
import 'package:web_application/pages/loading_page.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:web_application/services/cliesnt.dart';

import '../utilis.dart';

class LevelUpBotton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LevelUpBottonState();
}

class LevelUpBottonState extends State<LevelUpBotton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => updateScreen(),
      child: Container(
        width: relativeWidth(width: 600, context: context),
        height: relativeHeigth(heigth: 200, context: context),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(5, 7),
                blurRadius: 10,
                spreadRadius: -3,
                color: Colors.grey,
              ),
            ],
            //border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            )),
        child: isLoading ? loadingWidget() : bottonWidget(),
      ),
    );
  }

  Icon bottonWidget() {
    return Icon(
      Icons.upgrade,
      size: 50,
    );
  }

  FutureBuilder<bool> loadingWidget() {
    return FutureBuilder<bool>(
        future: levelUp(context),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data! == true) {
              WordsProvider wordsProvider = context.read<WordsProvider>();
              wordsProvider.wordsToPass = [];
              wordsProvider.allWordsData = {};
              Future.microtask(
                  () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Sussesfuly get new words"),
                        duration: Duration(milliseconds: 1200),
                      )));
              Future.microtask(() => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoadingPage(),
                    ),
                    (route) => false,
                  ));
            } else {
              Future.microtask(
                  () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("You already got all the words!"),
                        duration: Duration(milliseconds: 1500),
                      )));
            }
          } else if (snapshot.hasError) {
            Future.microtask(
                () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("it was an error try again latter"),
                      duration: Duration(milliseconds: 1500),
                    )));
          } else {}
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: 40, height: 40, child: CircularProgressIndicator()),
            ],
          );
        });
  }

  void updateScreen() {
    if (!this.isLoading) {
      setState(() {
        this.isLoading = true;
      });
    }
  }

  Future<bool> levelUp(BuildContext context) async {
    var client = Client();
    bool response = await client.levelUp();
    return response;
  }
}
