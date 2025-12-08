import 'package:flutter/material.dart';
import 'package:bamtol/main.dart';
import 'package:bamtol/src/init/page/init_start_page.dart';
import 'package:bamtol/src/splash/page/splash_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late bool isInitStarted;

  @override
  void initState() {
    super.initState();
    isInitStarted = prefs.getBool('isInitStarted') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return isInitStarted 
      ? InitStartPage(
          onStart: () {
            setState(() {
              isInitStarted = false;
            });
            prefs.setBool('isInitStarted', isInitStarted);
          },
        )
      : const SplashPage();
  }
}
