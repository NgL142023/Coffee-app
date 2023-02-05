class AppUser {
  final String? uid;

  AppUser({this.uid});
}

class AppUserData {
  String? uid;
  String name;
  String sugar;
  int strength;
  AppUserData(
      {required this.uid,
      required this.name,
      required this.strength,
      required this.sugar});
}
