import 'package:buyit/constants.dart';
import 'package:buyit/screens/admin/addProduct.dart';
import 'package:buyit/screens/admin/editProduct.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  static String id = "AdminHomeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kMainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              child: Text("Add Product"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProduct.id);
              },
              child: Text("Edit Product"),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("View Orders"),
            ),
          ],
        ));
  }
}
