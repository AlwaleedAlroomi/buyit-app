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

  Stream<QuerySnapshot> loadProduct() {
    return _firestore.collection(kProductCollection).snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(kProductCollection).doc(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore.collection(kProductCollection).doc(documentId).update(data);
  }
}
