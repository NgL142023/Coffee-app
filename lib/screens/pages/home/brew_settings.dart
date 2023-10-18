import 'package:flutter/material.dart';
import 'package:flutterapp1/models/app_user.dart';
import 'package:flutterapp1/services/database.dart';

import 'package:flutterapp1/shared/loading.dart';

import 'package:flutterapp1/utils/app_styles.dart';
import 'package:provider/provider.dart';

class ShowSettings extends StatefulWidget {
  const ShowSettings({super.key});

  @override
  State<ShowSettings> createState() => _ShowSettingsState();
}

class _ShowSettingsState extends State<ShowSettings> {
  final _formKey = GlobalKey<FormState>();
  String? _currentName;

  String? _currentSugar;
  String? _currentIce;
  String? _currentDrinkType;
  List<String> sugars = ["0%", "25%", "50%", "75%", "100%"];
  List<String> ices = ["0%", "25%", "50%", "75%", "100%"];
  List<String> drinkList = ["cappucino", "expresso", "glace", "latte", "mocha"];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return StreamBuilder<AppUserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: ListView(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tên:"),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        maxLength: 45,
                        initialValue: snapshot.data!.name,
                        validator: (value) =>
                            value!.isEmpty ? "Nhập tên của bạn" : null,
                        onChanged: (value) => setState(
                          () {
                            _currentName = value;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Loại đồ uống:"),
                      const SizedBox(
                        height: 4,
                      ),
                      DropdownButtonFormField(
                        value: snapshot.data!.drinkType,
                        items: drinkList.map((drinkType) {
                          return DropdownMenuItem(
                            value: drinkType,
                            child: Text(drinkType),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() {
                          _currentDrinkType = value as String;
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Độ ngọt:"),
                      const SizedBox(
                        height: 4,
                      ),
                      DropdownButtonFormField(
                        value: snapshot.data!.sugar,
                        items: sugars.map((sugar) {
                          return DropdownMenuItem(
                            value: sugar,
                            child: Text(sugar),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() {
                          _currentSugar = value as String;
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Đá:"),
                      const SizedBox(
                        height: 4,
                      ),
                      DropdownButtonFormField(
                        value: snapshot.data!.ice,
                        items: ices.map((ice) {
                          return DropdownMenuItem(
                            value: ice,
                            child: Text(ice),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() {
                          _currentIce = value as String;
                        }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(
                                        _currentSugar ?? snapshot.data!.sugar,
                                        _currentName ?? snapshot.data!.name,
                                        _currentDrinkType ??
                                            snapshot.data!.drinkType,
                                        _currentIce ?? snapshot.data!.ice);

                                setState(() {});
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            },
                            child: Center(
                              child: Text(
                                "Cập nhật",
                                style: Styles.textStyle2,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
