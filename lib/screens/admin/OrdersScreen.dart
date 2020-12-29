import 'package:buyit/constants.dart';
import 'package:buyit/models/order.dart';
import 'package:buyit/screens/admin/order_details.dart';
import 'package:buyit/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static String id = "OrderScreen";
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            Center(
              child: Text("There is no orders"),
            );
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.docs) {
              orders.add(Order(
                documentId: doc.id,
                totallPrice: doc.data()[kTotalPrice],
                address: kAddress,
              ));
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, OrderDetails.id,
                      arguments: orders[index].documentId),
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
                            "Total Price = \$ ${orders[index].totallPrice}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Address is ${orders[index].address}",
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
            );
          }
        },
      ),
    );
  }
}
