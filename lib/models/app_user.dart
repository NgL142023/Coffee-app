class AppUser {
  final String? uid;

  AppUser({this.uid});
}

class AppUserData {
  String? uid;
  String name;
  String sugar;
  String drinkType;
  String ice;

  AppUserData(
      {required this.uid,
      required this.name,
      required this.drinkType,
      required this.ice,
      required this.sugar});
}
