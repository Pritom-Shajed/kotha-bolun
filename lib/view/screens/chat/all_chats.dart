import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/constants/constants.dart';
import 'package:messenger/controller/msg_controller.dart';
import 'package:get/get.dart';
import 'package:messenger/widgets/widgets.dart';

class AllChats extends StatelessWidget {
  static MsgController msgController = Get.find();

  const AllChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MsgController msgController = Get.find();
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                reverse: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> messageMap =
                      snapshot.data!.docs[index].data();
                  messageByMe:
                  FirebaseAuth.instance.currentUser!.email ==
                          messageMap['userEmail']
                      ? true
                      : false;
                  return MessageListItem(
                    id: snapshot.data!.docs[index].id,
                    email: messageMap['userEmail'],
                    message: messageMap['message'],
                    isMessageByMe: FirebaseAuth.instance.currentUser!.email ==
                            messageMap['userEmail']
                        ? true
                        : false,
                    image: messageMap['images'],
                    isImageSent: messageMap['images'] != '' ? true : false,
                  );
                });
          } else {
            return Container();
          }
        });
  }
}

class MessageListItem extends StatelessWidget {
  MsgController msgController = Get.find();

  String id;
  String message;
  String email;
  bool isMessageByMe;
  String image;
  bool isImageSent;

  MessageListItem(
      {Key? key,
      required this.id,
      required this.email,
      required this.message,
      required this.isMessageByMe,
      required this.image,
      required this.isImageSent,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: isMessageByMe == true
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(email),
          InkWell(
            onLongPress: (){
              isMessageByMe == true
                  ? alertDialog(
                context: context,
                title: 'Delete the message?',
                action: [
                  TextButton(onPressed: (){
                    msgController.deleteMessage(id: id);
                    Get.back();
                  }, child: Text('Yes')),
                  TextButton(onPressed: (){
                    Get.back();
                  }, child: Text('No'))
                ],
              )
                  : null;
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: isMessageByMe == true ? blueColor : greyColor,
                  borderRadius: BorderRadius.only(
                    topRight: isMessageByMe == true
                        ? Radius.circular(0)
                        : Radius.circular(24),
                    topLeft: isMessageByMe == true
                        ? Radius.circular(24)
                        : Radius.circular(0),
                    bottomRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  )),
              child: Text(
                message,
                style: TextStyle(
                    color: isMessageByMe == true ? whiteColor : blackColor),
              ),
            ),
          ),
           SizedBox(height: 5,),
           isImageSent == true?
           Container(
             height: 200,
             width: 200,
             decoration: BoxDecoration(
               image: DecorationImage(image: NetworkImage(image),),
             ),
          ): Container(),
        ],
      ),
    );
  }
}
