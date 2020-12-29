import 'package:buyit/constants.dart';
import 'package:buyit/functsion.dart';
import 'package:buyit/models/product.dart';
import 'package:buyit/screens/login_screen.dart';
import 'package:buyit/screens/user/CartSCreen.dart';
import 'package:buyit/screens/user/productinfo.dart';
import 'package:buyit/services/auth.dart';
import 'package:buyit/services/store.dart';
import 'package:buyit/widgets/productView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  static String id = "HomePageScreen";

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _auth = Auth();
  User _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();
  List<Product> _products;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: kMainColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: _bottomBarIndex,
              onTap: (value) async{
                if(value == 2){
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.clear();
                  await _auth.SignOut();
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                }
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "test"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "test"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.close), label: "Sign Out"),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: [
                  Text(
                    "Jackets",
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    "Trouser",
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    "T-shirts",
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    "Shoes",
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                jacketView(),
                productView(kTrousers, _products),
                productView(kTshirts, _products),
                productView(kShoes, _products),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Discover".toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, CartScreen.id),
                    child: Icon(Icons.shopping_cart),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.docs) {
            var data = doc.data();

            products.add(Product(
              pId: doc.id,
              pName: data[kProductName],
              pPrice: data[kProductPrice],
              pDescription: data[kProductDescription],
              pCategory: data[kProductCategory],
              pLocation: data[kProductLocation],
            ));
          }
          _products = [...products];
          products.clear();
          products = getProductByCategory(kJackets, _products);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: .8),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, ProductInfo.id,
                    arguments: products[index]),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(products[index].pLocation),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .6,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].pName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("\$ ${products[index].pPrice}"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            itemCount: products.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void initState() {
     getCurrentUser();
   }

  getCurrentUser() async {
     _loggedUser = await _auth.getUser();
   }
}
