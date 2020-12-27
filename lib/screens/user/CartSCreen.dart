import 'package:buyit/constants.dart';
import 'package:buyit/models/product.dart';
import 'package:buyit/provider/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = "CartScreen";
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appbarheight = AppBar().preferredSize.height;
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(children: <Widget>[
        LayoutBuilder(builder: (context, constrains) {
          if (products.isNotEmpty) {
            return Container(
              height: screenHeight -
                  statusbarHeight -
                  appbarheight -
                  (screenHeight * 0.08),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () => showCustomMenu(),
                      child: Container(
                        color: kSecondryColor,
                        height: screenHeight * 0.15,
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: screenHeight * 0.15 / 2,
                              backgroundImage:
                                  AssetImage(products[index].pLocation),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          products[index].pName,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "\$${products[index].pPrice}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(
                                      products[index].pQuantity.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container(
              height: screenHeight -
                  (screenHeight * 0.08) -
                  statusbarHeight -
                  appbarheight,
            );
          }
        }),
        ButtonTheme(
          minWidth: screenWidth,
          height: screenHeight * 0.08,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text("Order".toUpperCase()),
            color: kMainColor,
            onPressed: () {},
          ),
        )
      ]),
    );
  }

  void showCustomMenu() {}
}
