import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class AuthContoller extends GetxController{
  static AuthContoller instance = Get.find();

  //REGISTER
  register(String emailAddress, String password) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Get.back();
      Get.snackbar('User Registered', 'Thanks for choosing \'Kotha Bolun\'');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Week Password', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Email exists', 'The account already exists for $emailAddress.');
      }
    } catch (e) {
      print(e);
      Get.back();
      Get.snackbar('Error Occured', e.toString());
    }
  }

  //LOGIN
  login(String emailAddress, String password) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      Get.snackbar('Logged In', 'Welcome back $emailAddress!');
      Get.toNamed('/chatScreen');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('User not found', 'Kindly register first');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Incorrect Password', 'Wrong password provided for $emailAddress.');
      }
    }
  }

}