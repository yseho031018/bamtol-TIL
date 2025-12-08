import 'package:bamtol/src/app.dart';
import 'package:bamtol/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bamtol/src/splash/controller/splash_controller.dart';
import 'package:bamtol/src/common/controller/data_load_controller.dart';
import 'package:bamtol/src/common/controller/authentication_controller.dart';
import 'package:bamtol/src/home/page/home_page.dart';
import 'package:bamtol/src/user/login/page/login_page.dart';
import 'package:bamtol/src/user/login/controller/login_controller.dart';
import 'package:bamtol/src/user/repository/authentication_repository.dart';
import 'package:bamtol/src/user/repository/user_repository.dart';
import 'package:bamtol/src/user/signup/page/signup_page.dart';
import 'package:bamtol/src/user/signup/controller/signup_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '당근마켓 클론코딩',
      initialRoute: '/',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Color(0xff212123),
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xff212123),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthenticationRepository(FirebaseAuth.instance));
        Get.put(UserRepository(FirebaseFirestore.instance));
        Get.put(SplashController());
        Get.put(DataLoadController());
        Get.put(AuthenticationController(
          Get.find<AuthenticationRepository>(),
          Get.find<UserRepository>(),
        ));
      }),
      getPages: [
        GetPage(name: '/', page: () => const App()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut<LoginController>(
              () => LoginController(Get.find<AuthenticationRepository>()));
          }),
        ),
        GetPage(
          name: '/signup/:uid',
          page: () => SignupPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut<SignupController>(
              () => SignupController(
                Get.find<UserRepository>(),
                Get.parameters['uid'] ?? '',
              ));
          }),
        ),
      ],
    );
  }
}
