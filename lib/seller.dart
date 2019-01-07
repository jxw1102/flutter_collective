import 'package:flutter/material.dart';
import 'product.dart';

class SellerWidget extends StatelessWidget {

  Seller _seller;

  SellerWidget(this._seller);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage('http://vestiairecollective.imgix.net${_seller.picture.path}'),
          fit: BoxFit.fill
        )
      ),
    );
  }

}