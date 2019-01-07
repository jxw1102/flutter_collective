import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

class Product {
  final String id;
  final String name;
  final Price price;
  final Price initialPrice;
  final String description;
  final int likeCount;
  final List<Picture> pictures;
  final String color;
  final String brand;
  final String material;
  final String condition;
  final String universe;
  final String category;
  final String model;
  final Seller seller;
  final List<String> tags;

  bool get welove => tags.contains("welove");
  bool get vintage => tags.contains("vintage");

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = Price.fromJson(json['price']),
        initialPrice = json['price'] != null ? Price.fromJson(json['price']) : null,
        description = json['description'],
        likeCount = json['likeCount'],
        pictures = (json['pictures'] as Iterable)
            .map((pic) => Picture.fromJson(pic))
            .toList(),
        color = json['color']['name'],
        brand = json['brand']['name'],
        material = json['material']['name'],
        condition = json['condition']['description'],
        universe = json['universe']['name'],
        category = json['category']['name'],
        model = json['model'] != null ? json['model']['name'] : null,
        seller = Seller.fromJson(json['seller']),
        tags = json['tags'] != null ? List<String>.from(json['tags']) : [];

  @override
  String toString() {
    return 'Product{id: $id, name: $name, color: $color}';
  }
}

class Price {
  final String currency;
  final int cents;
  final String formatted;

  Price.fromJson(Map<String, dynamic> json)
      : currency = json['currency'],
        cents = json['cents'],
        formatted = json['formatted'];
}

class Picture {
  final String path;

  Picture.fromJson(Map<String, dynamic> json) : path = json['path'];

  String get productUrl => "http://vestiairecollective.imgix.net/produit/$path?auto=format&fit=crop&w=400";

  @override
  String toString() {
    return 'Picture{path: $path}';
  }
}

class Seller {
  final String id;
  final String firstname;
  final Picture picture;

  Seller.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstname = json['firstname'],
        picture = Picture.fromJson(json['picture']);
}

class ProductResponse {
  Product data;

  ProductResponse.fromJson(Map<String, dynamic> json)
      : data = Product.fromJson(json['data']);
}

Future<Product> fetchProduct() async {
  final productId = '6745313'; // 6786789
  final response = await http.get(
      'https://apiv2.vestiairecollective.com/products/${productId}?isoCountry=FR',
      headers: {
        "X-VC-SiteId": "1",
        "X-VC-Language": "fr",
        "X-VC-Currency": "EUR"
      });
  print(response.body);
  final responseJson = json.decode(response.body);
  return ProductResponse.fromJson(responseJson).data;
}
