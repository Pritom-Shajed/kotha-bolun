import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class AuthContoller extends GetxController{
  static AuthContoller instance = Get.find();

  register(String emailAddress, String password) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.snackbar('Week Password', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.snackbar('Email exists', 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error Occured', e.toString());
      Get.back();
    }
  }

  login(String emailAddress, String password) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      Get.toNamed('/chatScreen');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar('User not found', 'Kindly register first');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.snackbar('Incorrect Password', 'Wrong password provided for $emailAddress.');
      }
    }
  }

}