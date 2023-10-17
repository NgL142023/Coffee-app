import 'package:flutter/material.dart';
import 'package:flutterapp1/services/auth.dart';
import 'package:flutterapp1/models/app_user.dart';
import 'package:flutterapp1/screens/pages/home/homepage.dart';
import 'package:flutterapp1/shared/constants.dart';
import 'package:flutterapp1/shared/loading.dart';

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
                      height: 230,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/tree.png"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.only(left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Xin chào",
                              style: Styles.headline1,
                            ),
                            Text(
                              "Đăng nhập tài khoản",
                              style: Styles.textStyle1,
                            )
                          ],
                        ),
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
                          obscureText: false,
                          validator: (value) =>
                              value!.isEmpty ? "Nhập email của bạn" : null,
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
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: boxDecoration,
                        child: TextFormField(
                            obscureText: true,
                            validator: (value) =>
                                value!.length < 6 ? "Mật khẩu quá ngắn" : null,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: "Mật khẩu",
                                prefixIcon: const Icon(Icons.lock))),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.only(right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Chưa có tài khoản? ",
                              style: Styles.textStyle1,
                            ),
                            InkWell(
                              onTap: () {
                                context.go(context.namedLocation("sign_up"));
                              },
                              child: Text(
                                "Tạo tài khoản",
                                style: Styles.textStyle1
                                    .copyWith(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
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
                                  .signInWithEmailAndPassword(email, password);
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Text(
                            "Đăng nhập",
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
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          await AuthServices().signInAnonymous();
                          loading = false;
                        },
                        child: Text(
                          "Đăng nhập ẩn danh",
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
