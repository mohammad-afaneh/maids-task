// ignore_for_file: camel_case_types, use_build_context_synchronously, deprecated_member_use, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:maidstask/utils/flushbar/flushbar_meesage.dart';

import '../controller/apis.dart';
import '../utils/MySharedPreferences.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController UserNameController = TextEditingController();
  TextEditingController PassController = TextEditingController();
  FocusNode? focusNodePass = FocusNode();
  GlobalKey<FormState> dataFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(234, 237, 245, 1),
        body: Form(
          key: dataFormKey,
          child: ListView(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Center(
                child: Image.asset('assets/logo/LogoMaids.png',
                    width: width * 0.5,
                    height: height * 0.3,
                    fit: BoxFit.fill,
                    opacity: const AlwaysStoppedAnimation(.7)),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                'Let us manage your tasks',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: height * 0.023,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Container(
                  color: Colors.transparent,
                  child: TextFormField(
                    controller: UserNameController,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    cursorHeight: height * 0.032,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter User Name";
                      } else {
                        return null;
                      }
                    },
                    cursorColor: const Color.fromRGBO(64, 106, 179, 1),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(64, 106, 179, 1),
                          width: 2,
                        ),
                      ),
                      label: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'User Name',
                            style: TextStyle(
                                color: Color.fromRGBO(10, 124, 109, 1)),
                          )),
                      labelStyle: const TextStyle(
                          color: Color.fromRGBO(64, 106, 179, 1)),
                      suffixIcon: Icon(
                        Icons.person,
                        color: const Color.fromRGBO(64, 106, 179, 1),
                        size: height * 0.03,
                      ),
                    ),
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focusNodePass);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Container(
                  color: Colors.transparent,
                  child: TextFormField(
                    controller: PassController,
                    focusNode: focusNodePass,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    cursorHeight: height * 0.032,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      } else {
                        return null;
                      }
                    },
                    cursorColor: const Color.fromRGBO(64, 106, 179, 1),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(64, 106, 179, 1),
                          width: 2,
                        ),
                      ),
                      label: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(
                                color: Color.fromRGBO(64, 106, 179, 1)),
                          )),
                      labelStyle: const TextStyle(
                          color: Color.fromRGBO(64, 106, 179, 1)),
                      suffixIcon: Icon(
                        Icons.password,
                        color: const Color.fromRGBO(64, 106, 179, 1),
                        size: height * 0.03,
                      ),
                    ),
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focusNodePass);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.3),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(64, 106, 179, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () async {
                      if (dataFormKey.currentState!.validate()) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return Dialog(
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: width * 0.1,
                                          height: height * 0.05,
                                          child:
                                              const CircularProgressIndicator(
                                                  color: Color.fromRGBO(
                                                      64, 106, 179, 1))),
                                      SizedBox(
                                        width: width * 0.2,
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 7),
                                          child: const Text(
                                            "please wait",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            });

                        var LoginRes = await ApisManage().Login(
                          UserNameController.text.trim(),
                          PassController.text.trim(),
                        );

                        if (LoginRes['id'] != null) {
                          MySharedPreferences.isLogIn = true;
                          MySharedPreferences.loginId = LoginRes['id'];
                          MySharedPreferences.fullName = LoginRes['firstName'] +
                              ' ' +
                              LoginRes['lastName'];

                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomeScreen(),
                            ),
                          );
                        } else {
                          Navigator.of(context).pop();
                          MyFlushbar().FlushbarMess(
                              'Please make sure that the User Name and password are correct',
                              context);
                        }
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Log in',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
