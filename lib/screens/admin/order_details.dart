import 'package:buyit/constants.dart';
import 'package:buyit/models/product.dart';
import 'package:buyit/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderDetails extends StatelessWidget {
  static String id = "Order Details";
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrdersDetails(documentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.docs) {
              products.add(Product(
                pName: doc.data()[kProductName],
                pQuantity: doc.data()[kProductQuantity],
                pCategory: doc.data()[kProductCategory],
              ));
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        color: kSecondryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Product name : ${products[index].pName}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Quantity = ${products[index].pQuantity}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Category = ${products[index].pCategory}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ButtonTheme(
                          buttonColor: kMainColor,
                          child: RaisedButton(
                              child: Text("Confirm Order"), onPressed: () {}),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ButtonTheme(
                          buttonColor: kMainColor,
                          child: RaisedButton(
                              child: Text("Delete Order"), onPressed: () {}),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
