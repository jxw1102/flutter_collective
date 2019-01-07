import 'dart:async';

import 'package:flutter/material.dart';

import 'product.dart';
import 'product_description.dart';
import 'product_pictures.dart';
import 'product_combo.dart';

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => new _ProductPageState(fetchProduct());
}

class _ProductPageState extends State<ProductPage> {

  Future<Product> product;

  _ProductPageState(this.product);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text(""),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.blue,
              onPressed: () { print("show cart"); })
          ],
        ),
        body: Center(
          child: FutureBuilder<Product>(
              future: product,
              builder: (future, snapshot) {
                print(snapshot.data); // ! this is the product object
                List<Widget> widgets = [];
                if (snapshot.hasData) {
                  widgets = [
                    ProductPicturesWidget(pictures: snapshot.data.pictures),
                    ProductComboWidget(snapshot.data),
                    ProductDescriptionWidget(snapshot.data),
                  ];
                } else {
                  widgets = [
                    Center(child: Text("Loading"))
                  ];
                }
                return ListView(children: widgets);
              }
          ),
        )
    );
  }
}
