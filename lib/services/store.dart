import 'package:buyit/constants.dart';
import 'package:buyit/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _firestore.collection(kProductCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductDescription: product.pDescription,
      kProductCategory: product.pCategory,
      kProductLocation: product.pLocation,
    });
  }

  Future<List<Product>> loadProduct() async {
    var snapshot = await _firestore.collection(kProductCollection).get();
    List<Product> products = [];
    for (var doc in snapshot.docs) {
      var data = doc.data();
      products.add(Product(
        pName: data[kProductName],
        pPrice: data[kProductPrice],
        pDescription: data[kProductDescription],
        pCategory: data[kProductCategory],
        pLocation: data[kProductLocation],
      ));
    }
    return products;
  }
}
