import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: messageTxtCtrl,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                hintText: 'Enter your message...',
                                hintStyle: TextStyle(color: greyColor),
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () async {
                                alertDialog(context: context, title: 'Select Camera or Gallery', action: [
                                  TextButton(onPressed: () async{
                                    XFile? selectedImage = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                      File convertedFile = File(selectedImage!.path);
                                      setState(() {
                                        myImage = convertedFile;
                                      });
                                      Get.back();
                                      Fluttertoast.showToast(msg: 'Image Selected!');

                                  }, child: Text('Camera')),
                                  TextButton(onPressed: () async{
                                    XFile? selectedImage = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                      File convertedFile = File(selectedImage!.path);
                                      setState(() {
                                        myImage = convertedFile;
                                      });
                                      Get.back();
                                      Fluttertoast.showToast(msg: 'Image Selected!');

                                  }, child: Text('Gallery')),
                                ]);
                                ;

                              },
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: whiteColor,
                              )),
                          horizontalSpace(),
                        ],
                      ),
                    ),
                    horizontalSpace(),
                    customIconButton(
                        icon: Icons.send,
                        bgColor: Colors.blue,
                        onTap: () {
                          if (messageTxtCtrl.text != '') {
                            msgController.sendMessage(
                              userEmail: FirebaseAuth
                                  .instance.currentUser!.email
                                  .toString(),
                              message: messageTxtCtrl.text,
                              time: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              image: myImage,
                            );
                            setState(() {
                              myImage = null;
                            });
                            messageTxtCtrl.clear();
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Type your message to send');
                          }
                        }),
                  ],
                ),
              ),
              myImage != null ?
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: greyColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width/2,
                          width: MediaQuery.of(context).size.width/2,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: FileImage(myImage!))
                            ),
                        ),
                        horizontalSpace(),
                        Column(
                          children: [
                            customIconButton(icon: Icons.close, bgColor: redColor, onTap: (){
                              setState(() {
                                myImage = null;
                              });
                            }),
                            Text('Cancel', style: TextStyle(color: redColor),)
                          ],
                        )
                      ],
                    ),
                  ): Container(),
            ],
          ),
        ));
  }
}
