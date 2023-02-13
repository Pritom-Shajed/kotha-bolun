import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/constants/constants.dart';


Widget customTextButton({required String text, required Color bgColor, required VoidCallback onTap}){
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Text(text, style: TextStyle(color: whiteColor),)
    ),
  );
}

Widget customIconButton({required IconData icon, required Color bgColor, required VoidCallback onTap}){
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(40)
      ),
      child: Icon(icon, color: Colors.white,),
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


Widget verticalSpace(){
  return Divider(color: Colors.transparent);
}
Widget horizontalSpace(){
  return SizedBox(width: 10,);
}

