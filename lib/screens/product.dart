import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/product.dart';
import 'package:flutter_firebase/screens/edit_products.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProdcuts(),
                ),
              );
            },
          )
        ],
      ),
      body: (products != null)
          ? ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ListTile(
                  title: Text(product.name != null ? product.name : '-'),
                  trailing: Text(
                      product.price != null ? product.price.toString() : '-'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditProdcuts(
                          product: product,
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
