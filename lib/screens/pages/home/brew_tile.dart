import 'package:flutter/material.dart';
import 'package:flutterapp1/models/brew.dart';
import 'package:flutterapp1/utils/app_layout.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({super.key, required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppLayout.getHeight(8)),
      child: Card(
        margin: const EdgeInsets.all(20),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text(brew.sugar),
        ),
      ),
    );
  }
}
