import 'package:buyit/provider/adminMode.dart';
import 'package:buyit/provider/cartItem.dart';
import 'package:buyit/provider/modelHud.dart';
import 'package:buyit/screens/admin/addProduct.dart';
import 'package:buyit/screens/admin/Manageproduct.dart';
import 'package:buyit/screens/admin/AdminHome.dart';
import 'package:buyit/screens/admin/editProduct.dart';
import 'package:buyit/screens/user/CartSCreen.dart';
import 'package:buyit/screens/user/HomePage.dart';
import 'package:buyit/screens/login_screen.dart';
import 'package:buyit/screens/signup_screen.dart';
import 'package:buyit/screens/user/productinfo.dart';
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
        ChangeNotifierProvider<ModelHud>(create: (context) => ModelHud()),
        ChangeNotifierProvider<AdminMode>(create: (context) => AdminMode()),
        ChangeNotifierProvider<CartItem>(create: (context) => CartItem()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePageScreen.id: (context) => HomePageScreen(),
          AdminHomeScreen.id: (context) => AdminHomeScreen(),
          AddProduct.id: (context) => AddProduct(),
          ManageProduct.id: (context) => ManageProduct(),
          EditProduct.id: (context) => EditProduct(),
          ProductInfo.id: (context) => ProductInfo(),
          CartScreen.id: (context) => CartScreen(),
        },
      ),
    );
  }
}
