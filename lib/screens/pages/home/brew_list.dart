import 'package:flutter/material.dart';
import 'package:flutterapp1/models/brew.dart';
import 'package:flutterapp1/screens/pages/home/brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brew = Provider.of<List<Brew>>(context);
    return ListView.builder(
        itemCount: brew.length,
        itemBuilder: (context, index) {
          return BrewTile(brew: brew[index]);
        });
  }
}
