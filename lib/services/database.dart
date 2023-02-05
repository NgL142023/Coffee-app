import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp1/models/app_user.dart';
import 'package:flutterapp1/models/brew.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brewData");

  AppUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return AppUserData(
        uid: uid,
        name: snapshot.get("name"),
        strength: snapshot.get("strength"),
        sugar: snapshot.get("sugar"));
  }

  Future updateUserData(String sugar, String name, int strength) async {
    await brewCollection.doc(uid).set({
      "sugar": sugar,
      "name": name,
      "strength": strength,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((brew) {
      return Brew(
        name: brew["name"] ?? "",
        strength: brew["strength"] ?? 0,
        sugar: brew["sugar"] ?? "",
      );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<AppUserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
