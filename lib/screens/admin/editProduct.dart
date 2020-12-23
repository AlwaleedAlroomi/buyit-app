import 'package:buyit/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buyit/services/store.dart';
import 'package:buyit/constants.dart';

class EditProduct extends StatefulWidget {
  static String id = "EditProduct";

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                products.add(Product(
                  pName: data[kProductName],
                  pPrice: data[kProductPrice],
                  pDescription: data[kProductDescription],
                  pCategory: data[kProductCategory],
                  pLocation: data[kProductLocation],
                ));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: .8),
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTapUp: (details) {
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double dx2 = MediaQuery.of(context).size.width - dx;
                      double dy2 = MediaQuery.of(context).size.width - dy;
                      showMenu(context: context, position: RelativeRect.fromLTRB(dx, dy, dx2, dy2), items: [
                        PopupMenuItem(
                          child: Text("Edit"),
                        ),
                        PopupMenuItem(
                          child: Text("Delete"),
                        ),
                      ]);
                    },
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
          }),
    );
  }
}
