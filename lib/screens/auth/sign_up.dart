import 'package:flutter/material.dart';
import 'package:flutterapp1/services/auth.dart';
import 'package:flutterapp1/models/app_user.dart';
import 'package:flutterapp1/screens/auth/sign_in.dart';

import 'package:flutterapp1/shared/constants.dart';
import 'package:flutterapp1/shared/loading.dart';

import 'package:flutterapp1/utils/app_styles.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (Provider.of<AppUser?>(context) == null) {
      return loading
          ? const Loading()
          : Scaffold(
              body: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      height: 230,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/street.png"),
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 40,
                          child: Icon(
                            Icons.person,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Đăng kí",
                            style: Styles.headline1,
                          ),
                          Text(
                            "Tạo tài khoản của bạn ở đây",
                            style: Styles.textStyle1,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: boxDecoration,
                        child: TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          validator: (value) =>
                              value!.isEmpty ? "Nhập email" : null,
                          obscureText: false,
                          decoration: textInputDecoration.copyWith(
                            prefixIcon: const Icon(Icons.email),
                            hintText: "Email",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: boxDecoration,
                        child: TextFormField(
                          onChanged: (value) {
                            password = value;
                          },
                          validator: (value) => value!.length < 6
                              ? "Mật khẩu của bạn cần dài hơn 6 kí tự"
                              : null,
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                            prefixIcon: const Icon(Icons.lock),
                            hintText: "Mật khẩu",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        height: 50,
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              await AuthServices()
                                  .signUpWithEmailAndPassword(email, password);
                            }
                            loading = false;
                          },
                          child: Text(
                            "Đăng kí",
                            style: Styles.headline2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.only(right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bạn đã có tài khoản! ",
                              style: Styles.textStyle1,
                            ),
                            InkWell(
                              onTap: () {
                                context.go(context.namedLocation("sign_in"));
                              },
                              child: Text(
                                "Đăng nhập",
                                style: Styles.textStyle1
                                    .copyWith(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    } else {
      return const SignIn();
    }
  }
}
