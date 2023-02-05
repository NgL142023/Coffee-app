import 'package:flutter/material.dart';
import 'package:flutterapp1/models/brew.dart';
import 'package:flutterapp1/screens/pages/home/brew_list.dart';
import 'package:flutterapp1/screens/pages/home/brew_settings.dart';

import 'package:flutterapp1/services/auth.dart';
import 'package:flutterapp1/services/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void showBottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return const ShowSettings();
          });
    }

    return StreamProvider<List<Brew>>.value(
      initialData: const [],
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("HomePage"),
          elevation: 0,
          actions: [
            ElevatedButton.icon(
              onPressed: () async {
                await AuthServices().signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text("Logout"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showBottomSheet();
              },
              icon: const Icon(Icons.settings),
              label: const Text("Settings"),
            ),
          ],
        ),
        body: const BrewList(),
      ),
    );
  }
}
