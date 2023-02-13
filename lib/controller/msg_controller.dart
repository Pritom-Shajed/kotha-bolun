import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:messenger/model/model.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class MsgController extends GetxController {
  sendMessage(
      {required userEmail,
      required message,
      required time,
      File? image}) async {
    if (image != null) {
      Reference reference = await FirebaseStorage.instance
          .ref()
          .child('images')
          .child(Uuid().v1());
      UploadTask uploadTask = reference.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print('Uploaded');
      messageModel model = messageModel(
          userEmail: userEmail,
          message: message,
          time: time,
          images: downloadUrl);

      await FirebaseFirestore.instance
          .collection('messages')
          .add(model.toJson());
    } else {
      messageModel model = messageModel(
        userEmail: userEmail,
        message: message,
        time: time,
        images: '',
      );

      await FirebaseFirestore.instance
          .collection('messages')
          .add(model.toJson());
    }
  }

  deleteMessage({required String id}) async {
    await FirebaseFirestore.instance.collection('messages').doc(id).delete();
    Fluttertoast.showToast(msg: 'Message Deleted');
  }
}
