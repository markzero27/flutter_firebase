import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/product.dart';
import 'package:flutter_firebase/providers/product_provider.dart';
import 'package:provider/provider.dart';

class EditProdcuts extends StatefulWidget {
  final Product product;

  const EditProdcuts({Key key, this.product}) : super(key: key);

  @override
  _EditProdcutsState createState() => _EditProdcutsState();
}

class _EditProdcutsState extends State<EditProdcuts> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void initState() {
    if (widget.product == null) {
      // New Record
      nameController.text = '';
      nameController.text = '';
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.setProductValues(Product());
      });
    } else {
      // Update Controllers
      nameController.text = widget.product.name;
      priceController.text = widget.product.price.toString();
      // Update State
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.setProductValues(widget.product);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Product Name',
              ),
              onChanged: (value) => productProvider.changeName(value),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Product Price',
              ),
              onChanged: (value) => productProvider.changePrice(value),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                productProvider.saveProduct();
                Navigator.of(context).pop();
              },
              color: Colors.blue[200],
            ),
            (widget.product != null)
                ? RaisedButton(
                    child: Text('Delete'),
                    onPressed: () {
                      productProvider.removeProduct(widget.product.productId);
                      Navigator.of(context).pop();
                    },
                    color: Colors.red[400],
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
