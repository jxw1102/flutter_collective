import 'package:flutter/material.dart';
import 'product.dart';

class ProductDescriptionWidget extends StatelessWidget {

  final Product _product;

  ProductDescriptionWidget(this._product);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      color: Color(0xfffafafa),
      padding: EdgeInsets.all(20.0),
      child: Text(
        _product.description,
        style: theme.textTheme.body1
      )
    );
  }

}
