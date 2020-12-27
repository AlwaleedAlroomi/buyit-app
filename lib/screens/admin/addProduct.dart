import 'package:buyit/models/product.dart';
import 'package:buyit/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:buyit/services/store.dart';

class AddProduct extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = "AddProduct";
  String _name, _price, _description, _category, _imageLocation;
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              hint: "Product Name",
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: "Product Price",
              onClick: (value) {
                _price = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: "Product Description",
              onClick: (value) {
                _description = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: "Product Category",
              onClick: (value) {
                _category = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: "Product Location",
              onClick: (value) {
                _imageLocation = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();
                  _store.addProduct(Product(
                    pName: _name,
                    pPrice: _price,
                    pDescription: _description,
                    pCategory: _category,
                    pLocation: _imageLocation,
                  ));
                }
              },
              child: Text("Add Product"),
            ),
          ],
        ),
      ),
    );
  }
}
