import 'package:flutter/material.dart';
import 'package:flutterapp1/services/auth.dart';
import 'package:flutterapp1/models/app_user.dart';
import 'package:flutterapp1/screens/pages/home/homepage.dart';
import 'package:flutterapp1/shared/constants.dart';
import 'package:flutterapp1/shared/loading.dart';

import 'package:flutterapp1/utils/app_layout.dart';
import 'package:flutterapp1/utils/app_styles.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "";
  String password = "";
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
                      height: AppLayout.getHeight(230),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/tree.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppLayout.getHeight(12),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: AppLayout.getWidth(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello",
                              style: Styles.headline1,
                            ),
                            Text(
                              "Sign in to your account",
                              style: Styles.textStyle1,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppLayout.getHeight(30),
                    ),
                    Align(
                      child: Container(
                        height: AppLayout.getHeight(40),
                        width: AppLayout.getScreenWidth() * 0.9,
                        decoration: boxDecoration,
                        child: TextFormField(
                          obscureText: false,
                          validator: (value) =>
                              value!.isEmpty ? "enter your email" : null,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: textInputDecoration.copyWith(
                            hintText: "Email",
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppLayout.getHeight(24),
                    ),
                    Align(
                      child: Container(
                        height: AppLayout.getHeight(40),
                        width: AppLayout.getScreenWidth() * 0.9,
                        decoration: boxDecoration,
                        child: TextFormField(
                            obscureText: true,
                            validator: (value) =>
                                value!.length < 6 ? "too short" : null,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.lock))),
                      ),
                    ),
                    SizedBox(
                      height: AppLayout.getHeight(24),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.only(right: AppLayout.getWidth(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: Styles.textStyle1,
                            ),
                            InkWell(
                              onTap: () {
                                context.go(context.namedLocation("sign_up"));
                              },
                              child: Text(
                                "Create",
                                style: Styles.textStyle1
                                    .copyWith(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppLayout.getHeight(25),
                    ),
                    Align(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        height: AppLayout.getHeight(50),
                        width: AppLayout.getWidth(120),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              await AuthServices()
                                  .signInWithEmailAndPassword(email, password);
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Text(
                            "Sign in",
                            style: Styles.headline2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppLayout.getHeight(60),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          await AuthServices().signInAnonymous();
                          loading = false;
                        },
                        child: Text(
                          "Sign in Anonymous",
                          style: Styles.headline1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    } else {
      return const HomePage();
    }
  }
}
