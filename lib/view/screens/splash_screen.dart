import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/constants/constants.dart';
import 'package:messenger/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offAllNamed('/login');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset('assets/images/logo.png'),
            ),
            Text('KOTHA BOLUN', style: titleTextStyle),
            verticalSpace(),
            SizedBox(width: MediaQuery.of(context).size.width/2.5,child: LinearProgressIndicator(color: blueColor,)),
          ],
        ),
      ),
    );
  }
}
