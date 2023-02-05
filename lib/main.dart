import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp1/services/auth.dart';
import 'package:flutterapp1/models/app_user.dart';
import 'package:flutterapp1/screens/auth/sign_in.dart';
import 'package:flutterapp1/screens/auth/sign_up.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthServices().user,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        routerDelegate: _router.routerDelegate,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: "/sign_in",
  routes: [
    GoRoute(
      name: "sign_in",
      path: "/sign_in",
      builder: (context, state) => const SignIn(),
    ),
    GoRoute(
      path: "/sign_up",
      name: "sign_up",
      builder: (context, state) => const SignUp(),
    )
  ],
);
