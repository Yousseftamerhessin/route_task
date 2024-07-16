import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:route_task/app/end_points.dart';
import 'package:route_task/data/response/products/products_model.dart';

abstract class BaseProductServices {
  Future<List<Products>> getProducts();
}

class ProductsServices implements BaseProductServices {
  @override
  Future<List<Products>> getProducts() async {
    List<Products> products = [];
    try {
      var url = Uri.https(EndPoints.baseUrl, EndPoints.products);
      http.Response response = await http.get(url, headers: {});
      var data = jsonDecode(response.body);
      print(response.body);
      for (int i = 0; i < data['products'].length; i++) {
        products.add(Products.fromJson(data['products'][i]));
      }
      return products;
    } catch (e) {
      debugPrint(e.toString());
      return products;
    }
  }
}
