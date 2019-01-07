import 'package:flutter/material.dart';
import 'product.dart';

class ProductInfoWidget extends StatelessWidget {

  final Product _product;

  ProductInfoWidget(this._product);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.body1;
    return Container(
        color: Color(0xfffafafa),
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_product.price.formatted, style: textStyle),
            Text(_product.condition, style: textStyle),
            Text("${_product.material} ${_product.color}", style: textStyle),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Divider(height: 1.0, color: Color(0xffeaeaea)),
            )
          ],
        )
    );
  }

}
