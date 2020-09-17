class Product {
  final String productId;
  final String name;
  final double price;

  Product({this.productId, this.name, this.price});

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
    };
  }

  Product.fromFireStore(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        name = firestore['name'],
        price = firestore['price'];
}
