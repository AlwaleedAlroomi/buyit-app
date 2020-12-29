import 'package:buyit/constants.dart';
import 'package:buyit/provider/adminMode.dart';
import 'package:buyit/provider/cartItem.dart';
import 'package:buyit/provider/modelHud.dart';
import 'package:buyit/screens/admin/EditProduct.dart';
import 'package:buyit/screens/admin/OrdersScreen.dart';
import 'package:buyit/screens/admin/addProduct.dart';
import 'package:buyit/screens/admin/Manageproduct.dart';
import 'package:buyit/screens/admin/AdminHome.dart';
import 'package:buyit/screens/admin/order_details.dart';
import 'package:buyit/screens/user/CartSCreen.dart';
import 'package:buyit/screens/user/HomePage.dart';
import 'package:buyit/screens/login_screen.dart';
import 'package:buyit/screens/signup_screen.dart';
import 'package:buyit/screens/user/productinfo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
        builder: (context, snapshot)
            {
              if(!snapshot.hasData)
                {
                  return MaterialApp(
                    home: Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
              else{
                isUserLoggedIn = snapshot.data.getBool(kKeepMeLoggedIn) ?? false;
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider<ModelHud>(create: (context) => ModelHud()),
                    ChangeNotifierProvider<AdminMode>(create: (context) => AdminMode()),
                    ChangeNotifierProvider<CartItem>(create: (context) => CartItem()),
                  ],
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialRoute: isUserLoggedIn ? HomePageScreen.id : LoginScreen.id,
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
                      OrderScreen.id: (context) => OrderScreen(),
                      OrderDetails.id: (context) => OrderDetails(),
                    },
                  ),
                );
              }
            },
    );
  }
}
