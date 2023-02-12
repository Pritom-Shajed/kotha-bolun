import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/constants/constants.dart';
import 'package:messenger/controller/msg_controller.dart';
import 'package:messenger/view/screens/chat/all_chats.dart';
import 'package:messenger/widgets/widgets.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageTxtCtrl = new TextEditingController();

  File? myImage;

  @override
  Widget build(BuildContext context) {
    MsgController msgController = Get.find();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
                child: Image.asset('assets/images/logo.png'),
              ),
              Text(
                ' Kotha Bolun',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: WillPopScope(
          onWillPop: () {
            return alertDialog(
                context: context,
                title: 'Are you sure to exit?',
                action: [
                  TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: Text(
                        'Yes',
                        style: blueText,
                      )),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'No',
                        style: blueText,
                      )),
                ]);
          },
          child: Column(
            children: [
              Expanded(child: AllChats()),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey.shade200,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: messageTxtCtrl,
                                decoration: InputDecoration(
                                    hintText: 'Enter your message...',
                                    filled: true,
                                    fillColor: Colors.grey.shade200),
                              ),
                            ),
                            InkWell(
                                onTap: () async {
                                  XFile? selectedImage = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (selectedImage != null) {
                                    File convertedFile =
                                        File(selectedImage.path);
                                    setState(() {
                                      myImage = convertedFile;
                                    });
                                  } else {}
                                },
                                child: Icon(Icons.camera_alt_rounded)),
                            horizontalSpace(),
                          ],
                        ),
                      ),
                    ),
                    horizontalSpace(),
                    customButton(
                        text: 'Send',
                        onTap: () {
                          msgController.sendMessage(
                            userEmail: FirebaseAuth.instance.currentUser!.email
                                .toString(),
                            message: messageTxtCtrl.text,
                            time: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            image: myImage,
                          );
                          setState(() {
                            myImage == null;
                          });
                          messageTxtCtrl.clear();
                        })
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
