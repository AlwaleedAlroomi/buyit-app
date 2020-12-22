import 'package:buyit/provider/adminMode.dart';
import 'package:buyit/provider/modelHud.dart';
import 'package:buyit/screens/admin/addProduct.dart';
import 'package:buyit/screens/admin/editProduct.dart';
import 'file:///M:/flutter%20project/buyit/lib/screens/admin/AdminHome.dart';
import 'file:///M:/flutter%20project/buyit/lib/screens/user/HomePage.dart';
import 'package:buyit/screens/login_screen.dart';
import 'package:buyit/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
            create:(context) => ModelHud()),
        ChangeNotifierProvider<AdminMode>(
            create: (context) => AdminMode()),
      ],
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePageScreen.id: (context) => HomePageScreen(),
          AdminHomeScreen.id: (context) => AdminHomeScreen(),
          AddProduct.id: (context) => AddProduct(),
          EditProduct.id: (context) => EditProduct(),
        },
      ),
    );
  }
}
