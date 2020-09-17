import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/product.dart';

class FireStoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveProduct(Product product) {
    return _db
        .collection('products')
        .document(product.productId)
        .setData(product.toMap());
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (document) => Product.fromFireStore(
                  document.data,
                ),
              )
              .toList(),
        );
  }

  Future<void> removeProduct(String productId) {
    return _db.collection('products').document(productId).delete();
  }
}
