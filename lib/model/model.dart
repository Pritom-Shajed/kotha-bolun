import 'package:cloud_firestore/cloud_firestore.dart';

class messageModel {
  String? userEmail;

  String? message;

  String? time;

  String? images;

  messageModel({
    this.userEmail,
    this.message,
    this.time,
    this.images
  });

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'message': message,
      'time': time,
      'images': images,
    };
  }

  static messageModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return messageModel(
      userEmail: snapshot['userEmail'],
      message: snapshot['message'],
      time: snapshot['time'],
      images: snapshot['images']
    );
  }
}
