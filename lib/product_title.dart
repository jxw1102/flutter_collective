import 'package:flutter/material.dart';
import 'product.dart';

class ProductTitleWidget extends StatelessWidget {
  final Product _product;

  ProductTitleWidget(this._product);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _product.brand,
            style: theme.textTheme.title,
          ),
          Text(
            _product.name.toUpperCase(),
            style: theme.textTheme.headline,
          ),
          SizedBox(height: 5.0),
          Row(children: _product.tags.map((tag) => createTag(tag, theme)).toList())
        ],
      ),
    );
  }

  Widget createTag(String tag, ThemeData theme) {
    return new Container(
      margin: const EdgeInsets.only(top: 4.0, right: 4.0, bottom: 4.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
      ),
      child: Text(tag.toUpperCase(), style: theme.textTheme.body2.copyWith(fontSize: 9.0)),
    );
  }

}
