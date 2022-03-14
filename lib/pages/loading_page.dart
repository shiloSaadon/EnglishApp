import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_application/loadingUtilis.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/pages/home_page.dart';
import 'package:web_application/pages/login_package/entrance_page.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:provider/provider.dart';
import '../utilis.dart';

class LoadingPage extends StatelessWidget {
  late WordsProvider wordsProvider;

  @override
  Widget build(BuildContext context) {
    wordsProvider = context.read<
        WordsProvider>(); //this gonna give us total height and with of our device
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: FutureBuilder<bool>(
            future: stupAllData(context, wordsProvider),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                print("snapshot.data: ${snapshot.data}");
                if (snapshot.data == false) {
                  print("aaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                  return EntrancePage();
                }
                // Future.microtask(() => Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (_) => HomePage())));
                return HomePage();
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
                      'Loading your data..',
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
}
