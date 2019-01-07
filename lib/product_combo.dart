import 'package:flutter/material.dart';
import 'product.dart';
import 'product_info.dart';
import 'product_title.dart';
import 'seller.dart';
import 'custom_layout.dart';

class ProductComboWidget extends StatelessWidget {
  final Product _product;

  ProductComboWidget(this._product);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 600),
      child: CustomLayout(
        alignment: HorizontalAlignment.right,
        margin: 20,
        children: <Widget>[
          ProductTitleWidget(_product),
          ProductInfoWidget(_product),
          SellerWidget(_product.seller),
        ],
      ),
    );
  }
}
