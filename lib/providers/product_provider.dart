import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/product.dart';
import 'package:flutter_firebase/services/firestore_services.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = FireStoreService();
  var uuid = Uuid();
  String _name;
  double _price;
  String _productId;

  String get name => _name;
  double get price => _price;
  String get productId => _productId;

  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  setProductValues(Product product) {
    _name = product.name;
    _price = product.price;
    _productId = product.productId;
  }

  saveProduct() {
    firestoreService.saveProduct(
      Product(
        name: _name,
        price: _price,
        productId: _productId == null ? uuid.v4() : _productId,
      ),
    );
  }

  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}
