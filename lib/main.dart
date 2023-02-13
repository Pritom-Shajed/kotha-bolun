import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger/bindings/bindings.dart';
import 'package:messenger/controller/auth_controller.dart';
import 'package:messenger/view/screens/auth/login_screen.dart';
import 'package:get/get.dart';
import 'package:messenger/view/screens/auth/reg_screen.dart';
import 'package:messenger/view/screens/chat/chat_screen.dart';
import 'package:messenger/view/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then(
    (value) => Get.put(AuthContoller()),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: '/splashScreen', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/register', page: () => RegScreen()),
        GetPage(name: '/chatScreen', page: ()=> ChatScreen(), binding: ChatScreenBinding()),
      ],
      initialRoute: '/splashScreen',
    );
  }
}
