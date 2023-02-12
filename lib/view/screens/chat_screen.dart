import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/constants/constants.dart';
import 'package:messenger/widgets/widgets.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                                decoration: InputDecoration(
                                    hintText: 'Enter your message...',
                                    filled: true,
                                    fillColor: Colors.grey.shade200),
                              ),
                            ),
                            InkWell(onTap: (){
                              pickImage(ImageSource.camera);
                            },child: Icon(Icons.camera_alt_rounded)),
                            horizontalSpace(),
                          ],
                        ),
                      ),
                    ),
                    horizontalSpace(),
                    customButton(text: 'Send', onTap: () {})
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
