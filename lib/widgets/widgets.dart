import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/constants/constants.dart';


Widget customButton({required String text, required VoidCallback onTap}){
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Text(text, style: TextStyle(color: Colors.white),),
    ),
  );
}

 alertDialog({required BuildContext context, required String title, required List<Widget> action}){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text(title),
      actions: action
    );
  });
}

imageDialog(BuildContext context){
  showDialog(context: context, builder: (context){
    return Dialog(
      child: Column(
        children: [],
      ),
    );
  });
}

Widget verticalSpace(){
  return Divider(color: Colors.transparent);
}
Widget horizontalSpace(){
  return SizedBox(width: 10,);
}

