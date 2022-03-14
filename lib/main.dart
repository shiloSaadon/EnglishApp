import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:flutter/material.dart';
import 'package:web_application/pages/loading_page.dart';
import 'package:web_application/pages/login_package/entrance_page.dart';
import 'package:provider/provider.dart';
import 'package:web_application/providers/progress_provider.dart';
import 'package:web_application/providers/timer_provider.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:web_application/services/app_data_base.dart/data_base_api.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<WordsProvider>(create: (_) => WordsProvider()),
      ChangeNotifierProvider<TimerProvider>(create: (_) => TimerProvider()),
      ChangeNotifierProvider<ProgressProvider>(
          create: (_) => ProgressProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BackGestureWidthTheme(
      backGestureWidth: BackGestureWidth.fraction(1 / 3),
      child: MaterialApp(
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.fuchsia:
                  CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
              TargetPlatform.linux:
                  CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
              TargetPlatform.macOS:
                  CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
              TargetPlatform.windows:
                  CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
              TargetPlatform.android:
                  CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
              TargetPlatform.iOS:
                  CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
            },
          ),
        ),
        home: LoadingPage(),
      ),
    );
    //initialRoute: '/',
    // routes: <String, WidgetBuilder>{
    //   '/loading_page': (BuildContext ctx) => LoadingPage(),
    //   '/first_page': (BuildContext ctx) => FirstPage(),
    //   '/learning_page': (BuildContext ctx) => LearningMode(),
    //   '/practice_page': (BuildContext ctx) => PracticeMode(),
    //   '/simple_he_to_en': (BuildContext ctx) => SimpleHeToEn(),
    //   '/loading_program': (BuildContext ctx) => LoadingProgram(),
    //   '/home_page': (BuildContext ctx) => HomePage(),
    //   '/level_up_page': (BuildContext ctx) => LevelUpPage(),
    //   '/': (BuildContext ctx) => EntrancePage(),
    // }));
  }
}
