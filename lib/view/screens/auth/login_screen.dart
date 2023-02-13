import 'package:flutter/material.dart';
import 'package:messenger/constants/constants.dart';
import 'package:get/get.dart';
import 'package:messenger/controller/auth_controller.dart';
import 'package:messenger/widgets/widgets.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(12),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Login Now, অনেক কথা জমে আছে!', style: titleTextStyle,),
                    SizedBox(
                      height: 200,
                      child: Image.asset('assets/images/banner.png'),
                    ),
                    verticalSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        horizontalSpace(),
                        Text('KOTHA BOLUN', style: titleTextStyle),
                      ],
                    ),
                    verticalSpace(),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field can\'t be empty';
                        } else if (!value.contains(RegExp('@'))) {
                          return 'Enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: borderColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    verticalSpace(),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field can\'t be empty';
                        } else {
                          return null;
                        }
                      },
                      controller: _passController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: borderColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    verticalSpace(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: customTextButton(
                        text: 'Login',
                        bgColor: Colors.blue,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            AuthContoller.instance.login(
                                _emailController.text, _passController.text);
                          }
                        },
                      ),
                    ),
                    verticalSpace(),
                    Row(
                      children: [
                        Text('Don\'t have an account?'),
                        InkWell(
                            onTap: () {
                              Get.toNamed('/register');
                            },
                            child: Text(
                              ' Register Now',
                              style: TextStyle(color: blueColor),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
