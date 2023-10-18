import 'package:flutter/material.dart';
import 'package:flutterapp1/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({super.key, required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        margin: const EdgeInsets.all(20),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/${brew.drinkType}.png"),
          ),
          title: Text("${brew.name}  ( ${brew.drinkType} )"),
          subtitle: Text("Độ ngọt: ${brew.sugar} / Đá: ${brew.ice}"),
        ),
      ),
    );
  }
}
